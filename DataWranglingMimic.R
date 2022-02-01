# ------------------------------------------------------------------------------
# Data organisation - MIMIC
# ------------------------------------------------------------------------------
# October 2021-January 2022
# Pete Arnold
# ------------------------------------------------------------------------------
# We'll be using the tidyverse library for this work for its readability. You
# could use base-R for many of these operations.
#
# It is worth remembering that you can run this file at any time. So think of
# this as the actual instructions to complete your analysis.
# In reality, the extraction of data may take a very long time so you may only
# want to do that occasionally, so you might do that in another file and save
# to a local e.g. CSV file for use in R.
# When we cover R markdown, you will be able to create a Microsoft Word, PDF or
# HTML file from your code, including text and results. That way you could
# rebuild a paper every time you run your analysis (:

# Step 1. Load the tidyverse library.
# ------------------------------------------------------------------------------
library(crayon)     # Used for coloured console text.
library(tidyverse)  # Used for the dataset.

cat(red("\014\012PMIM102J Exercise - Wrangling\n---------------------------------------------------------------\n"))
    
# Step 2. Read data into R.
# ------------------------------------------------------------------------------
# We'll be using the demonstration version of MIMIC-III (see physionet).
# In this case we'll be loading data from a number of CSV files.

# Step 2.1. Load the admissions data.
###admissions = read_csv(file="mimic-iii/admissions.csv")
    
# Review the data file - what do you notice?
head(admissions)

# Step 2.4. Open the files using a path variable.
path <- 'mimic-iii'
admissions <- read_csv(file=paste(path, 'admissions.csv', sep='/'))
cptevents <- read_csv(file=paste(path, 'cptevents', sep='/'))
patients <- read_csv(file=paste(path, 'patients', sep='/'))
d_cpt <- read_csv(file=paste(path, 'd_cpt', sep='/'))
chartevents <- read_csv(file=paste(path, 'chartevents', sep='/'))

head(admissions)
# removes row_id
admissions <- admissions %>% select(-row_id)
head(admissions)

# Step 2.2. Load the cptevents data file.
cptevents <- read_csv(file="mimic-iii/cptevents.csv")



# Review the data file - what do you notice?
head(cptevents)

# Step 2.3. Change column data types to the types you think are appropriate.
# Check with as.tibble() or str().
cptevents <- cptevents %>%
                mutate(cpt_suffix=as.character(cpt_suffix))
head(cptevents)

# Extra note.
# Can you see anything that might be worth simplifying about the file names?
# Can you remember how we join strings together?



# Step 2.5. Get the data dictionary.
<...>

# Leave step 2.6 out as an extra.
# ...............................
# # Step 2.6. Getting 'all' the data.
# # This is a bit 'clever' so don't worry if it doesn't make sense. Ignore it and
# # we can come back to it later. It is just a useful thing if it does make sense.
# # Create a directory file using:
# # dir /b > directory.txt
# dir <- read_lines(file=paste(path, 'directory.txt', sep='/'))
# head(dir)
# # And now we can explore the data with less typing.
# file <- dir[[2]]
# temp <- read_csv(file=paste(path, file, sep='/'))
# cat('Loaded', file, 'into temp.\n')
# head(temp)

# Step 3. Decide on the research question.
# ------------------------------------------------------------------------------
# Decide which data you want to use and load it into R. If you have something
# that interests you, you see how you would approach that problem on this
# dataset. If, not we'll just work our way through. This step would usually
# involve discussions about the clinical details of the conditions of interest,
# the data that is available, ownership etc.

# Step 4. Extract relevant data.
# ------------------------------------------------------------------------------
<...>

# Skip 4.1 as extra content.
# ..........................
# # Step 4.1. Improve this message to compare with what is expected.
# # Note - what does length(chartevents) return?
# n_chartevents <- nrow(chartevents)
# # n_chartevents <- count(chartevents)[[1]]
# E_CHARTEVENTS <- 758355
# if (n_chartevents == E_CHARTEVENTS){
#     cat(green(paste('Chartevent has the expected number (', E_CHARTEVENTS,
#         ') of rows.\n')))
# } else {
#     cat(bgRed(paste('Chartevent has an unexpected number (', n_chartevents,
#         ') of rows (expected', E_CHARTEVENTS, ').\n')))
# }

# Step 4.2. Arrange the data in the table as you want.
<...>

# Step 4.3. Select patients admitted during a specified period.
# Select a range of dates.
# What would be good to check - top and tail?
<...>

