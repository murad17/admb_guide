#' Read in the ADMB Hessian file.
#'
#' @template covariance_template
get.admb.hes <- function(model.path=getwd()){
    wd.old <- getwd(); on.exit(setwd(wd.old))
    setwd(model.path)
    filename <- file("admodel.hes", "rb")
    on.exit(close(filename), add=TRUE)
    num.pars <- readBin(filename, "integer", 1)
    hes.vec <- readBin(filename, "numeric", num.pars^2)
    hes <- matrix(hes.vec, ncol=num.pars, nrow=num.pars)
    hybrid_bounded_flag <- readBin(filename, "integer", 1)
    scale <- readBin(filename, "numeric", num.pars)
    result <- list(num.pars=num.pars, hes=hes,
                   hybrid_bounded_flag=hybrid_bounded_flag, scale=scale)
    return(result)
}

#' Read in the ADMB covariance file.
#'
#' @template covariance_template
get.admb.cov <- function(model.path=getwd()){
    wd.old <- getwd(); on.exit(setwd(wd.old))
    setwd(model.path)
    filename <- file("admodel.cov", "rb")
    on.exit(close(filename), add=TRUE)
    num.pars <- readBin(filename, "integer", 1)
    cov.vec <- readBin(filename, "numeric", num.pars^2)
    cov <- matrix(cov.vec, ncol=num.pars, nrow=num.pars)
    hybrid_bounded_flag <- readBin(filename, "integer", 1)
    scale <- readBin(filename, "numeric", num.pars)
    result <- list(num.pars=num.pars, cov=cov,
                   hybrid_bounded_flag=hybrid_bounded_flag, scale=scale)
    return(result)
}

#' Write a covariance matrix to the ADMB covariance file.
#'
#' @template covariance_template
write.admb.cov <- function(cov.user, model.path=getwd()){
    temp <- file.exists(paste0(model.path, "/admodel.cov"))
    if(!temp) stop(paste0("Couldn't find file ",model.path, "/admodel.cov"))
    temp <- file.copy(from=paste0(model.path, "/admodel.cov"),
                      to=paste0(model.path, "/admodel_original.cov"))
    wd.old <- getwd()
    on.exit(setwd(wd.old))
    setwd(model.path)
    ## Read in the output files
    results <- get.admb.cov()
    scale <- results$scale
    num.pars <- results$num.pars
    if(NROW(cov.user) != num.pars)
        stop(paste0("Invalid size of covariance matrix, should be: ", num.pars,
                   "instead of ",NROW(cov.user)))
    cov.unbounded <- cov.user/(scale %o% scale)
    ## Write it back to file
    file.new <- file(paste0(model.path, "/admodel.cov"),"wb")
    on.exit(close(file.new))
    writeBin(as.integer(num.pars), con=file.new)
    writeBin(as.vector(as.numeric(cov.unbounded)), con=file.new)
    writeBin(as.integer(results$hybrid_bounded_flag), con=file.new)
    writeBin(as.vector(scale), con=file.new)
}
