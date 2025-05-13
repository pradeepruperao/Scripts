setwd("/data/path_to_vcf")
library(ggplot2)
maf_file <- read.table("input_snp_maf_stat.frq", head=TRUE)
ggplot(data = maf_file, aes(x = MAF)) + geom_density() + ggtitle("MAF Density Distribution") +scale_x_continuous(breaks=seq(0,1,by=0.05))+ theme_bw() + theme(plot.title = element_text(hjust = 0.5,face = "bold"), axis.line = element_line(color='black'),plot.background = element_blank(), panel.grid.minor = element_blank(), panel.grid.major = element_blank(),) +xlab("MAF") + ylab("Density") +geom_vline(xintercept = 0.01, linetype="dotted", color = "blue", size=0.4) +geom_vline(xintercept = 0.05, linetype="dotted", color = "red", size=0.4)
ggsave("MAF_Density_Distribution_with_lines.jpg",width = 8, height = 8, units = 'in', dpi = 300)

