# ------------------------------------------------------------------------------
# Statistics - BMI
# ------------------------------------------------------------------------------
# January 2022
# Pete Arnold
# ------------------------------------------------------------------------------
# The following code is one solution to the exercises presented in the lecture
# covered by the notes in Exercise_in_programming_in_R.pptx.
# The aim is to give you a sense of the kind of solution whilst leaving some
# challenges for you to complete. Please replace all <...> with some actual
# code, for example, print(<...>), could be print("Hello, World!").
# ------------------------------------------------------------------------------
library(crayon)     # Used for coloured console text.
library(tidyverse)  # Used for the starwars dataset.

cat(yellow("\014\012PMIM102 Exercise - Statistics\n"))
cat(yellow("---------------------------------------------------------------\n"))

# ------------------------------------------------------------------------------

# Step 1. Calculate BMI.
# bmi =      weight_kg
#       -------------------
#                         2
#       (height_cm / 100) 
# Try it out:
weight_kg <- 78
height_cm <- 175
print(weight_kg / ((height_cm/100) ^ 2))

# ------------------------------------------------------------------------------

# Step 2. Make a function to do this.
# bmi - calculate the body mass index from weight and height.
# @param w_kg numeric The person's weight in kg.
# @param h_cm numeric The person's height in cm.
# @return     numeric The person's BMI.
bmi <- function(w_kg, h_cm) {
    b <- w_kg / ((h_cm/100) ^ 2)
    return (b)
}
print(bmi(weight_kg, height_cm))

print("enter some custom bmis, -1 to quit")
repeat{
  w_kg <- readline(prompt="enter a weight in kg: ")
  w_kg <- as.numeric(w_kg)
  if (is.na(w_kg)){
    stop("That weight was not a number!\n")
  } else if (w_kg == -1) {
    break
  }
  
  h_cm <- readline(prompt="enter a height in cm: ")
  h_cm <- as.numeric(h_cm)
  if (is.na(h_cm)){
    stop("That height was not a number!\n")
  } else if (h_cm == -1) {
    break
  }
  print(bmi(w_kg, h_cm))
}
# ------------------------------------------------------------------------------

# Step 3. Sanity and error checks.
# bmi - Calculate body-mass index
# @param w_kg double Weight in kilograms
# @param h_cm double Height in centimetres
# @return     double BMI
# Note the use of | (compares each row) rather than || (compares first row only).
bmi <- function(w_kg, h_cm) {
    # Check and report errors with any of the input values.
    error <- NA
    b <- w_kg / ((h_cm / 100) ^ 2)
    if (any(w_kg < 2 | w_kg > 650 | h_cm < 50 | h_cm > 280)) {
        error <- "bmi: inputs out of reasonable range."
    } else if (any(b < 15 | b > 40)) {
        error <- "bmi: output out of expected range."
    }
    if (!is.na(error)) print(error)
    # We could also remove these bad data.
    b[which(w_kg < 2 | w_kg > 650 | h_cm < 50 | h_cm > 280)] <- NA
    b[which(b < 15 | b > 40)] <- NA
    # Return the data
    return (b)
}

# Try several pairs of values to get the different responses from the function.
# defining a basic vector is done with 'c'
bmi(650, 100)
bmi(c(250, 70, 100), c(270,170,150))

# Step 3a. Testing code.
# Create a list of the tests you think you need to do to check the function.
# These will include boundaries and random values.
# You will need to supply expected values of the function responses and to
# make sure the actual response matches these.

test_bmi <- function(w, h, expected){
    b <- bmi(w, h)
    if ((is.na(expected) & !is.na(b)) |         # Expect NA but result is a value.
        (is.na(b) & !is.na(expected)) |         # Result NA but expected a value.
        (!is.na(expected) & (b != expected))){  # Result not the expected value.
        cat('bmi test: output not as expected (', b, ' rather than ',
            expected, ').\n')
    }
}
test_bmi(100, 200, 25)
test_bmi(100, 100, 1)

# ------------------------------------------------------------------------------

# Step 4. Work out the BMI values for the Star Wars characters.
# If we start with our original BMI function which doesn't do any checking.
simple_bmi <- function(w_kg, h_cm) {
    b <- w_kg / ((h_cm / 100)^2)
    return (b)
}

head(starwars)
sw <- starwars %>% 
    select(name, gender, height, mass) %>%
    mutate(BMI=simple_bmi(mass, height))
head(sw)

# ------------------------------------------------------------------------------

