# ------------------------------------------------------------------------------
# Guessing Game Exercise with Gaps
# ------------------------------------------------------------------------------
# January 2022
# Dr Pete Arnold
# ------------------------------------------------------------------------------
# The following code is one solution to the exercises presented in the lecture
# covered by the notes in Exercise_in_programming_in_R.pptx.
# The aim is to give you a sense of the kind of solution whilst leaving some
# challenges for you to complete. Please replace all <...> with some actual
# code, for example, print(<...>), could be print("Hello, World!").
# ------------------------------------------------------------------------------

# Step 0. Display something so we know we are working.
print("hello")

# Step 1. Think of a number.
# Generate a random number between 1 and 100 (inclusive). 
number <- runif(1, 1, 100)

# But we should only allow whole numbers as decimals would be hard to guess
# exactly, so we round 'number' to zero decimal place and save the value back to
# 'number'.
number <- round(number, 0)

# We can, in fact, do this is one step.
number <- round(runif(1, 1, 100), 0)

# ------------------------------------------------------------------------------

# How shall we check that this is correct?
# We could look at number and make sure that it is an integer between 1 and 100.
print(number)

# But we may have got lucky and how do we know it will always be in range and
# that it will cover that range?

# Make n large and see the statistics of the values are saying.
# It is good practice to put numbers that might vary in named variables (often
# called 'constants' in other programming languages).

# Define a large number.
n <- 100000
# Get that many numbers - this will be a long list - give it a name.
longVec <- round(runif(n, 1, 100), 0)
# We can plot a histogram of those numbers to see if it looks right.
hist(longVec)
# And look at the minimum and maximum values.
print(min(longVec))
print(max(longVec))
# We can do the basic descriptive statistics and see if they look right.
summary(hist)

# ------------------------------------------------------------------------------

# And, as they are numbers, we can write some code to check them for us.
# Here we have textual data, Min. and Max., which we indicate is text by placing
# quotes around them (they are referred to as strings (of characters)).
# The square brackets []allow us to access a paricular data entry in a list.
# The 'if' statement reads like it is written and will run the first section of
# code if the check on the 'if' line is TRUE and the second if it is FALSE.
check <- summary(longVec)
# check is a named vector, so you can refer to it by index (1 to 6) or name
# ('Min.', '1st Qu.' etc.).
print(check[1])
print(check['Min.'])
if ((check['Min.'] == 1) & (check['Max.'] == 100)) {
    print("Number range is OK.")
} else {
    print("Number range is not as intended!")
}

# ------------------------------------------------------------------------------

# 2. Get the user to make a guess.

guess <- readline(prompt=">")

# ------------------------------------------------------------------------------

# 3. How do we check that we have a number?
# Convert the entered string to a number - as.numeric() will do this and, if the
# string is not a number it will return NA.
guess <- as.numeric(guess)
print(guess)

# Now all we need to do is check if the guess is NA. If not, it must be a
# number. If it is NA, we'll stop and print out a message to tell the user.
# This kind of checking is done with an 'if' statement - if the contents of the
# brackets after the if are TRUE, the next section is run. If FALSE, it is
# skipped.
if (is.na(guess)){
    print("That guess was not a number!\n")
} else {
  print("that was a number!\n")
}

# ------------------------------------------------------------------------------

# 4. How do we check if the guess matches the number? &
# 5. Display messages to the user.

# .1
if (guess == number){
    print("You guessed correctly!")
}
# .2 Also, try cat() rather than print() but we'll need to add a newline at the
#     end or the next output will appear on the same line.
if (guess == number){
    cat("You guessed correctly!")
} else {
    cat("You guessed wrong!")
}
# .3
is_guess_correct <- guess == number
if (is_guess_correct){
    print("You guessed correctly!")
} else {
    print("You guessed wrong!")
} 
#print(longVec)

# ------------------------------------------------------------------------------

# 6. Do it again - use a loop - one with for, one with while and one with
# repeat.

# To recap, this is all the one-guess code.
number <- runif(1, 1, 100)
number <- round(number, 0)
guess <- readline(prompt="Enter a number:")
guess <- as.numeric(guess)
if (is.na(guess)){
    stop("That guess was not a number!\n")
}
have_guessed <- guess == number
if (have_guessed == TRUE){
    print("You guessed correctly!")
} else {
    print("You guessed wrong!")
}

