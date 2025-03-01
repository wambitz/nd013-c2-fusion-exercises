# Sensor Fusion Exercises

This repo contains the code for demos, exercises, and exercise solutions.

This repository organizes the code by the lessons that they are used in. Each set of code is located in their respective lessons, except for the primary `basic_loop.py` file that can run each exercise.

Please note that certain instructions for each exercise are only provided within the Udacity classroom.

## Example:
All lesson 1 files are in `/lesson-1-lidar-sensor/`.

This directory contains: `examples`, `exercises/starter`, and `exercises/solution`.

## Environment

Udacity students can make use of the pre-configured workspace environment within the classroom. Alternatively, you can create an environment using the `requirements.txt` file included in this repository, using a command like `pip install -r requirements.txt` if you have pip installed, or creating an Anaconda environment in similar fashion.

### Waymo Open Dataset Reader
The Waymo Open Dataset Reader is a very convenient toolbox that allows you to access sequences from the Waymo Open Dataset without the need of installing all of the heavy-weight dependencies that come along with the official toolbox. The installation instructions can be found in `tools/waymo_reader/README.md`. 

### Waymo Open Dataset Files
This course makes use of three different sequences to illustrate the concepts of object detection and tracking. These are: 
- Sequence 1 : `training_segment-1005081002024129653_5313_150_5333_150_with_camera_labels.tfrecord`
- Sequence 2 : `training_segment-10072231702153043603_5725_000_5745_000_with_camera_labels.tfrecord`
- Sequence 3 : `training_segment-10963653239323173269_1924_000_1944_000_with_camera_labels.tfrecord`

To download these files, you will have to register with Waymo Open Dataset first: [Open Dataset – Waymo](https://waymo.com/open/terms), if you have not already, making sure to note "Udacity" as your institution.

Once you have done so, please [click here](https://console.cloud.google.com/storage/browser/waymo_open_dataset_v_1_2_0_individual_files) to access the Google Cloud Container that holds all the sequences. Once you have been cleared for access by Waymo (which might take up to 48 hours), you can download the individual sequences. 

The sequences listed above can be found in the folder "training". Please download them and put the `tfrecord`-files into the `dataset` folder within the repository.

## Troubleshoting

### wxPython

I you cannot install `wxPython` from a vitual environment and get an error you have the following options

1. **Install `libgtk-3-dev`**

   ```bash
   sudo apt install libgtk-3-dev
   ```

   Create your virtual environment

   ```bash
   python3 -m venv .venv
   ```

   Install packages

   ```bash
   pip install -r requirement.txt
   ```

2. **Use a docker container or a `devcontainer`**:
   
   Place the following in a Dockerfile:

   ```dockerfile
   FROM ubuntu:22.04
   RUN apt-get update && apt-get install -y python3 python3-pip python3-venv libgtk-3-dev build-essential
   WORKDIR /app
   ```

   Build container, for example:

   ```bash
   docker build . -t self-driving-car:latest
   ```

   Create your virtual environment

   ```bash
   python3 -m venv .venv
   ```

   Install packages

   ```bash
   pip install -r requirement.txt
   ```

3. **Install mini-conda**

   Download the installer:

   ```bash
   cd ~/Downloads
   wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
   ```

   Run the script

   ```bash
   bash Miniconda3-latest-Linux-x86_64.sh
   ```

   Read and accept the license. When prompted for the installation location, type the following for a local installation (non-sudo or root):

   ```bash
   ~/.local/conda
   ```

   Check if Conda is working:

   ```bash
   conda --version
   ```

   (Optional) Add `conda` to your path:
   
   ```bash
   echo 'PATH="$HOME/.local/conda/bin:$PATH"' >> ~/.profile
   echo 'source $HOME/.local/conda/etc/profile.d/conda.sh' >> ~/.profile
   ```

   Initialize conda:

   ```bash
   conda init
   ```

   Create your virtual environment:

   ```bash
   conda create -n self-driving-car python=3.12
   ```

   Comment out `wxPython` from `requirments.txt` and install the ohter packages:

   ```
   numpy
   opencv-python
   protobuf
   easydict
   # pytorch -> Not used anymore
   torch
   pillow
   matplotlib
   # wxpython
   shapely
   tqdm
   open3d
   ```

   Install deps

   ```bash
   pip install -r requirements.txt
   ```

   Install `wxPython`:

   ```bash
   conda install -c conda-forge wxpython
   ```

### protobuf 

> NOTE: This will drecrease your performance

If you get into runtime errors run this in your terminal:

```bash
export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python 
```






