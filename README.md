# DigiGEM v1 — *Digitalis lanata* genome-scale metabolic model

**DigiGEM** is a compartmentalized genome-scale metabolic model of *Digitalis lanata* (foxglove), developed to investigate cardenolide biosynthesis, its metabolic cost, and growth–defense tradeoffs.

This repository distributes the model described in the manuscript **“The Foxglove Genome-Scale Metabolic Model Reveals the Cost of Herbivory Defense”**, by Rachael Hageman Blair, Emily Carroll, Tiange Shi, and Zhen Q. Wang. The manuscript is currently submitted (journal not specified).

## Files

| Path | Description |
| --- | --- |
| [`model/DigiGEM_v1.xml`](model/DigiGEM_v1.xml) | SBML model, Level 3 Version 1 with FBC extension |
| [`model/DigiGEM_v1.mat`](model/DigiGEM_v1.mat) | MATLAB/COBRA Toolbox model |
| [`scripts/DigiGEM_v1_demo.m`](scripts/DigiGEM_v1_demo.m) | MATLAB example for FBA, FVA, and reaction knockout |
| [`model/ORIGINAL_README.txt`](model/ORIGINAL_README.txt) | Original documentation supplied with the model |
| [`docs/index.html`](docs/index.html) | GitHub Pages project landing page (with separate downloadable copies of the model files in `docs/downloads/`) |

## Model overview

The supplied SBML file contains **1,655 reactions** and **1,767 metabolites**. The model extends a plant primary-metabolism reconstruction with *Digitalis*-related cardenolide, steroid, brassinosteroid, and terpenoid pathways.

The SBML model specifies the following weighted objective, maximizing biomass and cardenolide-pathway flux:

| Reaction ID | Weight |
| --- | ---: |
| `BIO_L` | 693 |
| `Add_Card13_c` | 100 |
| `Add_Card14_c` | 100 |
| `Add_Card15_c` | 100 |

The relative per-reaction weight is 100/693 ≈ 0.144. Consult the manuscript for the rationale and biological interpretation.

## Reproducing an example analysis

Requires MATLAB, COBRA Toolbox (v3 or compatible), and a configured optimization solver. The demonstration script was supplied by the authors; its execution was **not verified** in preparing this repository.

```matlab
initCobraToolbox(false); % if not initialized
cd('model');
addpath('../scripts');
DigiGEM_v1_demo
```

The script loads the `.mat` model, sets the weighted objective, performs flux balance analysis and flux variability analysis, and simulates a reaction knockout (`Add_Card20_c`). Run from the `model` directory because the script loads `DigiGEM_v1.mat` from the current working directory.

## Citation and persistence

**Suggested manuscript citation:** Hageman Blair, R., Carroll, E., Shi, T., & Wang, Z. Q. (2026). *The Foxglove Genome-Scale Metabolic Model Reveals the Cost of Herbivory Defense*. Manuscript submitted.

No journal or DOI is listed while the manuscript is under review. A permanent dataset DOI may be added later if the repository is archived; no database accession number has been issued.

## Important metadata note before publication

Although the supplied file is named `DigiGEM_v1.xml`, its SBML `<model>` identifiers currently read `id="M_AraC4_2011"` and `name="C4GEM_v3"`. This may reflect an earlier reconstruction. The submitted model files have been preserved **byte-for-byte**. The authors should verify whether the internal metadata should be updated and the SBML revalidated before public release.

## License

This repository is released under the **MIT License**. See [LICENSE](LICENSE) for the full terms. This license applies to the repository files to the extent that the DigiGEM contributors hold the necessary rights; confirm coauthor and any third-party rights before distributing the model under this license.
