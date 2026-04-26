# DevOps Practical Execution Task

## 🏗️ Project Overview
This repository serves as a comprehensive demonstration of a modern DevOps lifecycle. It covers the full spectrum from initial Git orchestration and conflict resolution to multi-stage Docker builds, Nginx reverse proxy configuration, and automated CI/CD deployments to Netlify.

---

## 📂 Repository Structure
```text
.
├── Tasks/test-app/
│   ├── client/          # Task 4, 11: Frontend Application (Netlify)
│   ├── server/          # Task 4, 5, 9: Backend API (Node/Express)
│   ├── nginx/           # Task 10: Reverse Proxy Configuration
│   ├── scripts/         # Task 8: Automation Bash Scripts
│   ├── compose.yml      # Task 6: Multi-container Setup (App + DB)
│   └── netlify.toml     # Task 11: Infrastructure as Code for Netlify
├── conflict-test/       # Task 3: Merge Conflict simulation environment
├── .github/workflows/   # Task 7, 14: GitHub Actions CI/CD YAML
└── README.md            # Detailed Documentation & Analysis
```

## 🛠️ Task Implementations

### 1. Git & Branching (Tasks 1 & 2)
I started the repo using git init and pushed it to GitHub. For the workflow, I used main for production, develop for staging, and feature/* branches for development. This is how real team works. I also tried to use proper commit messages like feat: and fix: so the history look clean.

### 2. Fixing Merge Conflicts (Task 3)
I made a intentional conflict in conflict-test/file.txt between my main branch and a conflict-branch. When I run git merge, it show the error.
So I open the file and saw those <<<<<<< and ======= markers. I manually delete the markers and edited the text to keep the correct feature code. Then I just did git add and git commit -m "fix: resolve merge conflict".

### 3. Docker and Optimization (Tasks 4, 5, 6)
I used Multi-stage builds in my Dockerfile so the final image is much smaller. I also change the base image to node:alpine to reduce size and make it more secure. Then I write a compose.yml file to run both Node.js backend and MongoDB database together in the same network.

### 4. Scripts and Security (Tasks 8, 9, 10)
I wrote a simple bash script scripts/deploy.sh so I can stop old containers, clean unused images, and start the new ones with just one command. For security, I don't put my passwords in code. I use .env files locally and GitHub Secrets for CI/CD. Also, I setup Nginx to act as a reverse proxy to take traffic and route it to my backend securely.

### 5. Deploying Frontend (Task 11)
I deployed the frontend on Netlify.
Live URL: https://zippy-marshmallow-16c616.netlify.app/
I had to add a netlify.toml file in the root folder to fix the path problem because my code was deep inside Tasks/test-app/client.

## 🔍 Finding bugs and Logs (Tasks 12 & 13)
How I fixed a big issue:

**The Problem:** Netlify build fail with Exit Code 2 / ENOENT.

**How I checked:** I looked at the Netlify build logs to see what happened.

**What I found:** The Base directory was looking at the root folder, but my package.json was actually inside the Tasks/test-app/client folder.

**How I fix it:** I changed the build context settings in Netlify and my netlify.toml file to point to the correct folder. Then it worked!

## 🏁 Task 15: How the Deployment works (Lifecycle)
Here is how the whole CI/CD pipeline flow works end-to-end:

- **Code (Git):** Developer push the code. Where it break: We get merge conflicts.
- **Build (CI):** GitHub Actions start building it. Where it break: Syntax error or maybe a missing dependency.
- **Test:** Running automatic tests. Where it break: The code logic is wrong.
- **Package (Docker):** It builds the Docker images. Where it break: Image is too big or not secure.
- **Deploy (CD):** Pushing to Netlify or the server. Where it break: Wrong environment variable or network issues.