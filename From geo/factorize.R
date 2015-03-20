factorize <- function(n)
{
  ## Purpose:  Prime factorization of integer(s) 'n'
  ## -------------------------------------------------------------------------
  ## Arguments: n vector of integers to factorize (into prime numbers)
  ##  --> needs 'prime.sieve'
  ## >> Better would be: Define class 'primefactors' and "multiply" method
  ##			 then use this function recursively only "small" factors
  ## -------------------------------------------------------------------------
  ## Author: Martin Maechler, Date: 26--30 Jan 96
  if(all(n < .Machine$integer.max))
    n <- as.integer(n)
  else {
    warning("factorizing large int ( > maximal integer )")
    n <- round(n)
  }
  N <- length(n)
  M <- trunc(sqrt(max(n))) #-- check up to this prime number
  ##-- for M > 100 to 200: should DIVIDE first and then go on ..
  ##-- Here, I am just (too) lazy:
  k <- length(pr <- prime.sieve(maxP = M))
  nDp <- outer(pr, n, FUN = function(p,n) n %% p == 0) ## which are divisible?
  ## dim(nDp) = (k,N) ;
  ## Divide those that are divisible :
  ## quot <- matrix(n,k,N,byrow=T)[nDp] %/% matrix(pr,k,N)[nDp]
  ## quot <- rep(n,rep(k,N))[nDp] %/% rep(pr,N)[nDp]
  res <- vector("list",length = N)
  names(res) <- n
  for(i in 1:N) { ## factorize	n[i]
    nn <- n[i]
    if(any(Dp <- nDp[,i])) { #- Dp: which primes are factors
      nP <- length(pfac <- pr[Dp]) # all the small prime factors
      if(exists("DEBUG")&& DEBUG) cat(nn," ")
    } else { # nn is a prime
      res[[i]] <- cbind(p = nn, m = 1)
      prt.DEBUG("direct prime", nn)
      next # i
    }
    m.pr <- rep(1,nP)# multiplicities
    Ppf <- prod(pfac)
    while(1 < (nn <- nn %/% Ppf)) { #-- have multiple or only bigger factors
      Dp <- nn %% pfac == 0
      if(any(Dp)) { # have more smaller factors
        m.pr[Dp] <- m.pr[Dp] + 1
        Ppf <- prod(pfac[Dp])
      } else { #-- the remainder is a bigger prime
        pfac <- c(pfac,nn)
        m.pr <- c(m.pr, 1)
        break # out of while(.)
      }
    }
    res[[i]] <- cbind(p = pfac,m = m.pr)
    
  } # end for(i ..)
  
  res
}