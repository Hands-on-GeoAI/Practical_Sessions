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