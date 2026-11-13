# FinanceMonthly

A personal finance app for your MacBook and iPhone: monthly overview, planned and recurring payments, categories with budgets, and trends.

**Your data never goes through Claude or anyone else.** It is saved in the browser on each device. If you want your Mac and iPhone to stay in sync, you can connect your own free Supabase database. Then the data lives in your Supabase account.

## Files

| File | What it is |
|---|---|
| `index.html` | The whole app |
| `manifest.webmanifest`, `sw.js`, `*.png` | Let it install on the Home Screen or Dock and open offline |
| `supabase-setup.sql` | Creates the sync table (only needed if you want sync) |

## 1. Put it online (GitHub Pages, free, about 5 minutes)

The app needs an `https://` address to install properly on iPhone.

1. On GitHub, create a new **public** repository, for example `financemonthly`.
2. Upload all the files from this folder to it (**Add file → Upload files**).
3. Go to **Settings → Pages**. Under **Build and deployment**, set Source to **Deploy from a branch**, Branch to **main**, and folder to **/ (root)**. Then click **Save**.
4. After a minute the app is live at `https://<your-username>.github.io/financemonthly/`.

It's fine for the repository to be public. It contains only the app code: no data and no keys. Your Supabase key is typed into the app on each device, not stored in the code.

## 2. Install it

- **iPhone:** open the address in **Safari**, tap **Share**, then **Add to Home Screen**.
- **Mac:** open it in **Safari** and go to **File → Add to Dock**. In Chrome, use the install icon in the address bar.

Each installed copy keeps its own data. Use the installed app, not a regular Safari tab, so you always see the same data.

## 3. (Optional) Sync between Mac and iPhone with your own Supabase

1. Create a free account at <https://supabase.com> and click **New project**. Pick a region in the EU, for example Frankfurt.
2. In the project, open **SQL Editor → New query**, paste everything from `supabase-setup.sql`, and click **Run**.
3. Go to **Authentication → Sign In / Providers → Email** and turn **off** "Confirm email". This lets you sign in right away.
4. Go to **Project Settings → API Keys** and copy the **Project URL** and the **publishable key** (`sb_publishable_…`). On older projects this is called the *anon public* key. Never use the secret or service_role key.
5. In the app, open **Categories → Set up sync**. Paste the URL and key, enter an email and password, and tap **Create account**.
6. On your other device, open **Set up sync** again with the same URL, key, email and password, and tap **Sign in**.
7. Optional, but a good idea: after both devices are signed in, go to **Authentication → Sign In / Providers** and turn off **Allow new users to sign up**. Then nobody else can create an account in your project. Even without this, Row Level Security already stops anyone from seeing your rows.

How sync works:
- Changes save on the device instantly and work offline.
- The app syncs when you open it, about a second after each change, and every minute while it's open.
- If the same item was edited on both devices, the newest edit wins.
- Supabase pauses free projects after **7 days with no activity**. Using the app keeps it awake. If it does pause, click **Resume project** in the Supabase dashboard. Your data is kept, and the app still works from the copy on the device in the meantime.

## Backups

Under **Categories → Backup** you can:
- **Export** a full `.json` backup.
- **Import** a backup. This merges the backup with what's already in the app and never deletes newer data.
- **Export CSV** of all your transactions for Excel.

If you don't use sync, you can also move data between devices this way: export on one, then AirDrop the file or save it to iCloud Drive and import it on the other.

## Tips

- Press **N** on the Mac to add a transaction.
- On iPhone, data in an installed Home Screen app is kept separate from regular Safari and isn't cleared automatically. Still, export a backup now and then if you don't use sync.
