# Run file contents within cardinal project to update the template index

print_ref_templates <- function(fpath) {
  title <- sub("title: ", "", readLines(fpath)[2], )
  subtitle <- sub("subtitle: ", "", readLines(fpath)[3], )
  temp_name <- paste(title, subtitle, sep = " -- ")
  cat(
    paste0("-   ", "[", temp_name, "]", "(", substring(fpath, 10), ")\n\n"),
    file = "./quarto/index-templates.qmd",
    append = TRUE
  )
}

section_header <- function(title) {
  cat(
    paste("", "------------------------------------------------------------------------", "",
      paste0("### ", "**", title, "**"), "",
      sep = "\n"
    ),
    file = "./quarto/index-templates.qmd", append = TRUE
  )
}

create_subsection <- function(fpath) {
  all_files <- list.files(path = fpath, pattern = "*.qmd", full.names = TRUE)
  invisible(sapply(all_files, print_ref_templates))
}

# Create Index Header

cat(
  paste("---", "title: Template Library Index", "---", "", sep = "\n"),
  file = "./quarto/index-templates.qmd"
)

# Tables

section_header("FDA Tables")
create_subsection("./quarto/table-templates")

# Figures

section_header("FDA Figures")
create_subsection("./quarto/figure-templates")
