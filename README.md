```sh
cd /scratch/project_2018216/

git clone https://github.com/Hands-on-GeoAI/Practical_Sessions.git

cd Practical_Sessions
module load tykky
mkdir -p /projappl/project_2018216/GeoAI
conda-containerize new --prefix /projappl/project_2018216/GeoAI  GeoAI-env.yml  #  Installation can take a while
```

Every Practical session just open the `GeoAI-course.lua` and change it to the relevant ipynb file. Then run following script

```sh
mkdir -p /projappl/project_2018216/www_mahti_modules && cp GeoAI-* /projappl/project_2018216/www_mahti_modules
```

For the LLMs, use this:
```sh
module load gcc/10.4.0 cuda/12.6.1 # Required for build wheel
nvcc --version

module load tykky # Required for conda-containerize command

# CW_DEBUG_KEEP_FILES --> Don't delete build files when failing.
# CW_LOG_LEVEL --> How verbosely to report program actions --> 3 == debug
CW_DEBUG_KEEP_FILES=1 \
CW_LOG_LEVEL=3 \
conda-containerize new --prefix /projappl/project_2018216/LLM GeoAI-LLM-env.yml
```