# Use a for-loop to have 10 guesses.
number <- runif(n=1, min=1, max=100)
number <- round(number, 0)
attempts <- 0
steps <- 10
for (step in 1:steps){
    guess <- readline(prompt="Enter a number:")
    guess <- as.numeric(guess)
    if (is.na(guess)){
        stop("That guess was not a number!\n")
    }
    have_guessed_in_loop <- guess == number
    attempts <- attempts + 1
    if (have_guessed){
        print("You guessed correctly!")
        # Don't need any more guesses so need to jump out of the loop.
        break
    } else {
        print("You guessed wrong!")
    }
}

# This is the while-loop code.
number <- runif(1, 1, 100)
number <- round(number, 0)
attempts <- 0
have_guessed <- FALSE
# In the case of a while loop, we end the loop here if the condition is FALSE.
while(have_guessed == FALSE){
    guess <- readline(prompt="Not quite, enter another number: ")
    guess <- as.numeric(guess)
    if (is.na(guess)){
        stop("That guess was not a number!\n")
    }
    have_guessed <- guess == number
    attempts <- attempts + 1
    if (have_guessed){
        print("You guessed correctly!")
    } else {
        print("You guessed wrong!")
    } 
}

# This is the repeat-loop code.
number <- runif(1, 1, 100)
number <- round(number, 0)
attempts <- 0
repeat{
  guess <- readline(prompt="enter a number: ")
  guess <- as.numeric(guess)
    if (is.na(guess)){
        stop("That guess was not a number!\n")
    }
    have_guessed <- guess == number
    attempts <- attempts + 1
    if (have_guessed){
        print("You guessed correctly!")
        # Don't need any more guesses so need to jump out of the loop.
        break
    } else {
        print("You guessed wrong!")
      if (guess < number) {
        print("you're a bit low...")
      } else {
        print("you're a bit high...")
      }
      
    } 
}

# ------------------------------------------------------------------------------

# 7. Messing with the code.
# 7.1 Improving the messages.
# This is the repeat-loop code.
number <- runif(1, 1, 100)
number <- round(number, 0)
attempts <- 0
repeat{
    # Differentiating between the raw user input (a string) and the value that
    # has been checked to be a number (in case having both may be useful later).
    guess_string <- readline(prompt="Enter a number:")
    guess <- as.numeric(guess_string)
    if (is.na(guess)){
        stop(cat("That guess (", guess_string, ") was not a number!\n"))
    }
    have_guessed <- guess == number
    attempts <- attempts + 1
    if (have_guessed == TRUE){
        cat("You guessed correctly, it was", guess_string, "!\n")
        cat("You took", attempts, " attempts to guess")
        break
    } else {
        cat("you guessed wrong with" , guess_string)
        if (guess < number) {
          cat("...you guessed too low")
        } else {
          cat("...you guessed too high")
        }
    } 
}

# 7.2 OPTIONAL: Improve the error handling.
number <- runif(1, 1, 100)
number <- round(number, 0)
attempts <- 0
repeat{
    guess_string <- readline(prompt="Enter a number:")
    guess <- as.numeric(guess_string)
    if (is.na(guess)){
        cat("That guess (", guess_string, ") was not a number!\n")
        next
    }
    have_guessed <- guess == number
    attempts <- attempts + 1
    if (have_guessed == TRUE){
        cat("You guessed correctly, it was", number, "!\n")
        cat("You took", attempts, "goes to guess.\n")
        break
    } else {
        cat("You guessed wrong, it wasn't", guess, "!\n")
    } 
}

# 7.3 OPTIONAL: An explicit user way out.
number <- runif(1, 1, 100)
number <- round(number, 0)
attempts <- 0
repeat{
    guess_string <- readline(prompt="Enter a number:")
    if (<...>){
        <...>
    }
    guess <- as.numeric(guess_string)
    if (is.na(guess)){
        cat("That guess (", guess_string, ") was not a number!\n")
        next
    }
    have_guessed <- guess == number
    attempts <- attempts + 1
    if (have_guessed == TRUE){
        cat("You guessed correctly, it was", number, "!\n")
        cat("You took", attempts, "goes to guess.\n")
        break
    } else {
        cat("You guessed wrong, it wasn't", guess, "!\n")
    } 
}

