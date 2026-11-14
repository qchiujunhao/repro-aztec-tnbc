"""Pull every p-value (with its section) out of the knitted tables into a CSV, so the rerun check
compares numbers rather than the markdown's bytes (which carry sessionInfo)."""
import csv, re, sys
src, dst = sys.argv[1], sys.argv[2]
rows, section = [], ""
for line in open(src, encoding="utf-8"):
    if line.startswith("#"):
        section = line.strip("# \n")
        continue
    m = re.match(r"## (\d+)\s+(.*)", line)
    if m and ("Wilco" in line):
        toks = line.split()
        i = next(k for k, t in enumerate(toks) if t.startswith("Wilco"))
        rows.append((section, int(m.group(1)), float(toks[i - 3])))
    m = re.match(r"## \[1\] (0\.\d+)$", line.strip() + "")
    if m and "AUC" in section:
        rows.append((section, 1, float(m.group(1))))
with open(dst, "w", newline="") as fh:
    w = csv.writer(fh); w.writerow(["section", "row", "p_value"]); w.writerows(rows)
print(f"{len(rows)} values -> {dst}")
