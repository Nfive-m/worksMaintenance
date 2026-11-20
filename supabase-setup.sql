-- WorkOrder Supabase authentication setup
-- Run this entire script in Supabase Dashboard -> SQL Editor.
-- Every new account is forced to USER; browser metadata cannot choose a role.

create schema if not exists private;
revoke all on schema private from public, anon, authenticated;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text not null default '',
  role text not null default 'USER'
    check (role in ('USER', 'TECHNICIAN', 'ADMIN')),
  department text,
  phone text,
  technician_id text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.profiles enable row level security;

drop policy if exists "Users can read their own profile" on public.profiles;
create policy "Users can read their own profile"
on public.profiles for select to authenticated
using ((select auth.uid()) = id);

drop policy if exists "Users can update their own contact profile" on public.profiles;
create policy "Users can update their own contact profile"
on public.profiles for update to authenticated
using ((select auth.uid()) = id)
with check ((select auth.uid()) = id);

revoke all on public.profiles from anon, authenticated;
grant select on public.profiles to authenticated;
grant update (full_name, department, phone) on public.profiles to authenticated;

create or replace function private.handle_new_workorder_user()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  insert into public.profiles (id, full_name, role)
  values (
    new.id,
    coalesce(new.raw_user_meta_data ->> 'full_name', ''),
    'USER'
  )
  on conflict (id) do nothing;
  return new;
end;
$$;

revoke all on function private.handle_new_workorder_user() from public, anon, authenticated;

drop trigger if exists on_workorder_auth_user_created on auth.users;
create trigger on_workorder_auth_user_created
after insert on auth.users
for each row execute function private.handle_new_workorder_user();

-- Backfill any Auth users that already existed before this trigger was installed.
insert into public.profiles (id, full_name, role)
select
  u.id,
  coalesce(u.raw_user_meta_data ->> 'full_name', ''),
  'USER'
from auth.users u
on conflict (id) do nothing;

-- The earlier prototype policy allowed anonymous users to read/write all rows.
-- This frontend does not use app_records yet, so lock that table down.
drop policy if exists "Temporary prototype access" on public.app_records;
revoke all on table public.app_records from anon, authenticated;

-- FIRST ADMIN: after registering and confirming your own account, replace the
-- email below with your account email and run this statement manually:
--
-- update public.profiles p
-- set role = 'ADMIN', updated_at = now()
-- from auth.users u
-- where p.id = u.id and u.email = 'YOUR_ADMIN_EMAIL@example.com';

-- Promote an approved staff account to TECHNICIAN only after checking the email:
-- update public.profiles p
-- set role = 'TECHNICIAN', technician_id = 'TC-01', updated_at = now()
-- from auth.users u
-- where p.id = u.id and u.email = 'STAFF_EMAIL@example.com';
