#!/usr/bin/env bash
# setup.sh – One-shot setup script for the GeoAI Practical Sessions environment.
# Logging: all output (stdout + stderr) is written to setup.log in the current
# working directory in addition to the terminal.

set -euo pipefail

# ── Logging ──────────────────────────────────────────────────────────────────
LOG_FILE="$(pwd)/setup.log"
exec > >(tee -a "$LOG_FILE") 2>&1

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"; }

log "=== GeoAI Practical Sessions – Setup started ==="
log "Log file: $LOG_FILE"

# ── Configuration ─────────────────────────────────────────────────────────────
SCRATCH_DIR="/scratch/project_2018216"
PROJAPPL_DIR="/projappl/project_2018216"
REPO_URL="https://github.com/Hands-on-GeoAI/Practical_Sessions.git"
REPO_NAME="Practical_Sessions"
ENV_NAME="GeoAI"
ENV_PREFIX="${PROJAPPL_DIR}/${ENV_NAME}"
MODULES_DIR="${PROJAPPL_DIR}/www_mahti_modules"

# Determine repository root relative to this script so config files are found
# regardless of where the script is called from.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${SCRIPT_DIR}/config"

# ── Step 1: Navigate to scratch and clone the repository ─────────────────────
log "--- Step 1: Clone repository ---"
cd "$SCRATCH_DIR"
log "Working directory: $(pwd)"

if [ -d "$REPO_NAME" ]; then
    log "Repository directory '$REPO_NAME' already exists – skipping clone."
else
    log "Cloning $REPO_URL ..."
    git clone "$REPO_URL"
    log "Clone complete."
fi

cd "$REPO_NAME"
log "Entered repository: $(pwd)"

# ── Step 2: Load tykky module ─────────────────────────────────────────────────
log "--- Step 2: Load tykky module ---"
module load tykky
log "tykky module loaded."

# ── Step 3: Create conda-containerized environment ────────────────────────────
log "--- Step 3: Create conda environment with tykky ---"
mkdir -p "$ENV_PREFIX"
log "Environment prefix: $ENV_PREFIX"
log "Using environment file: ${CONFIG_DIR}/GeoAI-env.yml"
log "Note: Installation can take a while..."
conda-containerize new --prefix "$ENV_PREFIX" "${CONFIG_DIR}/GeoAI-env.yml"
log "Conda environment created."

# ── Step 4: Deploy course modules ─────────────────────────────────────────────
log "--- Step 4: Deploy course module files ---"
mkdir -p "$MODULES_DIR"
log "Copying config files to $MODULES_DIR ..."
cp "${CONFIG_DIR}/GeoAI-course-resources.yml" "${CONFIG_DIR}/GeoAI-course.lua" "$MODULES_DIR"
log "Files copied:"
ls -lh "$MODULES_DIR"

# ── Done ──────────────────────────────────────────────────────────────────────
log "=== Setup complete. ==="
log "To start a practical session:"
log "  1. Edit ${CONFIG_DIR}/GeoAI-course.lua"
log "     and set '_COURSE_NOTEBOOK' to the relevant .ipynb filename."
log "  2. Re-run Step 4 (cp config files) to redeploy the updated module:"
log "     cp ${CONFIG_DIR}/GeoAI-course-resources.yml ${CONFIG_DIR}/GeoAI-course.lua ${MODULES_DIR}"
