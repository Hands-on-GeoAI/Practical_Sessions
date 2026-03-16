```sh
cd /scratch/project_2018216/

git clone https://github.com/Hands-on-GeoAI/Jupyter_Puhti.git

cd Jupyter_Puhti
module load tykky
mkdir -p /projappl/project_2018216/handson-geoai
conda-containerize new --prefix /projappl/project_2018216/handson-geoai  handson-geoai-env.yml  #  Installation can take a while
```

Every Practical session just open the `NMRLipids-course.lua` and change it to the relevant ipynb file. Then run following script

```sh
mkdir -p /projappl/project_2018216/www_puhti_modules && cp NMRLipids-course-resources.yml NMRLipids-course.lua /projappl/project_2018216/www_puhti_modules
```