# MGEC Multi-source Geographic Element Classification Code

## Overview

This directory contains the MGEC research code for multi-source geographic-element processing, feature representation, topic clustering, SVM classification, and large-image result annotation. Most components are MATLAB scripts; the directory also includes a C implementation and executable of Fully Sparse Topic Models (FSTM).

This is an archived research-code package. Some data paths, training data, and deep-learning models remain in the original experimental environment, so the workflow is not directly reproducible with a single command.

## Main Components

| Path / File | Purpose |
| --- | --- |
| `gradient.m` | Generates adaptively enhanced image patches for subsequent ResNet-based image-feature extraction. The ResNet code is not included. |
| `pro_GCN.m` | Processes multi-source geographic data and produces community information for geographic elements. |
| `proGAT.m` | Converts community information into inputs for a GAT graph model. The GAT training code is not included. |
| `process.m` | Reads and organizes sample-point information and intermediate feature data. |
| `fstm/` | Source code, executable, example data, and settings for Fully Sparse Topic Models (FSTM), used to cluster two types of features. |
| SVM classification and large-image annotation directory | Scripts for SVM training, testing, accuracy assessment, result visualization, and large-image annotation. |
| Data preprocessing directory | Scripts for generating LDA/FSTM input data and related preprocessing. |

## Suggested Workflow

1. Prepare image patches, sample-point information, labels, and multi-source geographic data.
2. Run `gradient.m` to generate enhanced patches, then extract image features in an external ResNet environment.
3. Run `pro_GCN.m` and `proGAT.m` to obtain geographic-element community information and graph-model features.
4. Use either `Save_data_forLDA.m` script in the data preprocessing or SVM directory to prepare the data required by FSTM.
5. Train and infer the topic model in `fstm/`, for example:

   ```text
   fstm est <model-directory> <training-data> <number-of-topics>
   fstm inf <model-directory> <testing-data>
   ```

6. Combine the FSTM output with other features, then run an appropriate `SVM_*.m` script in the SVM directory for classification.
7. To reconstruct patch-level predictions into a large-image result, refer to `SceneResult.m` in the SVM directory.

## Requirements and Dependencies

- MATLAB for data processing, feature organization, SVM classification, and map generation.
- A C build environment (optional) to rebuild FSTM by running `make` in `fstm/`.
- LIBSVM MATLAB interfaces, included under `libsvm-3.20` and `libsvm-3.23`.
- External components: the complete ResNet and GAT implementations are not included and must be obtained from the original experimental server or replaced with local implementations.

## Configuration Before Use

- Several MATLAB scripts contain absolute paths such as `E:\\experiment\\...`; update them to local data, model, and output locations.
- Check the fixed parameters in each script against the actual number of classes and samples, patch size, and feature dimensions.
- The package does not include the complete raw data, trained deep-learning models, or all intermediate outputs; prepare these resources before running the workflow.

## Useful Entry Points

- `RUN.m` in the SVM directory: calls `Save_data_forLDA` to prepare training and testing data.
- The FSTM command reference file: records previous FSTM training and inference command examples.
- `SceneResult.m` in the SVM directory: processes and visualizes large-image results from overlapping image patches.

The original directory and file names are retained on disk; the English descriptions above identify their roles.

## License Notice

The FSTM component under `fstm/` retains its original GPL license notice. Use the remaining MATLAB scripts only within the applicable research and authorization scope.
