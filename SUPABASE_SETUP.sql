-- King OS V3.0 cloud sync
create table if not exists public.king_os_state (
  user_id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.king_os_state enable row level security;
create policy "king_os_select_own" on public.king_os_state for select using (auth.uid() = user_id);
create policy "king_os_insert_own" on public.king_os_state for insert with check (auth.uid() = user_id);
create policy "king_os_update_own" on public.king_os_state for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
