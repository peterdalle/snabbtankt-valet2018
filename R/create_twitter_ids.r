# Create a file with Twitter ID's from the data frames,
# in compliance with the Twitter terms of service.
#
# Note: Run the analysis.rmd file first since the
# "df" and "df_2017" data frames are needed.


write_twitter_ids_to_csv_file <- function(filename, ids) {
  ids <- format(ids, scientific=FALSE)
  write.table(ids, filename, row.names=FALSE, col.names=FALSE, fileEncoding="UTF-8", quote=FALSE)
}

write_twitter_ids_to_csv_file("tweets-june-july-august-2017.txt", df_2017$id)
write_twitter_ids_to_csv_file("tweets-june-july-august-2018.txt", df$id)