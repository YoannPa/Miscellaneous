
library(data.table)
library(ggplot2)

speedtest_logs <- readLines(con = file("log_speedtest.txt", open = "r"))

speedtest_logs[speedtest_logs == ""] <- "STOP"
speedtest_logs <- paste(speedtest_logs, collapse = "\n")
speedtest_logs <- strsplit(x = speedtest_logs, split = "STOP")
speedtest_logs <- unlist(speedtest_logs)
# Get dates and format
# Help here for format: https://jeffkayser.com/projects/date-format-string-composer/index.html
speedtest_dates <- gsub(
  pattern = "^\\n*(.+)\\s\\+\\d+\\nRetrieving.+", replacement = "\\1",
  x = speedtest_logs)
speedtest_dates [speedtest_dates %like% "HTTP Error 429"] <- NA
speedtest_dates <- as.POSIXlt(x = speedtest_dates, format = "%a, %d %b %Y %H:%M:%S")

# Get download speed and format
speedtest_dl <- gsub(
  pattern = "^.+Download\\:\\s(\\d+\\.\\d+)\\s.+$", replacement = "\\1",
  x = speedtest_logs)
speedtest_dl[speedtest_dl %like% "Errno -3"] <- NA
speedtest_dl[speedtest_dl %like% "urlopen error timed out"] <- NA
speedtest_dl[speedtest_dl %like% "Failed to retrieve list of speedtest.net servers"] <- NA
speedtest_dl[speedtest_dl %like% "HTTP Error 429"] <- NA
speedtest_dl[speedtest_dl %like% "HTTP Error 503"] <- NA
speedtest_dl[speedtest_dl %like% "Retrieving speedtest.net configuration"] <- NA
speedtest_dl <- as.numeric(speedtest_dl)
# Get upload speed and format
speedtest_up <- gsub(
  pattern = "^.+Upload\\:\\s(\\d+\\.\\d+)\\s.+$", replacement = "\\1",
  x = speedtest_logs)
speedtest_up[speedtest_up %like% "Errno -3"] <- NA
speedtest_up[speedtest_up %like% "Failed to retrieve list of speedtest.net servers"] <- NA
speedtest_up[speedtest_up %like% "HTTP Error 429"] <- NA
speedtest_up[speedtest_up %like% "Could not retrieve speedtest.net configuration"] <- NA
speedtest_up[speedtest_up %like% "Retrieving speedtest.net configuration"] <- NA
speedtest_up <- as.numeric(speedtest_up)
# Create speedtest data.table logs
dt_logs <- data.table(
  "Time & dates" = speedtest_dates, "Download speed (Mbits/s)" = speedtest_dl,
  "Upload speed (Mbits/s)" = speedtest_up)

# Plots
ggplot(data = dt_logs, mapping = aes(x = `Time & dates`, y = `Download speed (Mbits/s)`)) +
  geom_point()
ggplot(data = dt_logs, mapping = aes(x = `Time & dates`, y = `Upload speed (Mbits/s)`)) +
  geom_point()
