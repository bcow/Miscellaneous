##-------------------------------------------------------------------------------------------------#
##' Calculate benchmarking statistics 
##'  
##' @name calc.benchmark 
##' @title Calculate benchmarking statistics
##' @param settings object from start.benchmark.runs (for now - we many only need a few variables)
##' @export 
##' 
##' @author Betsy Cowdery 

calc.benchmark <- function(settings.bm){ #settings file is output from start.benchmark.runs
  
  # Get all the database stuff setup
  
  # Read the settings file
  
  bm.id <- settings.bm$run$id #maybe?
  
  benchmark <- db.query(paste("SELECT * benchmarks WHERE id = ", bm.id), con)
  
  # will this give you 


  
	# Query benchmarks - don't know how to do yet
  model.out <- read.output(runid, outdir, start.year=NA,end.year=NA, variables = "GPP") 

	# For each benchmark run
		# Load model outputs (vector)
    # Load observations (vector)
  
  load.data()
  
  
		# Query metrics
			# For each metric
				# calc
					# PEcAn.metrics package in benchmark module 
					# metric.RMSE
					# metric.scatter?
			# update DB
				# ensemble id 
					# model
					# location
					# time
				# metric 
					# bias
					# R2
				# etc
			# variable

}


