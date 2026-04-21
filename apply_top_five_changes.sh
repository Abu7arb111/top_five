#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${1:-.}"
cd "$REPO_DIR"

mkdir -p .github/workflows templates

cat > README.md <<'EORD'
# Top Five

This is a preliminary version of a social media platform called Top Five. The primary function of this website is for users to create posts listing their top five favorite items for a specific category.

## Class Activity Contributors
Ahmad Abu Harb

## Class Activity
For class, please complete the following activity (you may work individually or with a partner/small group):
1. Fork this repository from the course repository
2. Complete the Quickstart Guide for GitHub Actions to add a project build to your forked repository: https://docs.github.com/en/actions/writing-workflows/quickstart
3. Add a custom behavior to work GitHub Action workflow.
4. Make at least four changes (as time allows) to the repository
  * One must be adding you/your teams’ first and last names to the README file.
  * One must be adding a new file describing you/your team’s prior CI/CD experience.
  * Other suggestions to add: UI updates, tests, code improvements, additional functionality, questions about the lecture, etc. (please disclose AI usage)
5. Submit the link to forked repository on Canvas. Complete whatever you finish by the end of class today.

## Changes Made For This Activity
- Added contributor name to the README
- Added a prior CI/CD experience file
- Added an AI usage disclosure file
- Added a GitHub Actions workflow for Python CI
- Improved the homepage UI text and styling

## Run Program

To run the project locally, please use the following commands in your terminal (requires Python installation):

* pip install -r requirements.txt
* python app.py
* Open browser and visit http://127.0.0.1:5000/ (or designated link provided)
EORD

cat > CI_CD_EXPERIENCE.md <<'EOCI'
# Prior CI/CD Experience

Name: Ahmad Abu Harb

I have basic experience using GitHub for version control, including pushing code, working with branches, and managing repositories.

For this class activity, I used GitHub Actions to implement a simple CI workflow that automatically installs dependencies and checks the Python app whenever changes are pushed.

AI was used to help understand GitHub Actions syntax and workflow structure, but all final edits were reviewed before submission.
EOCI

cat > AI_USAGE.md <<'EOAI'
# AI Usage Disclosure

AI tools were used to:
- Help understand the assignment requirements
- Generate a GitHub Actions workflow
- Assist with writing documentation files
- Suggest small UI improvements

All outputs were reviewed and edited before being added to the repository.
EOAI

cat > .github/workflows/python-ci.yml <<'EOYML'
name: Python CI

run-name: ${{ github.actor }} running Top Five CI

on:
  push:
  pull_request:

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repo
        uses: actions/checkout@v5

      - name: Setup Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.11'

      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install -r requirements.txt

      - name: Run syntax check
        run: |
          python -m py_compile app.py

      - name: Custom behavior
        run: |
          echo "Repository: ${{ github.repository }}"
          echo "Branch: ${{ github.ref_name }}"
          echo "Triggered by: ${{ github.actor }}"
EOYML

cat > templates/index.html <<'EOHTML'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Top Five Favorites</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 2em;
            background-color: #f9fafb;
            color: #222;
        }
        .container {
            max-width: 900px;
            margin: 0 auto;
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
        }
        form {
            margin-bottom: 2em;
        }
        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin: 6px 0;
            box-sizing: border-box;
        }
        button {
            padding: 10px 16px;
            cursor: pointer;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f4f4f4;
        }
        .subtitle {
            margin-top: -10px;
            color: #555;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Top Five Favorites</h1>
        <p class="subtitle">Share your top 5 favorite things by category.</p>

        <form method="POST">
            <label for="category">Category:</label><br>
            <input type="text" id="category" name="category" required><br><br>

            <label>Items:</label><br>
            <input type="text" name="item1" placeholder="Item 1" required><br>
            <input type="text" name="item2" placeholder="Item 2" required><br>
            <input type="text" name="item3" placeholder="Item 3" required><br>
            <input type="text" name="item4" placeholder="Item 4" required><br>
            <input type="text" name="item5" placeholder="Item 5" required><br><br>

            <button type="submit">Submit</button>
        </form>

        <h2>Submissions</h2>
        {% if submissions %}
            <table>
                <thead>
                    <tr>
                        <th>Category</th>
                        <th>Items</th>
                    </tr>
                </thead>
                <tbody>
                    {% for submission in submissions %}
                        <tr>
                            <td>{{ submission.category }}</td>
                            <td>{{ ", ".join(submission.five) }}</td>
                        </tr>
                    {% endfor %}
                </tbody>
            </table>
        {% else %}
            <p>No submissions yet!</p>
        {% endif %}
    </div>
</body>
</html>
EOHTML

cat > /tmp/top_five_next_steps.txt <<'EON'
Changes applied.
Now run:
  git add .
  git commit -m "Complete Top Five class activity"
  git push origin main
EON
cat /tmp/top_five_next_steps.txt
