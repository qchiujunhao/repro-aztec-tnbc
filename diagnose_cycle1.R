suppressMessages({library(readxl); library(dplyr); library(stringr)})
d <- read_excel("FACS_data.xlsx", "facs data")
d <- d %>% mutate(Timepoint = str_extract(`Batch number`, ".+(?= B)"))
cat("rows per timepoint:\n"); print(table(d$Timepoint, useNA = "ifany"))
for (v in c("CD8:PD-1", "CD4:PD-1", "CD8:PD1+ TCF1+ (Tpex)", "CD8:EOMES", "CD4:EOMES")) {
  if (!v %in% names(d)) { cat("no column", v, "\n"); next }
  cat("\n", v, " class:", class(d[[v]]), " non-NA per timepoint:\n")
  print(tapply(!is.na(d[[v]]), d$Timepoint, sum))
}
raw <- read_excel("FACS_data.xlsx", "facs data", col_types = "text")
raw <- raw %>% mutate(Timepoint = str_extract(`Batch number`, ".+(?= B)"))
cat("\nCycle 1 cells of CD8:PD-1 that are non-empty as text but NA when read as numeric:\n")
idx <- which(raw$Timepoint == "Cycle 1")
bad <- idx[!is.na(raw$`CD8:PD-1`[idx]) & is.na(d$`CD8:PD-1`[idx])]
print(raw[bad, c("Batch number", "Patient", "CD8:PD-1")])
cat("\nall Cycle 1 CD8:PD-1 raw text values:\n"); print(raw$`CD8:PD-1`[idx])