# 7.4 With clues.
# Before you look at this code, review the previous one and decide where you
# need to add the clue message and what clue you are going to give.
number <- runif(1, 1, 100)
number <- round(number, 0)
attempts <- 0
repeat{
    guess_string <- readline(prompt="Enter a number:")
    if (guess_string == 'q'){
        break
    }
    guess <- as.numeric(guess_string)
    if (is.na(guess)){
        cat("That guess (", guess_string, ") was not a number!\n")
        next
    }
    have_guessed <- guess == number
    attempts <- attempts + 1
    if (have_guessed == TRUE){
        cat("You guessed correctly, it was", number, "!\n")
        cat("You took", attempts, "goes to guess.\n")
        break
    } else {
        if (<...>) {
            <...>("You guessed too high, it wasn't", <...>)
        } <...> {
            <...>("You guessed too low, it wasn't", <...>)
        }
    } 
}

# 8. Save a list (actually a vector) of the guesses.
number <- runif(1, 1, 100)
number <- round(number, 0)
attempts <- 0
guesses <- <...> # An empty vector.
repeat{
    guess_string <- readline(prompt="Enter a number:")
    if (guess_string == "q"){
        break
    }
    guess <- as.numeric(guess_string)
    if (is.na(guess)){
        cat("That guess (", guess_string, ") was not a number!\n")
        next
    }
    <...> <- c(<...>, <...>)      # Add this guess to the guesses vector and save it back to the vector.
    have_guessed <- guess == number
    attempts <- attempts + 1
    if (have_guessed == TRUE){
        cat("You guessed correctly, it was", number, "!\n")
        cat("You took", attempts, "goes to guess.\n")
        break
    } else {
        if (guess > number) {
            cat("You guessed too high, it wasn't", guess, "!\n")
        } else {
            cat("You guessed too low, it wasn't", guess, "!\n")
        }
    } 
}
print("You guessed the following values:")
<...>                               # Display all the guesses on the console.
<...>(guesses, type='<...>')        # Plot the guesses as a line.
abline(<...>=number, <...>='red')   # Add a horizontal red line for the number.

# 9. Make it harder by moving the number between guesses (and keep track of 
#    these as well.
number <- runif(1, 1, 100)
number <- round(number, 0)
attempts <- 0
change <- <...>         # How much the number might vary each time.
guesses <- vector()
numbers <- <...>        # Need to define a vector but with number in it.
repeat{
    guess_string <- readline(prompt="Enter a number:")
    if (guess_string == "q"){
        break
    }
    guess <- as.numeric(guess_string)
    if (is.na(guess)){
        cat("That guess (", guess_string, ") was not a number!\n")
        next
    }
    guesses <- c(guesses, guess)
    have_guessed <- guess == number
    attempts <- attempts + 1
    if (have_guessed == TRUE){
        cat("You guessed correctly, it was", number, "!\n")
        cat("You took", attempts, "goes to guess.\n")
        break
    } else {
        if (guess > number) {
            cat("You guessed too high, it wasn't", guess, "!\n")
        } else {
            cat("You guessed too low, it wasn't", guess, "!\n")
        }
        # Update the number by a random number from -change to +change.
        <...> <...> + round(runif(1, <...>, <...>), 0)
        # Add the number to the end of the list of numbers.
        numbers <- <...>
    } 
}
print("You guessed the following values:")
print(guesses)
plot(guesses, type='l', col='red')
# Add the numbers to the plot as another line in a different colour.
<...>(numbers, <...>)

