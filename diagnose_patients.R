suppressMessages({library(readxl); library(dplyr); library(stringr)})
d <- read_excel("FACS_data.xlsx", "facs data") %>% mutate(Timepoint = str_extract(`Batch number`, ".+(?= B)"))
bl <- d %>% filter(Timepoint == "Baseline")
cat("Baseline Clinical_Benefit values:\n"); print(table(bl$Clinical_Benefit, useNA = "ifany"))
cb <- bl %>% filter(Clinical_Benefit %in% c("Y", "N"))
cat("\nbaseline_cb patients:", nrow(cb), "\n")
for (tp in c("Baseline", "Cycle 1", "Cycle 3")) {
  rows <- d %>% filter(Timepoint == tp)
  cat(sprintf("%-9s rows %2d, of which in baseline_cb: %2d  (not: %s)\n", tp, nrow(rows), sum(rows$Patient %in% cb$Patient), paste(setdiff(rows$Patient, cb$Patient), collapse = " ")))
}
cat("\nBaseline patient(s) whose Clinical_Benefit is not Y/N:\n"); print(bl %>% filter(!Clinical_Benefit %in% c("Y","N")) %>% select(Patient, Clinical_Benefit, `Responder Group`) %>% as.data.frame())
cat("Their Cycle 1 / Cycle 3 rows exist?", bl$Patient[!bl$Clinical_Benefit %in% c("Y","N")] %in% d$Patient[d$Timepoint == "Cycle 1"], bl$Patient[!bl$Clinical_Benefit %in% c("Y","N")] %in% d$Patient[d$Timepoint == "Cycle 3"], "\n")
