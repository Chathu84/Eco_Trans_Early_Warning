# Nayani Ilangakoon — Portfolio Hub

This repository powers a [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) site that introduces Nayani Ilangakoon's remote-sensing research profile and showcases flagship projects. The documentation doubles as a lightweight knowledge base for the analytical assets that live alongside the site (R scripts, data, and derived outputs).

## 🚀 What you'll find
- **Profile landing page** summarising research interests, current focus areas, and quick ways to connect.
- **Project tabs** for the Eco-Trans Early Warning workflow and companion environmental analytics prototypes.
- **Research assets** in the `scripts/`, `data/`, and `output/` directories that back many of the insights highlighted on the site.

## 🧭 Repository layout
| Path | Purpose |
| --- | --- |
| `docs/` | Markdown sources for the MkDocs site (profile, project pages, and supporting content). |
| `mkdocs.yml` | MkDocs configuration, including navigation tabs for each featured project. |
| `scripts/` | Reproducible R scripts for remote-sensing preprocessing, feature engineering, modelling, and prediction. |
| `data/` | Placeholder directory for raster inputs and auxiliary datasets. |
| `output/` | Location for generated model artefacts, diagnostics, and figures. |

## ▶️ Run the site locally
1. **Install dependencies** (if not already available):
   ```bash
   pip install mkdocs mkdocs-material
   ```
2. **Serve the documentation** and preview changes live:
   ```bash
   mkdocs serve
   ```
3. Open the served address (typically `http://127.0.0.1:8000/`) in your browser.

To produce a static build, run `mkdocs build` and deploy the generated `site/` directory to any static host (e.g., GitHub Pages).

## 🧱 Extending the portfolio
- Edit `docs/index.md` to refresh the landing page biography, featured metrics, or contact links.
- Add a new Markdown file in `docs/projects/` and register it under `nav:` in `mkdocs.yml` to surface another project tab.
- Use MkDocs Material [admonitions](https://squidfunk.github.io/mkdocs-material/reference/admonitions/), [grids](https://squidfunk.github.io/mkdocs-material/reference/grids/), or [cards](https://squidfunk.github.io/mkdocs-material/reference/cards/) for richer storytelling.

## ✨ Legacy research workflow
The portfolio highlights originate from the `Eco_Trans_Early_Warning` research program. Its end-to-end workflow remains available in the `scripts/` folder for anyone interested in reproducing the modelling pipeline or adapting it to new geographies.
