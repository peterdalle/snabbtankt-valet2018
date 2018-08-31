# Reproducera graferna i PNG- och PDF-format.
#
# Notera att objekten "graph" och "df_domains_diff" måste existera först,
# se den explorativa analysen i filen analysis.rmd.

library(ggraph)
library(extrafont)
set.seed(799)

# Bild 1. Nätverksgraf.
gg_graph <- graph %>%
  # Sätt till 0.01 för noderna någorlunda utspritt och lättläst inom A4-sidan.
  ggraph(layout="drl", options=list(simmer.attraction=0.01)) + 
  geom_edge_link(aes(edge_alpha=n, edge_width=n), edge_colour="gray", show.legend=FALSE) +
  scale_size(range = c(2, 10)) +
  #geom_edge_density(aes(fill=sqrt(n))) +
  geom_node_point(aes(size=indegree, color=factor(type))) +
  #scale_color_manual(values = c("#DF484A", "#FDBF81", "#BCE4B7"))+
  scale_color_brewer(palette = "Set1") +
  geom_node_text(aes(label=name), vjust=2.5, size=4, repel=FALSE, 
                 check_overlap=FALSE, family="Arial Narrow") +
  labs(title=NULL,
       color="") +
  guides(size=FALSE, color = guide_legend(override.aes = list(size=5))) +
  theme_graph(plot_margin = margin(0, 0, 0, 0), base_family="Arial Narrow") + 
  theme(legend.position ="bottom",
        legend.text = element_text(size = 10),
        legend.background = element_blank(),
        legend.box.background = element_rect(color = "black"),
        text = element_text(family="Arial Narrow"))

# Spara PNG + PDF.
ggsave("output/bild1-domannatverk.png", gg_graph, device="png", 
       width=21, height=18, units="cm", dpi=150)
ggsave("output/bild1-domannatverk.pdf", gg_graph, device="pdf", 
       width=240, height=210, units="mm", dpi=150, scale = 0.85) # A4 är 210x297 mm.


# Bild 2. Förändring av andel länkar.
gg_diff <- df_domains_diff %>% 
  head(15) %>% 
  filter(!domain_root %in% c("twitter.com")) %>%
  ggplot(aes(reorder(domain_root, relative_diff), relative_diff*100, 
             fill=factor(relative_diff_direction))) +
  geom_col() +
  scale_fill_manual(values = c("firebrick1", "steelblue")) +
  scale_y_continuous(breaks = seq(-100, 100, 2)) +
  labs(title = "Hemsidor som ökat mest på #svpol",
       x = NULL,
       y = "Förändring 2017 till 2018 (procentenheter)",
       fill = NULL) +
  theme(legend.position = "none", panel.grid.major.y = element_blank(),
        text = element_text(color = "black", family="Arial Narrow")) +
  coord_flip()

# Spara PNG + PDF.
ggsave("output/bild2-forandring.png", gg_diff, device="png", 
       width=10, height=7, units="cm", dpi=150)
ggsave("output/bild2-forandring.pdf", gg_diff, device="pdf", 
       width=120, height=97, units="mm", dpi=300)