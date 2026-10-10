# GitHub Profile Summarizer

A React web app that takes a GitHub username and produces a one-page summary of
the person's public profile and repositories.

![Profile summary](https://github.com/user-attachments/assets/56401f40-e3a8-49af-9939-6d02c7d9db0d)

## What it shows

- **Profile:** name, bio, followers, location.
- **Repositories:** the top public repositories by stars.
- **Languages:** a pie chart of languages across repositories, weighted by bytes of code.
- **Recent activity:** an approximate commit count, taken from push events in the user's public activity feed (the last 300 events).

## Tech stack

- React 18, built with Vite
- Tailwind CSS for styling
- Recharts for the language chart
- Axios for calls to the GitHub REST API
- Docker (multi-stage build, served by Nginx), and a Jenkinsfile for CI

## Run locally

```bash
npm install
npm run dev
```

Then open http://localhost:5173.

### Optional: GitHub token

Without a token, GitHub limits the app to 60 requests per hour. A token raises this to 5,000.

```bash
cp .env.example .env
# edit .env and set VITE_GITHUB_TOKEN
```

**Security note:** Vite embeds any `VITE_` variable into the JavaScript that
browsers download. A token set this way is visible to anyone who visits the site.
Use it only for local development, with a token that has no permissions. Do not
commit `.env` (it is listed in `.gitignore`), and do not pass a token to
`docker build`.

## Run with Docker

```bash
docker build -t github-profile-summarizer .
docker run --rm -p 8080:80 github-profile-summarizer
```

Then open http://localhost:8080.

The image serves the built app through Nginx. The Nginx config falls back to `index.html`,
so the app's routes work when refreshed.

## Project layout

```
.
├── src/
│   ├── App.jsx                   # Page layout and state
│   ├── main.jsx                  # Entry point
│   ├── services/github.js        # GitHub API calls
│   └── components/               # Search bar, profile card, stat cards, repo list, language chart
├── Dockerfile                    # Multi-stage build: Node to Nginx
├── nginx.conf                    # SPA routing and gzip
├── Jenkinsfile                   # CI pipeline
├── .env.example                  # Settings template (no real values)
└── vite.config.js
```

## Limitations

- The commit count is an estimate. It only covers recent public push events, not a full history.
- Language totals come from the first `VITE_MAX_REPOS` repositories (default 50), to limit API calls.
- The app needs a network connection to the GitHub API and has no caching yet.

## Next steps

- Cache GitHub responses in `localStorage` to reduce API calls.
- Add unit tests for the summary calculations.

## Licence

MIT. See `LICENSE`.
