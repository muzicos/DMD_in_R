dmdA <- function(X, Xprime, B = matrix(), Ups = 0) {
  if(Matrix::nnzero(B, na.counted = FALSE)) {
    Xprime <- Xprime - (B %*% Ups)
  }
  
  decomp <- svd(X)
  
  r <- length(decomp$d)
  Sig <- decomp$d * diag(r)
  
  SigI <- solve(Sig)
  Ut <- Conj(t(decomp$u))
  
  A <- Xprime %*% decomp$v %*% SigI %*% Ut
  return(A)
}

dmdc <- function(X, Xprime, Ups, thresh = 1e-10) {
  Omega <- rbind(X,Ups)
  
  decomp <- svd(Omega)
  rtil <- length(decomp$d[decomp$d>thresh])
  
  Util <- decomp$u[,1:rtil]
  Sigtil <- decomp$d[1:rtil] * diag(rtil)
  Vtil <- decomp$v[,1:rtil]
  
  decomp <- svd(Xprime)
  rhat <- length(decomp$d[decomp$d>thresh])
  
  Uhat <- decomp$u[,1:rhat]
  Sighat <- decomp$d[1:rhat]*diag(rhat)
  Vbar <- decomp$v[,1:rhat]
  
  n <- nrow(X)
  q <- nrow(Ups)
  
  U_1 <- Util[1:n,]
  U_2 <- Util[n+q,]
  
  SigtilI <- solve(Sigtil)
  
  approxA <- Conj(t(Uhat)) %*% Xprime %*% Vtil %*% SigtilI %*% Conj(t(U_1)) %*% Uhat
  approxB <- Conj(t(Uhat)) %*% Xprime %*% Vtil %*% SigtilI %*% U_2
  
  ev <- eigen(approxA)
  Phi <- Xprime %*% Vtil %*% SigtilI %*% Conj(t(U_1)) %*% Uhat %*% ev$vectors
  
  return(list(A=approxA,B=approxB,W=ev$vectors,Phi=Phi))
}
