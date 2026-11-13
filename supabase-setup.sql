-- FinanceMonthly: run this once in your Supabase project (SQL Editor -> New query -> Run).
-- One table holds every record. Row Level Security makes each row readable/writable only by the
-- signed-in user who owns it, so the publishable key in the app can't read anyone's data on its own.

create table if not exists public.fm_items (
  user_id    uuid    not null default auth.uid() references auth.users (id) on delete cascade,
  id         text    not null,
  kind       text    not null check (kind in ('profile', 'tx', 'sched')),
  data       jsonb   not null,
  updated_at bigint  not null,
  deleted    boolean not null default false,
  primary key (user_id, id)
);

alter table public.fm_items enable row level security;

drop policy if exists "fm_items select own" on public.fm_items;
drop policy if exists "fm_items insert own" on public.fm_items;
drop policy if exists "fm_items update own" on public.fm_items;
drop policy if exists "fm_items delete own" on public.fm_items;

create policy "fm_items select own" on public.fm_items for select to authenticated using (auth.uid() = user_id);
create policy "fm_items insert own" on public.fm_items for insert to authenticated with check (auth.uid() = user_id);
create policy "fm_items update own" on public.fm_items for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "fm_items delete own" on public.fm_items for delete to authenticated using (auth.uid() = user_id);

-- Signed-in users only; the anonymous role gets nothing.
revoke all on public.fm_items from anon;
grant select, insert, update, delete on public.fm_items to authenticated;