# 10. Calculate the error at each step.
number <- runif(1, 1, 100)
number <- round(number, 0)
attempts <- 0
change <- 3
guesses <- vector()
numbers <- c(number)
repeat{
    guess_string <- readline(prompt="Enter a number:")
    if (guess_string == "q"){
        break
    }
    guess <- as.numeric(guess_string)
    if (is.na(guess)){
        cat("That guess (", guess_string, ") was not a number!\n")
        next
    }
    guesses <- c(guesses, guess)
    have_guessed <- guess == number
    attempts <- attempts + 1
    if (have_guessed == TRUE){
        cat("You guessed correctly, it was", number, "!\n")
        cat("You took", attempts, "goes to guess.\n")
        break
    } else {
        if (guess > number) {
            cat("You guessed too high, it wasn't", guess, "!\n")
        } else {
            cat("You guessed too low, it wasn't", guess, "!\n")
        }
        number <- number + round(runif(1, -change, change), 0)
        numbers <- c(numbers, number)
    } 
}
print("You guessed the following values:")
print(guesses)
plot(guesses, type='l', col='red')
lines(numbers, col='blue')
<...> <- <...>(guesses)['Mean']             # Get the mean value of the guesses.
<...>(h=<...>, col='darkgreen', lty=<...>)  # Draw the mean as a dotted, horizontal line.
<...>(<...>, col='darkgreen')               # Draw the error as a line relative to this mean.

# Create a data frame containing the data.
df <- data.frame(numbers=numbers, guesses=guesses, errors=guesses-numbers)
# Show a histogram of the errors.
host(df$errors)

# 11. Put this in a function.
# The guessing game as a function.
# See the guessing game exercises from day 1.
# @param max_attempts integer The maximum number of attempts you have to guess.
# @return A list containing the numbers and guesses.
guessing_game <- function(max_attempts=10){
    # If you want to work through this step by step, include the debugger by
    # uncommenting the next line.
    # browser()
    number <- runif(n=1, min=1, max=100)
    number <- round(number, 0)
    attempts <- 0
    change <- 3
    guesses <- vector()
    numbers <- c(number)
    for(i in 1:max_attempts){
        guess_string <- readline(prompt="Enter a number: ")
        if (guess_string == "q"){
            break
        }
        guess <- as.numeric(guess_string)
        if (is.na(guess)){
            cat("That guess (", guess_string, ") was not a number!\n")
            next
        }
        guesses <- c(guesses, guess)
        have_guessed <- guess == number
        attempts <- attempts + 1
        if (have_guessed == TRUE){
            cat("You guessed correctly, it was", number, "!\n")
            cat("You took", attempts, "goes to guess.\n")
            break
        } else {
            if (guess > number) {
                cat("You guessed too high, it wasn't", guess, "!\n")
            } else {
                cat("You guessed too low, it wasn't", guess, "!\n")
            }
            number <- number + round(runif(1, -change, change), 0)
            numbers <- c(numbers, number)
        } 
    }
    print("You guessed the following values:")
    print(guesses)
    plot(guesses, type='l', col='red')
    lines(numbers, col='blue')
    
    return(list(nums=numbers, attempts=guesses))
}

# 12. Do this with functions.
# Implement the functions as used in the following function.
# The setup function is provided as it uses the double-headed arrow (to set a
# global variable) which may not be a familiar concept.
setup <- function(range, change){
    # Set up all the global variables.
    number <<- runif(1, 1, range)
    number <<- round(number, 0)
    attempts <<- 0
    change <<- change
    guesses <<- vector()
    numbers <<- c(number)
}
# And the rest of the functions should follow the general structure of:
get_guess <- function(prompt){
    return(<...>)
}
# And update_guesses is a little tricky:
update_guesses <- function(guess){
    # Note that all these are global variables.
    attempts <<- <...> + 1
    guesses <<- save_value(<...>(guess), <...>)
    return(guess)
}

game <- function(range=100, change=3){
    setup(range, change)
    repeat {
        guess_string <- get_guess("Enter a number:")
        if (check_for_quit(guess_string)) break
        if (check_for_not_number(guess_string)) next
        guess <- update_guesses(guess_string)
        if (is_guess_right(guess, number)){
            cat("You guessed correctly, it was", number, "!\n")
            cat("You took", attempts, "goes to guess.\n")
            break
        } else {
            if (guess > number){
                cat("You guessed too high, it wasn't", guess, "!\n")
            } else {
                cat("You guessed too low, it wasn't", guess, "!\n")
            }
            number <- change_number(change)
        }
    }
    display_results()
    return(list(nums=numbers, attempts=guesses))
}

game(range=100, change=1)
# ------------------------------------------------------------------------------





