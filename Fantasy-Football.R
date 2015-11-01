library('ggplot2')
#-------------------------------------------------------
#------- Data Incubator Challenge: Question 3 ----------
#-------- Fantasy Football and Data Science ------------
#-------------------------------------------------------
rm(list = ls())
gc(verbose = FALSE)

# Load the data into a dataframe -----------------------
ff_data <- read.csv("FF.csv", header = TRUE)
str(ff_data)

# Scatterplot of players fantasy points vs cost --------
qplot(Cost, FP, data = ff_data, shape = Position, color = Position,
      ylab = "Fantasy Points", xlab = "Cost", main = "Fantasy Points vs Cost")

# Boxplot showing points distributions across----------- 
# Plot 1 -----------------------------------------------
qplot(Position, FP, data = ff_data, geom = "boxplot", fill = Position,
      ylab = "Fantasy Points", xlab = "Position", 
      main = "Fantasy Points Distributions Across Positions")

# Retrieve QB data  ------------------------------------
QB_data <- ff_data[ff_data$Position == "QB", c('Player', 'FP', 'Cost')]
str(QB_data)

# Compute QB average fantasy points and average cost ---
QB_avg <- apply(QB_data[,c("FP", "Cost")],2,'mean')

# Determine possible QB sleepers using averages---------
QB_data$Sleeper <- QB_data$FP > QB_avg["FP"] & QB_data$Cost < QB_avg["Cost"]
str(QB_data)

# Plot of possible QB sleepers comparing them to rest --
# Plot 2 -----------------------------------------------
qplot(Cost, FP, data = QB_data, shape = Sleeper, color = Sleeper,
      ylab = "Fantasy Points", xlab = "Cost ($)", main = "Potential Quaterback Sleepers")