# Step 5. Remove bad data.
# ------------------------------------------------------------------------------

# Step 5.1. Review the dataset and note what kind of faults you might find.
#           Write some code to test for that fault and apply it to all the
#           relevant fields.
<...>

# Advanced code to do this as a function.
# .......................................
# # The tricky part of this is that we can't provide the field name as a name, so
# # we provide it as a string and convert the string to a symbol (just like all
# # the other names of fields and functions - effectively we remove the quotes)
# # but then we have to evaluate that symbol when the function is run so that R
# # can work out what it means in context (in whatever environment is being used
# # at the time). This is an advanced feature and not something that most analysts
# # will use but really useful (:
# count_na <- function(df, field){
#     return(nrow(df %>% filter(is.na(eval(sym(field))))))
# }
# n_rows_missing_valueuom <- count_na(chartevents, 'valueuom')
# n_chartevents <- nrow(chartevents)

# And, afterwards, check again.
<...>

# Step 6. Re-organising the data.
# ------------------------------------------------------------------------------

# Step 6.1. Get the census/platform/base file.
# This file will contain one row for every participant in your analysis and
# contain demographic and analytical data.
<...>

# Step 6.2. Keep only the useful variables.
# This makes it easier to work with the table. You can add variables back later
# by changing the list here and re-running your code (but you may need to tweak
# code further on in the file).
<...>

# What about the date of birth and death? Perhaps calculate age at death?
<...>

# Visualise this.
<...>

# How many are affected by this error?
<...>

# Option A: remove bad entries.
# patients <- patients %>%
#    filter(age_at_death < threshold)

# Option B: correct bad entries.
<...>

# Add this to the visualisation.
<...>

# In reality you may bring information from multiple tables together using
# joins. We will cover joins in more detail in SQL later and in a moment when we
# bring in some data from the chartevents table.

# Step 7. Get relevant diagnostic data.
# ------------------------------------------------------------------------------

# Step 7.1. Get the diagnosis data.
<...>

# Step 7.2. Get the diagnosis dictionary.
<...>

# Step 7.3. Find suitable diagnoses.
# In reality you will create a table with reference to clinical expertise.
<...>

# What is the problem with this? And how to fix it?
<...>

# There is a tidier (but more advanced) way to do this by specifying a pattern
# which can get quite precise and complex if you want it to.
<...>

# We just need the codes as a vector.
<...>

# Now we can extract the diabetes diagnoses from the full list.
<...>

# Now we need to join the dates for the admissions associated with the diagnoses.
<...>

# Tidy up by selecting only the columns of interest.
<...>

# Organise the file by admittime but also group the data by subject_id so that
# we can extract values per subject_id.
# Note that hadm_id is not sequential.
<...>

# Now we need to extract the earliest admittime (and call it diabetes_first) and
# latest dischtime (and call it diabetes_last) and we only need those data.
# Question: do we include a 'has-diabetes' column?
<...>

# Finally, we bring this data back into the platform file.
<...>

# If this is only a very small number of patients, you might consider looking
# for something more common and repeating the process for that.

# Step 8. Get relevant risk data.
# We'll try looking for procedures and see if they have affected our diagnoses.
# Since we currently only have a cohort of there are far too few to draw any
# conclusions.
# ------------------------------------------------------------------------------
# Step 8.1. Get the items dictionary.
<...>

# Step 8.2. Find suitable events.
# Again, in reality you will create a table with reference to clinical expertise.
<...>

# We just need the codes as a vector.
<...>

# So now we can get all the blood glucose values.
<...>

# You might extract just the diabetics' data at this point but there isn't that
# much in this dataset, so we'll process this data first, then extract the
# data specifically for our diabetic cases.
# Group by subject id so we can calculate the max and min for each patient and
# arrange by charttime to see the trends.
<...>

# How to get the data in subject ID order then charttime?
<...>

# Now we have a series of data for each patient. What is required will depend on
# the nature of the healthcare issue. As an example, let's select the earliest
# date when the 'warning' flag is raised.
<...>

## Extract data just for our diagnosed diabetic patients.
#diabetic_patients <- diabetes_admissions[['subject_id']]
#bloodglucose <- bloodglucose %>%
#    filter(subject_id %in% diabetic_patients)

# Finally, we bring this data back into the platform file.
<...>

# Step 8.3. Repeat this with systolic and diastolic blood pressure (so that we
#           can try some statistics.
# ------------------------------------------------------------------------------
<...>

