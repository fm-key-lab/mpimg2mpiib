# Download data from MPIMG to MPIIB servers
#
# The primary targets in this file are:
#
# all					Fetch data and verify with log
# download_and_check	Fetch data and verify
# clean					Clean up generated files
#
DATA ?= 
REPORT ?= 
RUN_ID ?= 

URLS := $(DATA) $(REPORT)
DATA_DIR := /mnt/rawdata/denovo_data
RUN_DIR := $(DATA_DIR)/$(shell date '+%Y')/$(RUN_ID)
LOGFILE := $(RUN_ID).log

QUIET := @

AWK := awk
GREP := grep -q
MD5SUM := md5sum
MKDIR := mkdir -p
MV := mv -f
RM := rm -f
TEE := tee -a
WGET := wget

.PHONY: all clean

all:
	$(MAKE) download_and_check | $(TEE) $(LOGFILE)
	$(QUIET) "cd $(CURDIR) && make DATA=$(DATA) URL=$(URL) RUN_ID=$(RUN_ID)" > $(LOGFILE)
	$(QUIET) $(MV) $(LOGFILE) $(RUN_DIR)

.PHONY: download_and_check

download_and_check: download fastqs check

download:
	$(WGET) -P $(RUN_DIR) $(URLS)

fastqs:
	$(WGET) -P $(RUN_DIR)/data -i $(RUN_DIR)/$(notdir $(DATA))

check:
	$(MD5SUM) -c $(RUN_DIR)/data*.md5

clean:
	$(QUIET) echo ""