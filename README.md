## Repository layout

```
Practical_Sessions/
├── config/                        # Configuration files
│   ├── GeoAI-env.yml              # Conda environment definition
│   ├── GeoAI-course-resources.yml # Course resource settings
│   └── GeoAI-course.lua           # Lua module for each practical session
├── practical-session-1.ipynb      # Practical session notebooks
├── setup.sh                       # Automated setup script (with logging)
└── README.md
```

## One-time environment setup

Run the provided `setup.sh` script.  It automates every step below, logs all
output to `setup.log`, and is safe to re-run (it skips cloning if the
repository directory already exists).

```sh
cd /scratch/project_2018216/
git clone https://github.com/Hands-on-GeoAI/Practical_Sessions.git
cd Practical_Sessions
bash setup.sh
```

### Manual steps (for reference)

```sh
cd /scratch/project_2018216/

git clone https://github.com/Hands-on-GeoAI/Practical_Sessions.git

cd Practical_Sessions
module load tykky
mkdir -p /projappl/project_2018216/GeoAI
conda-containerize new --prefix /projappl/project_2018216/GeoAI config/GeoAI-env.yml  # Installation can take a while
```

## Starting a practical session

Open `config/GeoAI-course.lua` and update the `_COURSE_NOTEBOOK` variable to
point to the relevant `.ipynb` file, then deploy the module files:

```sh
mkdir -p /projappl/project_2018216/www_mahti_modules && \
  cp config/GeoAI-course-resources.yml config/GeoAI-course.lua \
     /projappl/project_2018216/www_mahti_modules
```