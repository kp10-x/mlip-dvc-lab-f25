## Actions I took in this Lab:

### Part 1 - Basic DVC Workflow
1. Init DVC: `dvc init`, `git add .dvcignore`, `git commit -m "Initialize DVC"`
2. Setup a local remote storage: `local-remote`
3. Track data using dvc: `dvc add data/raw/data.csv`
   - For this, I had to stop tracking the file with Git: `git rm --cached data/raw/data.csv` and `git commit -m "Stop tracking raw dataset in Git"`
   - Add and track the dvc files with Git: `git add data/raw/.gitignore data/raw/data.csv.dvc` and `git commit -m "Track raw dataset with DVC"`
4. Augment the raw data (add 10 more rows - 569 to 579): `python scripts/augment_data.py`
5. Track the new version (step 3)
6. Switching between versions using Git and DVC:
   - Using git checkout: 
     - `git log --oneline` to get commit history
     - `git checkout <commit-hash>` rolls me back to the old version but the file does not change
     - `dvc checkout` pulls the correct file version for that hash from my local cache **[VERY CRUCIAL SINCE 1. THE FILES WON'T CHANGE BY THEMSELVES - dvc manages the actual data; 2. GIT doesn't change the files - only changes branch]**
7. Train and track model: `dvc add models/classifier.pkl`, `git add models/classifier.pkl.dvc`, `git commit -m "Track trained model with DVC"`

**Note:** Commiting a `.dvc` file stores a pointer to that file, the actual file goes to `dvc`'s cache (In my case - `.dvc/cache/files/md5/*`)

### Part 2 - DVC Pipelines
1. Remove the manual tracking (only the metadata, not the actual file):
   - From Git: `git rm --cached data/raw/data.csv.dvc`, `git rm --cached models/classifier.pkl.dvc`, `git commit -m "Remove manual DVC tracking for pipeline setup"`
   - From DVC: `dvc remove data/raw/data.csv.dvc`, `dvc remove models/classifier.pkl.dvc`
2. Steps 2 and 3 - set up `dvc.yaml` and `params.yaml`
3. Implemented `train.py` and `evaluate.py`
4. Ran the pipeline: `dvc repro`
5. View dependency graph: `dvc dag`

### Part 3 - DVC Experiments
1. Performed 3 different experiments: `make dvc-exp`
2. Compared experiments: `make dvc-exp-show`
3. Applied best experiment name: `make dvc-apply EXP_NAME=<name>`
4. Pushed best experiment to dvc "remote" storage: `make dvc-push EXP_NAME=<name>`

**Note:** Why/When would I use DVC compared to other tools like Weights & Biases/MLFlow - If I need to a fully reproducible, git-native data/model-versioned pipeline (the other options don't have the git-native approach). Other tools like W&B/MLFlow are for when I need more features such as live experiment dashboards, visualizations, and collaboration.
