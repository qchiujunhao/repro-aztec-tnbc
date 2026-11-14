# Reproduction: AZTEC trial translational biomarkers

Source: Zenodo 10.5281/zenodo.20345790 (`AZTEC_translational_biomarkers.Rmd`, `Source Data.xlsx`, and the
authors' rendered HTML), for "Single-fraction or multi-fraction stereotactic ablative body radiotherapy
followed by atezolizumab in advanced triple-negative breast cancer: a randomized phase II trial",
Nature Communications 2026, https://doi.org/10.1038/s41467-026-75660-y. Rerun 2026-11-14 with R 4.3.3
(the authors used R 4.5.2), recorded with [whatran](https://github.com/qchiujunhao/whatran).

How it was run: the Rmd reads `FACS_data.xlsx`, so the deposited `Source Data.xlsx` was copied to that
name. Without pandoc, the Rmd was knitted to Markdown with `knitr::knit`, which writes every figure to
`figures/` and every printed table to `figures/AZTEC_translational_biomarkers.md`. The authors' figures,
extracted from their HTML, are in `published/` (`html-img-NN.png`, in document order; the knitted
`knit-unnamed-chunk-(NN+1)-1.png` is the counterpart). `run.sh` reruns it and
`python3 analysis/whatran.py check` verifies it.

## What reproduces exactly

- **Figure 3** (A–G): all eight Wilcoxon p-values and group sizes match the authors' rendering.
- **Tumour TILs**: ROC AUC 0.6194853 (95% CI 0.3051–0.9339), and the logistic model coefficients and
  odds ratios, match to every printed digit.

## What differs

- **Figure 4 and Supplementary Figure S5.** In the deposited data, 42 Cycle 1 samples belong to patients
  in the baseline clinical-benefit set; the authors' figure shows 43. Baseline (45) and Cycle 3 (37)
  agree. Every Cycle 1 comparison therefore shifts: panel A 0.04 → 0.05 and 4×10⁻⁷ → 5.5×10⁻⁷, panel B
  0.09 → 0.13 and 9.3×10⁻⁷ → 1.4×10⁻⁶, panel C RT+ 0.026 → 0.028, panel D RT+ 0.16 → 0.18, panel E RT+
  0.89 → 0.92 (authors → this rerun). The deposited sheet has 47 Cycle 1 rows, of which 5 patients
  (AZ7, AZ13, AZ32, AZ34, AZ47) are outside the clinical-benefit set; one Cycle 1 row that the authors
  had is not in `Source Data.xlsx`. The diagnostic scripts are `diagnose_cycle1.R` and
  `diagnose_patients.R`.
