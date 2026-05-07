# Vektor — GitHub Pages submission site

Static site for your final course submission. Push this folder to its **own** small GitHub repository (recommended), then turn on **GitHub Pages**.

## One-command publish (recommended)

[`gh`](https://cli.github.com/) is installed on this Mac via Homebrew (`brew install gh` if needed).

1. Authenticate once in Terminal (browser opens):  
   `gh auth login`
2. From this folder (`submission-site`), run:

```bash
./publish-pages.sh
```

Optional repo name:

```bash
./publish-pages.sh my-custom-repo-name
```

The script creates a **public** repo (default name `vektor-final`), pushes `main`, and tries to enable **GitHub Pages** from branch `main` at `/`. If the Pages API step fails (token permissions), use **Settings → Pages** once as described below.

Wait one to two minutes, then open:

`https://<your-github-username>.github.io/<repo>/`

## Before you publish

1. **Confirm your GitHub username** (not your email). Open [github.com/settings/profile](https://github.com/settings/profile). Your site will be at `https://<username>.github.io/<repo>/`.
2. Add PDFs to `pdfs/`:
   - `report_proposal.pdf`
   - `report_midterm.pdf`
   - `report_final.pdf`  
   Or edit the links in `index.html` to match your filenames.
3. Add your demo as `media/demo.mp4` **only if** the file is under GitHub’s per-file size limit (about **100 MB**). Larger files must be hosted elsewhere (see below).

## Large video (over ~100 MB)

Do **not** commit huge videos to Git. Options:

- **YouTube**: Upload as **Unlisted**, then in `index.html` uncomment the YouTube iframe block and replace `VIDEO_ID` with the ID from the video URL (the part after `v=` or the segment after `/embed/`).
- **Google Drive**: Use “Anyone with the link”, then paste that link in `index.html` as a prominent `<a href="...">` above the `<video>` block, or swap the `<video>` section for Drive’s embed snippet.

## Deploy to GitHub Pages

From your machine:

```bash
cd submission-site
git init -b main
git add .
git commit -m "Add GitHub Pages submission site"
```

Create a **new repository** on GitHub (example name: `vektor-final`). Then:

```bash
git remote add origin https://github.com/<YOUR_USERNAME>/<YOUR_REPO>.git
git push -u origin main
```

In GitHub: **Repository → Settings → Pages**

- Build and deployment → **Deploy from a branch**
- Branch: **`main`**, folder: **`/` (root)**
- Save. After a minute, open the Pages URL shown at the top (often `https://<username>.github.io/<repo>/`).

Files `.nojekyll` and `styles.css`, `index.html`, `assets/` are tracked at repo root — no `docs/` subfolder in this layout.

## What to submit to your instructor

Send the **GitHub Pages URL** plus the repo link. Example (replace with your username and repo):  
`https://maheenabooba.github.io/vektor-final/`
