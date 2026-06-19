# GitHub Profile Summarizer (React + Vite + Tailwind)

A clean UI that asks for a GitHub username and summarizes:
- Profile (name, bio, followers, location)
- Public repos (top 20 by stars)
- Languages distribution (pie chart, aggregated across repos)
- Recent commits (approx. via public events)

## Quick Start
```bash
cp .env.example .env   # optional: set VITE_GITHUB_TOKEN to increase rate-limit
npm install
npm run dev
```
Open http://localhost:5173

## Notes
- **Recent commits** are counted from PushEvent payloads in public events (up to last 300 events) and are an approximation.
- **Languages** are aggregated by summing bytes from /repos/{owner}/{repo}/languages across at most VITE_MAX_REPOS repos (default 50).
- Add a **GitHub token** in .env to avoid rate-limit (60/hr → 5000/hr).

## Build
```bash
npm run build
npm run preview
```
<img width="1440" height="810" alt="Screenshot 2025-11-05 at 8 30 23 PM" src="https://github.com/user-attachments/assets/56401f40-e3a8-49af-9939-6d02c7d9db0d" />

## Next steps
- Add Dockerfile + Jenkinsfile for CI/CD
- Cache GitHub responses in localStorage to reduce API calls
# 🧩 GitHub Profile Summarizer

<img width="1440" height="819" alt="Screenshot 2025-11-05 at 8 30 35 PM" src="https://github.com/user-attachments/assets/14b61f35-d4f3-4836-8f3d-251358fc004d" />


A modern **React + Vite + Tailwind** web app that summarizes any GitHub profile beautifully.

It shows:

* 👤 Profile details (name, bio, followers, location)
* 📊 Public repositories (top 20 by stars)
* 🧠 Programming languages distribution (pie chart)
* 🔁 Recent commits (from GitHub activity feed)
* ⚡ Optional: Authenticated requests with GitHub token for higher API limits

---

## 🚀 Quick Start

### 1️⃣ Clone & Setup

```bash
git clone https://github.com/your-username/github-profile-summarizer.git
cd github-profile-summarizer
cp .env.example .env
npm install
npm run dev
```

Then open → [http://localhost:5173](http://localhost:5173)

---

## 🔐 GitHub Token Setup (Avoid Rate Limits)

If you see this error:

```
API rate limit exceeded for <your IP>
```

it means you’re using unauthenticated GitHub requests (limited to 60/hour).

### ✅ Fix:

Generate a **Personal Access Token**:

1. Go to [GitHub → Settings → Developer Settings → Tokens → Fine-grained tokens](https://github.com/settings/tokens)
2. Click **Generate new token (classic)**
3. Give it a name (e.g. `vite-summary-app`)
4. Select scopes:

   * `read:user`
   * `read:repo` *(optional)*
5. Click **Generate token** and copy it (starts with `ghp_...`)

Now update your `.env`:

```bash
VITE_GITHUB_TOKEN=REDACTED_TOKEN
VITE_MAX_REPOS=50
```

Restart your app:

```bash
npm run dev
```

✅ You now get **5000 requests/hour** instead of 60/hour.

---

## 🧰 Tech Stack

* ⚛️ **React 18** (Functional Components + Hooks)
* ⚡ **Vite 5** (super-fast dev build)
* 🎨 **Tailwind CSS 3**
* 📈 **Recharts** (pie chart for languages)
* 🔗 **Axios** (GitHub REST API integration)

---

## 🐳 Docker Support

To build and run as a Docker container:

```bash
docker build -t github-profile-summarizer .
docker run -d -p 8080:80 github-profile-summarizer
```

Visit → [http://localhost:8080](http://localhost:8080)

---

## ⚙️ Jenkins CI/CD Pipeline

The included **Jenkinsfile**:

* Checks out the repo
* Builds the app in Node container
* Builds & pushes Docker image to DockerHub
* Tags with `v<build_number>` and `latest`

Add Jenkins credentials:

* ID: `dockerhub-creds`
* Type: Username + Password (DockerHub)

Update the image name in Jenkinsfile:

```
IMAGE_NAME = "your-dockerhub-username/github-profile-summarizer"
```

---

## 📸 Demo Flow

1. Enter any GitHub username → click “Summarize”
2. View profile summary and stats
3. Inspect charts, repos, and commit counts
4. Authenticate with GitHub token for smoother experience

---

## 🧠 Future Enhancements

* Add GitHub GraphQL API support for faster data
* Cache API responses in `localStorage`
* Add dark mode
* Deploy on AWS EC2 using Nginx container

---

## 📄 License

MIT © 2025 Shubham Gour

---

💡 *Made for YouTube tutorials — easy to explain, easy to extend!*


- Add trending chart for commits over time
