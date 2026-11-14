# AZTEC translational biomarkers: reproduction

Do Figures 3 and 4 and Supplementary Figures S4 and S5 of the AZTEC trial (Nat Commun 2026, 10.1038/s41467-026-75660-y) regenerate from the deposited Rmd and source data (Zenodo 10.5281/zenodo.20345790)?

## Findings

- (none declared yet)

## Rerun and check

```bash
bash run.sh                          # regenerate results/ from the declared inputs
python3 analysis/whatran.py check    # rerun from clean, compare with the committed results, mark the graph
```

On every push, `.github/workflows/reproduce.yml` does the same on a fresh clone and publishes `site/`.

## What a pass means

The declared outputs regenerated from the declared inputs and matched the committed references under the comparisons in `whatran.json`. It does not establish scientific correctness or that every method decision was captured.

## Analysis graph

`analysis/graph.json` records what actually ran, including rejected branches. Open it with `python3 analysis/whatran.py open`.
