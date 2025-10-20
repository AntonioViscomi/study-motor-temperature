Study-motor-temperature
===================

# 🤖 ergoCub Motor Temperature Analysis

## 🧭 Overview

This repository is dedicated to the **study and analysis of motor temperature data** collected from the **ergoCub robot**.  
It provides tools, datasets, and documentation that support the evaluation of thermal behavior in the robot’s actuators under different operating conditions.

The analysis aims to:
- 🧠 Understand how temperature evolves during robot operation.  
- 🔍 Identify potential thermal issues or performance limitations.  
- ⚙️ Support the development of improved thermal management and monitoring strategies.

---

## 📂 Repository Structure

- 🧮 **Scripts/** — Contains analysis scripts used to process and visualize temperature data.  
  These scripts can handle temperature dumps collected using either:  
  - the `motorTemperaturePublisher` application  
  - or the `robometry` logging system  

- 📊 **Datasets/** — Includes the most relevant datasets gathered during experiments, covering various joints, conditions, and durations.  

- 📝 **Reports/** *(optional)* — Documents describing the experimental setup, methodology, and key findings.  

---

## 🚀 Usage

### 1️⃣ Data Input
Temperature data can be obtained from:
- [`motorTemperaturePublisher`](https://github.com/robotology/icub-main/tree/master/src/tools/motorTemperaturePublisher) — an application that publishes temperature data in real-time.  
- [`robometry`](https://github.com/robotology/robometry) — the standard logging tool for ergoCub experiments.

### 2️⃣ Analysis
Use the provided scripts to:
- Parse and filter logged data.  
- Plot temperature trends and compute relevant metrics.  
- Compare temperature profiles across different runs or joints.


------
## ⚠️ Notes

🚧 This repository is under continuous development — scripts and datasets may evolve over time.

Please refer to the documentation inside each folder for details on file formats and analysis options.

### 👩‍🔬 Contributors

Maintained by members of the ergoCub development and analysis team.
Contributions and feedback are welcome — feel free to open issues or pull requests.

### 📜 License

