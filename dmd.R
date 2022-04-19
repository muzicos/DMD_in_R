dmd <- function(X, Xprime, modes = 0) {
  decomp <- svd(X)
  
  r <- length(decomp$d)
  Sig <- decomp$d * diag(r)
  
  if (modes != 0) {
    decomp$u <- decomp$u[,1:modes]
    decomp$v <- decomp$v[,1:modes]
    Sig <- Sig[1:modes,1:modes]
  }
  
  SigI <- solve(Sig)
  Atilde <- Conj(t(decomp$u)) %*% Xprime %*% decomp$v %*% SigI
  ev <- eigen(Atilde)
  
  Phi <- Xprime %*% decomp$v %*% SigI %*% ev$vectors
  
  mapping <- list(values = ev$values, vectors = Phi)
  return(mapping)
}