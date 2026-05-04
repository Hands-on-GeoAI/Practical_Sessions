#!/bin/bash
#SBATCH --account=project_2018216
#SBATCH --partition=gpumedium
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=128
#SBATCH --time=4:00:00
#SBATCH --gres=gpu:a100:4

# Download ollama models to scratch rather than the home directory
OLLAMA_SCRATCH=/scratch/project_2018216/ollama
export OLLAMA_MODELS=${OLLAMA_SCRATCH}/models

# Add ollama installation dir to PATH /projappl/project_2018216
export PATH=/projappl/project_2018216/ollama/bin:$PATH

# Bind to all interfaces so the login node (or your laptop via tunnel)
# can reach it. Default 11434 may collide on shared nodes, pick a port.
export OLLAMA_HOST=0.0.0.0:11434

# Keep models resident for the whole job, no 5 min eviction.
export OLLAMA_KEEP_ALIVE=-1

# Direct ollama server's outputs to a separate log file
mkdir -p ${OLLAMA_SCRATCH}/logs
ollama serve > ${OLLAMA_SCRATCH}/logs/${SLURM_JOB_ID}.log 2>&1 &

# Capture process id of ollama server
OLLAMA_PID=$!

# Wait to make sure Ollama has started properly
until curl -sf http://localhost:11434/ > /dev/null; do
    sleep 1
done

# pull some models
ollama pull llama3.1:8b
ollama pull gemma4
ollama pull qwen3.5

# show the available models in the logs
ollama list

# Print the endpoint so you know where to send curl from outside.
echo "Ollama ready at http://$(hostname):11434"
echo "From a login node:  curl http://$(hostname):11434/api/tags"
echo "Job will hold the server until walltime (${SLURM_JOB_ID})."

# Block here. The trap kills the server when SLURM signals the job.
wait $OLLAMA_PID