#' GetKEGGPathways
#'
#' @param df data frame containing differential gene expression results
#' @param species species to map . Available option: "human" and "mouse".
#'
#' @return Data frame containing KEGG pathways
#' @export
GetKEGGPathways <- function(df = NULL, species = "human"){

  up <- df %>% filter(avg_log2FC > 0) %>% pull(gene)
  down <- df %>% filter(avg_log2FC < 0) %>% pull(gene)

  if(species == "human"){
    if (length(up) > 0)
      up <- AnnotationDbi::mapIds(org.Hs.eg.db::org.Hs.eg.db, up, "ENTREZID", "SYMBOL")
    if (length(down) > 0)
      down <- AnnotationDbi::mapIds(org.Hs.eg.db::org.Hs.eg.db, down, "ENTREZID", "SYMBOL")

    genes <- list(Up = up, Down = down)
    pathways <- limma::kegga(genes, species = "Hs")

  }else if(species == "mouse"){
    if (length(up) > 0)
      up <- AnnotationDbi::mapIds(org.Mm.eg.db::org.Mm.eg.db, up, "ENTREZID", "SYMBOL")
    if (length(down) > 0)
      down <- AnnotationDbi::mapIds(org.Mm.eg.db::org.Mm.eg.db, down, "ENTREZID", "SYMBOL")

    genes <- list(Up = up, Down = down)
    pathways <- limma::kegga(genes, species = "Mm")
  }

  # adjust p values
  pathways <- pathways %>% mutate(adj.P.Up = p.adjust(pathways[["P.Up"]], method = "bonferroni"))
  pathways <- pathways %>% mutate(adj.P.Down = p.adjust(pathways[["P.Down"]], method = "bonferroni"))

  # signed log p-values
  pathways <- pathways %>% mutate(logP.Up = -log10(adj.P.Up)) # -log to obtain positive values for UP
  pathways <- pathways %>% mutate(logP.Down = log10(adj.P.Down))# log to obtain negative values for UP

  return(pathways)
}

#' GetTopKEGG
#'
#' @param df Data frame containing KEGG pathways.
#' @param top.by Label used to select the top.
#' @param type Type of selected p-values. Available options are: "double", negatives and positive, "positive", and "negative".
#' @param ntop Number of top values.
#'
#' @return Data frame containing the top values.
#' @export
GetTopKEGG <- function(df = NULL, top.by = "Selected_PV", type = "double" , ntop = 20){

  if(type == "double"){
    idx <- sort(abs(df[[top.by]]), decreasing = TRUE, index.return = TRUE)$ix
  }else if(type == "positive"){
    idx <- sort(df[[top.by]], decreasing = TRUE, index.return = TRUE)$ix
  }else{
    idx <- sort(df[[top.by]], decreasing = FALSE, index.return = TRUE)$ix
  }

  idx <- idx[1:ntop]
  tmp <- df[idx,]

  return(tmp)
}

#' PlotKEGG
#'
#' @param df Data frame containing KEGG pathways
#' @param type Type of selected p-values. Available options are: "double", negatives and positive, "positive", and "negative".
#' @param ntop Number of top values.
#' @param color_by Label to color points.
#' @param point_size Size of points
#' @param text_size Size of text in the plot.
#'
#' @return A ggplot object.
#' @export
PlotKEGG <- function(df = NULL, type = "double", ntop = 20, color_by = "Direction", point_size = 3, text_size = 15){

  # SETUP
  ## setup direction and selected p-values

  # first column are positive pv, second column are negative pv
  tmp <- cbind(abs(df$logP.Up), abs(df$logP.Down))
  idxMax <- apply(tmp, MARGIN = 1, which.max)
  direction <- rep(NA, nrow(tmp))
  direction[(idxMax == 1)] <- "up"
  direction[(idxMax == 2)] <- "down"

  selPV <- rep(NA, nrow(tmp))
  selPV[(idxMax == 1)] <- tmp[(idxMax == 1),1]
  selPV[(idxMax == 2)] <- -tmp[(idxMax == 2),2]

  df <- df %>% mutate(Direction = direction)
  df <- df %>% mutate(Selected_PV = selPV)

  topKegg <- getTopKEGG(df = df, type = type, top.by = "Selected_PV", ntop = ntop)
  topKegg <- sortDF(df = topKegg, sort.by = "Selected_PV", decreasing = FALSE)
  levels <- topKegg$Pathway
  topKegg[["Pathway"]] <- factor(topKegg[["Pathway"]], levels = levels)

  p <- ggplot(topKegg, aes_string(x = "Selected_PV", y = "Pathway", color = color_by)) +
    geom_point(size = point_size) +
    theme_classic() +
    labs(x = expression(paste('Signed ', -log[10],'(adjusted p-value)')),
         y = "KEGG Pathways") +
    TextSize(size = text_size)

  return(p)
}