#' standardizes spelling and fixes some common error in cell type strings. Returns all string that it
#' cannot match to a control vocabulary list as "Unk"
#'
#' @param ... Any number of strings
#'
#' @return A factor with 6 level
#' @export
cellTypeControlVoc <- function(...) {
  rr <- sapply(..., function(x){
    if (x %in% c('BM',"Bone Marrow")) {
      return('BM')
    } else if (x %in% c("BM:CAR+")){
      return("BM_car+")
    } else if (x %in% c("PBMC","Whole blood","Whole Blood")){
      return("Blood")
    } else if (x %in% c("T cells","T-Cells")) {
      return("Tcell")
    } else if (x %in% c("Tcells:CAR+")) {
      return("Tcell_car+")
    } else {
      return('Unk')
    }
  } )
  rr <- unname(rr)
  return(factor(rr,levels = c("Tcell","Blood","BM","Unk","BM_car+","Tcell_car+")))
}


#' standardizes spelling and fixes some common error in cell type strings. Returns all string that it
#' cannot match to a control vocabulary list unchanged.
#'
#' @param ... Any number of strings
#'
#' @return A factor with a variable number of level
#' @export
cellTypeControlVoc2 <- function(...) {
  rr <- sapply(..., function(x){
    if (x %in% c('BM',"Bone Marrow")) {
      return('BM')
    } else if (x %in% c("PBMC","Whole blood","Whole Blood")){
      return("Blood")
    } else if (x %in% c("T cells","T-Cells")) {
      return("Tcell")
    } else {
      return(x)
    }
  } )
  rr <- unname(rr)
  lvls <- unique(rr)
  lvls <- union(c("Tcell","Blood","BM","Unk","BM_car+","Tcell_car+"),lvls)
  return(factor(rr,levels = lvls))
}
