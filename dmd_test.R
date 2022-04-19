source("dmd.R")
source("dmdc.R")

X <- as.matrix(read.table("x_data.csv", sep=","))
Xp <- as.matrix(read.table("xp_data.csv", sep=","))
Ups <- as.matrix(read.table("ups_data.csv", sep=","))

B <- matrix(c(1,0),nrow = 2, ncol=1)
## DMD w/B known
(A_bk <- dmdA(X = X, Xprime = Xp, B = B, Ups = Ups))

## DMD w/B unknown

(A_bu <- dmdA(X = X, Xprime = Xp))

## DMD
A.approx <- dmdc(X = X, Xprime = Xp, Ups = Ups)