# Step 5. Create a boxplot of BMI. Create one separating by gender.
boxplot(sw$BMI)
#female <- sw %>% filter(gender=="feminine")
#male <- sw[which(sw$gender=="masculine"), ]
#boxplot(sw$BMI[sw$gender=="feminine"], sw$BMI[sw$gender=="masculine"])
boxplot(sw$BMI ~ sw$gender)

# Find the outlier.
head(sw %>% filter(BMI>=100))
# Remove the outlier (and repeat the above lines).
sw <- sw %>% filter(BMI<100)
boxplot(sw$BMI ~ sw$gender)

# And, if we repeat this with the function that does the checking.
sw <- starwars %>% 
    select(name, height, mass, gender) %>%
    mutate(BMI=bmi(mass, height))
boxplot(sw$BMI ~ sw$gender)

# Step 5b. Create the cumulative distribution plot for the BMI values.
# What extra information have we got here?
plot(ecdf(sw$BMI[sw$gender=="feminine"]),
    main="CDF for BMI by gender",
    xlim=range(sw$BMI, na.rm=TRUE), 
    col="red")
plot(ecdf(sw$BMI[sw$gender=="masculine"]), 
    col="blue",
    add=TRUE)

# Comparing the CDF and boxplot.
# changing the plotting area to allow 2 graphs side by side
par(mfrow=c(2,1))
plot(ecdf(sw$BMI[sw$gender=="feminine"]),
    main="CDF for BMI by gender",
    xlim=range(sw$BMI, na.rm=TRUE), 
    col="red")
plot(ecdf(sw$BMI[sw$gender=="masculine"]), 
    col="blue",
    add=TRUE)
boxplot(sw$BMI ~ sw$gender, col=c("red", "blue"), horizontal=TRUE)

# return plotting area to 1 row and 1 column
par(mfrow=c(1,1))

# Step 5a. Outliers.
# Find out how to define outliers. Are there functions that will detect outliers
# (and remove them)? When should you do this?

# ------------------------------------------------------------------------------
# Intermission - standard deviation.

x <- seq(-4, 4, 0.1) # -4 to +4 with steps of 0.1
n <- 10000 # 10000 datapoints
sample <- rnorm(n, mean=0, sd=1) 

plot(sample, pch=20, col='darkmagenta', cex=0.1)

hist(sample, breaks=50)

# Overlay an appropriately scaled normal distribution.
pd <- (n/4.8)*dnorm(x, mean(sample), sd(sample))
lines(x, pd, col='darkmagenta', lwd=2)
abline(v=0, lwd=2, col='orange')

xpoly <- x[x >= 0 & x <= 1.00]
ypoly <- pd[x >= 0 & x <= 1.00]
xpoly <- c(xpoly, 1.00, 0.00)
ypoly <- c(ypoly, 0, 0)
polygon(xpoly, ypoly, col="slategray1")

xpoly <- x[x <= 0 & x >= -1.00]
ypoly <- pd[x <= 0 & x >= -1.00]
xpoly <- c(xpoly, 0.00, -1.00)
ypoly <- c(ypoly, 0, 0)
polygon(xpoly, ypoly, col="steelblue1")

xpoly <- x[x >= 1.00 & x <= 2.00]
ypoly <- pd[x >= 1.00 & x <= 2.00]
xpoly <- c(xpoly, 2.00, 1.00)
ypoly <- c(ypoly, 0, 0)
polygon(xpoly, ypoly, col="slategray2")

xpoly <- x[x <= -1.00 & x >= -2.00]
ypoly <- pd[x <= -1.00 & x >= -2.00]
xpoly <- c(xpoly, -1.00, -2.00)
ypoly <- c(ypoly, 0, 0)
polygon(xpoly, ypoly, col="steelblue2")

xpoly <- x[x >= 2.00 & x <= 3.00]
ypoly <- pd[x >= 2.00 & x <= 3.00]
xpoly <- c(xpoly, 3.00, 2.00)
ypoly <- c(ypoly, 0, 0)
polygon(xpoly, ypoly, col="thistle1")

xpoly <- x[x <= -2.00 & x >= -3.00]
ypoly <- pd[x <= -2.00 & x >= -3.00]
xpoly <- c(xpoly, -2.00, -3.00)
ypoly <- c(ypoly, 0, 0)
polygon(xpoly, ypoly, col="plum2")

xpoly <- x[x >= 3.00 & x <= 4.00]
ypoly <- pd[x >= 3.00 & x <= 4.00]
xpoly <- c(xpoly, 4.00, 3.00)
ypoly <- c(ypoly, 0, 0)
polygon(xpoly, ypoly, col="red")

