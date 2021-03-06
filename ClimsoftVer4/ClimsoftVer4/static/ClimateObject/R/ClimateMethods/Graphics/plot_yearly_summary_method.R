#  yearly summaries
#' @title plot yearly summaries
#' @name plot_yearly_summary
#' @author Frederic Ntirenganya 2015 (AMI)
#' 
#' @description \code{yearly summaries plot}
#' plot yearly summaries of interest from climate object
#'  
#' @return it returns a timesies plot of the summary

climate$methods(plot_yearly_summary = function (data_list=list(), col1="blue",ylab,xlab="Year",na.rm=TRUE, pch=20,ylim=0,type="b",lty=2,col2="red",lwd = 2,lwd2 = 1.5,
                                                interest_var="Total Rain",var_label = rain_label,plot_line = FALSE,ygrid=0, graph_parameter = par(mfrow=c(2,2)),plot_window = FALSE,
                                                main_title="Plot - Summary per Year",grid=FALSE){
  # convert data 
  data_list = c(data_list, convert_data=TRUE)
  # time period
  data_list = add_to_data_info_time_period(data_list, yearly_label)
  
  climate_data_objs = get_climate_data_objects(data_list)
  
  for(data_obj in climate_data_objs) {
    data_name = data_obj$get_meta(data_name_label)
    
    # Must add these columns if not present 
    if( !(data_obj$is_present(year_label) ) ) { 
      data_obj$add_year_col() 
    }
    year_col = data_obj$getvname(year_label)
    
    interset_var_col = data_obj$getvname (interest_var) 
    
    if(missing(ylab)){
      ylab = data_obj$getvname(interest_var)
    }    
    curr_data_list = data_obj$get_data_for_analysis(data_list)
    if (plot_window){   
      par = graph_parameter 
    } 
    # loop for plotting 
    for( curr_data in curr_data_list ) { 
      plot( curr_data[[year_col]], curr_data[[interset_var_col]],type=type,pch=pch,xlab=xlab, col=col1,ylim= c(ylim, max(curr_data[[interset_var_col]], na.rm=na.rm)),
            xlim = c( min(curr_data[[year_col]], na.rm=na.rm), max( curr_data[[year_col]], na.rm=na.rm)),
            ylab=ylab, main= c( data_name, main_title))
      
      if (grid){
        grid(length(curr_data[[year_col]]),ygrid, lwd = lwd)
      }      
      
      if (plot_line) {
        reg=lm(curr_data[[interset_var_col]] ~ curr_data[[year_col]])
        abline(reg,col=col2,lwd=lwd2 )
        print(summary(reg))
      }
    }
  }
  par(mfrow=c(1,1))
}
)