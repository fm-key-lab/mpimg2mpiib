# mpimg2mpiib

Transfer data from MPIMG servers, verify, and log. Defaults assume MPIIB $\leftarrow$ MPIMG.

## Install

```bash
git clone git@github.com:fm-key-lab/mpimg2mpiib.git
```

## Usage

On MPIIB remotes, use

```bash
cd mpimg2mpiib
make RUN_ID=<run ID> DATA=<weblinks.txt URL> REPORT=<report.html URL>
```

From remotes other than MPIIB or to change download location, also provide a `DATA_DIR`.