xpoly <- x[x <= -3.00 & x >= -4.00]
ypoly <- pd[x <= -3.00 & x >= -4.00]
xpoly <- c(xpoly, -3.00, -4.00)
ypoly <- c(ypoly, 0, 0)
polygon(xpoly, ypoly, col="red")

# ------------------------------------------------------------------------------

# Step 6. Create a demonstration dataset.
# Step 6.1 Create the BMI data for women.
N <- 10000
bmi_data_female <- data.frame(gender=character(N), 
                              weight_kg=numeric(N), 
                              height_cm=numeric(N))
bmi_data_female$<..> <- 'Female'
mean_female_weight <- 69
sd_female_weight <- 10
mean_female_height <- 162
sd_female_height <- 6
bmi_data_female$weight_kg <- rnorm(N, mean=<...>, sd=<...>)
bmi_data_female$height_cm <- rnorm(N, mean=<...>, sd=<...>)

# Check it looks OK.
hist(bmi_data_female$weight_kg)
hist(bmi_data_female$<...>)

# Does it matter that these are so different?
boxplot(<...>, <...>)

# What about a scatter plot?
plot(<...>, <...>)


# Step 6.2 Create the BMI data for men in the same way.
bmi_data_male <- data.frame(gender=<...>(N), 
                            weight_kg=<...>(N), 
                            height_cm=<...>(N))
bmi_data_male$gender <- <...>
mean_male_weight <- 84
sd_male_weight <- 12
mean_male_height <- 177
sd_male_height <- 6
bmi_data_male$weight_kg <- rnorm(N, mean=<...>, sd=<...>)
bmi_data_male$height_cm <- rnorm(N, mean=<...>, sd=<...>)

# Check it looks OK.
hist(<...>)
hist(<...>)

# Does it matter that these are so different?
boxplot(<...>, <...>)

# What about a scatter plot?
plot(<...>, <...>)


# Step 6.3 Join the tables.
bmi_data <- rbind(<...>, <...>)


# Step 6.4 Calculate the BMI.
bmi_data$BMI <- bmi(<...>, <...>)

# Some examples of other ways to do this.
for(i in 1:nrow(bmi_data)){
    bmi_data[i, 'BMIF'] <- bmi(bmi_data[i, 'weight_kg'], bmi_data[i, 'height_cm'])
}
bmi_data$BMIM <- mapply(bmi, bmi_data$weight_kg, bmi_data$height_cm)
bmi_data <- bmi_data %>%
    mutate(BMIT=bmi(weight_kg, height_cm))


# Check the dataset again - some examples of different ways to specify the data
# frame and select the data to plot.
with(bmi_data, plot(weight_kg, height_cm))

df <- bmi_data %>% filter(gender=='Female')
plot(df$weight_kg, df$height_cm)
with(bmi_data %>% filter(gender=='Male'), plot(weight_kg, height_cm))


# Step 6.5 Check the BMI data.
# Look at histograms for the weight.
# All together.
hist(<...>)
# Split by gender.
hist(bmi_data[<...>(<...>=='Female'),]$weight_kg,
    col=rgb(1, 0, 0, 0.5), breaks=20)
hist(bmi_data[<...>(<...>=='Male'),]$weight_kg,
    col=rgb(0, 0, 1, 0.5), breaks=20, add=TRUE)
# And a boxplot.
with(bmi_data, boxplot(<...> ~ <...>))

# Look at histograms for the height.
# All together.
hist(<...>)
# Split by gender.
hist(<...>,
    col=rgb(1, 0, 0, 0.5), breaks=20)
hist(<...>, <...>, <...>, add=TRUE)
# And a boxplot.
with(<...>, boxplot(<...> ~ <...>))

# Look at histograms for the BMI.
# All together.
<...>
# Split by gender.
<...>
<...>
# And a boxplot.
<...>

# ------------------------------------------------------------------------------

# Step 7. Perform t-tests on the variables.

# Step 7.1 Compare the heights, weights and BMI for genders.
# One sample t-test on the height.
t.test(bmi_data_female$<...>)

# Two sample t-test comparing female and male height.
t.test(<...>$height_cm, <...>$height_cm)
# Two sample t-test comparing female and male weight.
t.test(<...>$weight_kg, <...>$weight_kg)
# Two sample t-test comparing female and male BMI
t.test(bmi_data[<...>,]$BMI, bmi_data[<...>,]$BMI)