# Propose getting the mean systolic BP across all types.
<...>

# Finally, we bring this data back into the platform file.
<...>

# This and the previous section are very similar - this is the point at which to
# start to consider whether you could make a function here?
<...>

# Propose getting the mean systolic BP across all types.
<...>

# Finally, we bring this data back into the platform file.
<...>

# Step 9. Save useful data.
# ------------------------------------------------------------------------------
# We can save and reload useful data in RData format.
<...>

# Step 10. Perform some statistical analyses.
# ------------------------------------------------------------------------------

# Looking at syst_mean and gender so remove any rows with NA for these.
<...>
    
# Attach the new data frame so that we can refer directly to the contents.
<...>

# Plot the ECDF (systolic and diastolic for each gender).
<...>

# Histograms for the same.
<...>

# t-test, systolic BP between genders.
<...>

# t-test, systolic vs diastolic BP.
<...>

# Q-Q plot for systolic and diastolic BP.
<...>

# Scatter plot, correlation test and (looking ahead to PMIM202, a linear
# regression model).
<...>

# Box plot (superimpose the systolic and diastolic pressures for both genders).
<...>

# Plot the systolic vs diastolic pressures and highlight those for patients with
# glucose warning. How does this affect the linear regression?
<...>

# Step 11. Categorise the blood pressure values.
# ------------------------------------------------------------------------------
#            Systolic  /  Diastolic
# Normal =     <120   and    <80
# Elevated =  120-129 and    <80
# Stage 1 =   130-139 or    80-89
# Stage 2 =    >139   or     >89
# Crisis =     >180  and/or  >120

# Step 11.1. Create a factor.
<...>

# Need to re-attach the modified patients table.
<...>

# Check that the data are suitable for chi-squared analysis.
<...>

# Recreate the factors with different cut-offs.
<...>

# Need to re-attach the modified patients table.
<...>

# Check that the data are suitable for chi-squared analysis.
<...>

# Step 11.2. Contingency table, hyperT vs has_glu_warn.
<...>

# Notes
# ------------------------------------------------------------------------------
# We will need to mention factors.
# With the dates, we may need to convert to an actual POSIXct().
# Introduce save data and reload data steps at suitable places in the process.

# Extra: find a positive example.
# There is a tidier (but more advanced) way to do this by specifying a pattern
# which can get quite precise and complex if you want it to.
diag_heart <- dict_icd_diag %>%
    filter(str_detect(short_title, '[Hh]eart|[Cc]oronary|[Mm]yocardial'))
print(diag_heart)

# We just need the codes as a vector.
diagcodes_heart <- diag_heart[['icd9_code']]
print(diagcodes_heart)

# Now we can extract the diabetes diagnoses from the full list.
heart_diagnoses <- diagnoses %>%
    filter(icd9_code %in% diagcodes_heart)

# Now we need to join the dates for the admissions associated with the diagnoses.
heart_admissions <- heart_diagnoses %>%
    inner_join(admissions, by=c('subject_id', 'hadm_id'))

# Tidy up by selecting only the columns of interest.
heart_admissions <- heart_admissions %>%
    select(subject_id, hadm_id, admittime, dischtime, diagnosis,
           hospital_expire_flag, has_chartevents_data)

# Organise the file by admittime but also group the data by subject_id so that
# we can extract values per subject_id.
# Note that hadm_id is not sequential.
heart_admissions <- heart_admissions %>%
    arrange(admittime) %>% group_by(subject_id)

# Now we need to extract the earliest admittime (and call it diabetes_first) and
# latest dischtime (and call it diabetes_last) and we only need those data.
# Question: do we include a 'has-diabetes' column?
heart_admissions <- heart_admissions %>%
    mutate(has_heart=1, admittime=min(admittime), dischtime=max(dischtime)) %>%
    filter(row_number()==1) %>%
    select(subject_id, has_heart, heart_first=admittime, heart_last=dischtime)

# Finally, we bring this data back into the platform file.
patients <- patients %>%
    full_join(heart_admissions, by='subject_id') %>%
    mutate(has_heart=ifelse(is.na(has_heart), 0, has_heart))

detach(patients)
attach(patients)

# Step Extra.2. Contingency table, hyperT vs has_heart.
table(has_heart, hyperT)
barplot(table(table(has_heart, hyperT)), beside=TRUE)
chisq.test(table(has_heart, hyperT))

# Step Extra.3. Look at the labevents file to see if here are some data that
#               are skewed and would benefit from a log transformation.