# Step 7.2 Compare the heights, weights and BMI for genders for a small sample.
# Try various values for Ns (sample size) and n_breaks (number of bins for the
# histogram).
Ns <- <...>
n_breaks <- <...>
# Selected by gender.
sample_female <- sample_n(bmi_data[which(bmi_data$gender=='Female'),], Ns)
sample_male <- sample_n(bmi_data[which(bmi_data$gender=='Male'),], Ns)
# Selected and then separated.
sample <- sample_n(bmi_data, Ns)
sample_female <- sample[which(sample$gender=='Female'),]
sample_male <- sample[which(sample$gender=='Male'),]
cat("We have", nrow(sample_female), "women and", nrow(sample_male), "men.\n")

hist(sample_female$BMI, col=rgb(1, 0, 0, 0.5), breaks=n_breaks)
hist(sample_male$BMI, col=rgb(0, 0, 1, 0.5), breaks=n_breaks, add=TRUE)

with(sample, boxplot(weight_kg ~ gender))
with(sample, boxplot(height_cm ~ gender))
with(sample, boxplot(BMI ~ gender))

t.test(sample_female$height_cm, sample_male$height_cm)
t.test(sample_female$weight_kg, sample_male$weight_kg)
t.test(sample_female$BMI, sample_male$BMI)

# ------------------------------------------------------------------------------

# Step 8. Wilcox Mann Whitney non-parametric test.
# Single sample for height (large and small samples).
wilcox.test(<...>)
wilcox.test(<...>)

# Selected by gender for the large sample.
wilcox.test(<...>, <...>)
wilcox.test(<...>, <...>)
wilcox.test(bmi_data[<...>,]$BMI, bmi_data[<...>,]$BMI)
# And the small sample.
wilcox.test(<...>, <...>)
wilcox.test(<...>, <...>)
wilcox.test(<...>, <...>)

# ------------------------------------------------------------------------------

# Step 9. Correlation.
# Remove the variables names height_cm and weight_kg as we now want to refer to
# the columns in the bmi_data using those names (and the attach function).
rm(weight_kg, height_cm)
# Attach the data.
attach(bmi_data)
# Plot the weight against the height.
plot(<...>)
# Do a correlation test to measure how related the two variables are.
cor.test(<...>, <...>)
# What about weight against BMI?
# Scatter plot.
<...>
# Correlation test.
<...>
# How does this compare with a random variable? What do we need to create here?
random <- rnorm(<...>)
# Plot weight vs. random.
<...>
# And do the test.
<...>
detach(bmi_data)
# ------------------------------------------------------------------------------

# Step 10. Look at the normal distibution Q-Q plots.
# Q-Q plot for the females' weight.
qqnorm(<...>, main='Female, weight', col='red')
# Add the Q-Q line.
qqline(<...>, col='black')
# Q-Q plot for the males' height.
qqnorm(<...>, main='Male, height', col='blue')
# Add the Q-Q line.
qqline(<...>, col='black')
# Q-Q plot for the small-sample females' weight.
qqnorm(<...>, main='Female sample, weight', col='red')
# Add the Q-Q line.
qqline(<...>, col='black')
# Q-Q plot for the small-sample males' weight.
<...>(<...> main='Male sample, height', col='blue')
# Add the Q-Q line.
<...>(<...>, col='black')

# Q-Q plot + line for the all weights.
qqnorm(<...>, main='Weight (m+f)')
qqline(<...>, col='red')
# Q-Q plot + line for the all heights.
<...>(<...>, main='<...>')
<...>(<...>, col='<...>')
# Q-Q plot + line for the all the small-sample weights.
<...>(<...>, main=<...>)
<...>(<...>, col=<...>)
# Q-Q plot + line for the all the small-sample heights.
<...>(<...>, <...>)
<...>(<...>, <...>)

# ------------------------------------------------------------------------------

# Step 11. Kolmogorov-Smirnov test.
# A p-value < 0.05 means we reject the null hypothesis which is that the two
# variables come from the same distribution.
# Single-sample: check the female height against a normal distribution.
ks.test(scale(bmi_data_female$height_cm), "pnorm")
# Two-sample: compare the female and male height.
ks.test(scale(bmi_data_female$height_cm), scale(bmi_data_female$height_cm))
# Single-sample: check the female height against a normal distribution.
ks.test(scale(bmi_data_male$weight_kg), "pnorm")
# Two-sample: compare the female and male weight.
ks.test(scale(bmi_data_female$weight_kg), scale(bmi_data_male$weight_kg))
# Single-sample: check the female BMI against a normal distribution.
ks.test(scale(bmi_data[which(bmi_data$gender=='Female'),]$BMI), "pnorm")
# Two-sample: compare the female and male BMI
ks.test(scale(bmi_data[which(bmi_data$gender=='Female'),]$BMI),
        scale(bmi_data[which(bmi_data$gender=='Male'),]$BMI))

# ------------------------------------------------------------------------------

# Step 12. Categorical variables.
# Create a category for the height using the arbitrary boundaries (or find some).
# Be careful that you don't set the limits such that the chi-squared test is not
# valid (i.e. such that we have zero counts).
bmi_data$Height_Group <- cut(bmi_data$height_cm, c(0, 160, 170, 180, Inf),
    right=FALSE, 
    labels=c("Short", "Medium", "Long", "Very long"))
# Create a category for the BMI using the standard boundaries.
bmi_data$BMI_Group <- cut(<...>, c(0, <...>, <...>, <...>, <...>, Inf),
    right=FALSE, 
    labels=c("Underweight", "Healthy", "Overweight", "Obese", "Very Obese"))

# Have a look at the data (pick a few values at random).
sample_n(bmi_data, 10)
# Plot the data - use a boxplot by category.
with(bmi_data, boxplot(BMI ~ <...>))
# Check the levels are correct.
levels(bmi_data$BMI_Group)

# Step 12.1. Contingency table.
# Generate a frequency table for gender vs. height group.
table(bmi_data$gender, bmi_data$Height_Group)
# Or a table with proportions / percentages.
prop.table(table(bmi_data$gender, bmi_data$Height_Group)) * 100
# Create the contingency table for gender vs. BMI group.
table(bmi_data$<...>, bmi_data$<...>)
# Or a table with proportions / percentages.
prop.table(<...>(bmi_data$<...>, bmi_data$<...>)) <...>

# Step 12.2: Plot the data - use a barplot?
# Plot a bar plot to compare height betweeng gender groups.
barplot(table(bmi_data$gender, bmi_data$Height_Group), beside=TRUE)
# Plot a bar plot to compare BMI betweeng gender groups.
barplot(<...>(<...>, <...>), beside=TRUE)

# Step 12.3: Perform the chi-squared test.
# Chi-squared tests are only valid when you have reasonable sample size, less
# than 20% of cells have an expected count less than 5 and none have an expected
# count less than 1. The expected counts can be requested if the chi-squared
# test procedure has been named.
# If the p-value is small, we reject the null hypothesis: there is evidence that
# the variables are associated.

# Perform a chi-squared test comparing height for gender groups.
chisq.test(table(bmi_data$gender, bmi_data$Height_Group))

# Perform a chi-squared test comparing BMI for gender groups.
chisq.test(table(bmi_data$gender, bmi_data$BMI_Group))

# Step 12.4: Repeat for the small-sample data.
sample$BMI_Group <- cut(sample$BMI, c(0, 18.5, 25, 30, 35, Inf),
    right=FALSE, 
    labels=c("Underweight", "Healthy", "Overweight", "Obese", "Very Obese"))
table(sample$gender, sample$BMI_Group)
legend <- rownames(table(sample$gender, sample$BMI_Group))
barplot(table(sample$gender, sample$BMI_Group), legend.text=legend,
    args.legend = list(x = "topleft"), beside=TRUE)
chisq.test(table(sample$gender, sample$BMI_Group))

# Step 12.5: Repeat for the Star Wars data.
sw$BMI_Group <- cut(sw$BMI, c(0, 18.5, 25, 30, 35, Inf),
    right=FALSE, 
    labels=c("Underweight", "Healthy", "Overweight", "Obese", "Very Obese"))
barplot(table(sw$gender, sw$BMI_Group), legend.text=legend,
    args.legend = list(x = "topleft"), beside=TRUE)
chisq.test(table(sw$gender, sw$BMI_Group))

# ------------------------------------------------------------------------------

# Step 13. Get the test dataset.
birthweight <- read_csv(file="data/Birthweight.csv")
head(birthweight)

# Low birthweight is < 2.70kg.
# Select suitable parental age bands.

attach(birthweight)
# Step 13.1 Explore and describe the dataset.
# How many people?
cat("There are", length(levels(as.factor(birthweight$ID))), "babies.\n")

# Step 13.2 T-test questions.
# Which factors might lead to lighter babies? Smokers? What else?

# Step 13.3 Correlation questions.
# Which variables have a strong relationship? Maternal height and baby length?

# Step 13.4 Chi-squared test questions.
# Is there a relationship between baby weight and smoking? Age and baby weight?

# Step 13.5 Find or create some groups to enable comparisons. Look at continuous
# variables - plots, t-test, wilcox, correlation. Look at categorical variables
# - plots, chi-squared tests.
detach(birthweight)

cat(yellow("Done.\n"))
cat(yellow("---------------------------------------------------------------\n"))

# ------------------------------------------------------------------------------





