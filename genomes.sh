# wrapper function to install one genome
function installGenome {

#-------------------------------------------------
# set the target genome
#-------------------------------------------------
export GENOME=$1
export SPECIES=$2
export IGENOME_URL=http://igenomes.illumina.com.s3-website-us-east-1.amazonaws.com
export IGENOME_URL=$IGENOME_URL/$SPECIES/UCSC/$GENOME/$SPECIES""_UCSC_$GENOME.tar.gz
#-------------------------------------------------
echo
echo "downloading genome resource: $GENOME"
echo $IGENOME_URL

#-------------------------------------------------
# genome metadata from various sources; only smaller files here
#-------------------------------------------------
export GENOMES_DIR=$MDI_DIR/resources/genomes
GENOME_METADATA_DIR=$GENOMES_DIR/metadata/$GENOME
mkdir -p $GENOME_METADATA_DIR
checkPipe
cd $GENOME_METADATA_DIR
mkdir -p UCSC
mkdir -p ENCODE

# genome gaps
wgetFile UCSC gap.txt.gz https://hgdownload.cse.ucsc.edu/goldenPath/$GENOME/database 

# bad genome regions
wgetFile ENCODE $GENOME-blacklist.v2.bed.gz https://github.com/Boyle-Lab/Blacklist/raw/master/lists

#-------------------------------------------------
# genome data from iGenomes
#-------------------------------------------------
IGENOMES_DIR=$GENOMES_DIR/iGenomes
mkdir -p $IGENOMES_DIR
cd $IGENOMES_DIR
checkPipe

# download the genome tar.gz file (it's big!)
echo
echo $IGENOME_URL
wget --no-verbose $IGENOME_URL
checkPipe

# extract all files _except_ the large .fa and aligner index files
tar xzf *.tar.gz \
  --exclude "*.fa" \
  --exclude "*/Bowtie2Index/*" \
  --exclude "*/BWAIndex/version*/*" \
  --exclude "*/BowtieIndex/*" \
  --exclude "*/Variation/snp*"
checkPipe
unlink *.tar.gz
checkPipe

}

#=====================================================
# sequentially download potentially multiple genomes
#=====================================================
installGenome hg38 Homo_sapiens
installGenome mm10 Mus_musculus

# report our success
echo
tree -h $GENOMES_DIR
echo
du --max-depth 1 -h $GENOMES_DIR
echo

# [wilsonte@wilsonte-n1 hg38]$ find . -type f -size +100M
# ./Annotation/Archives/archive-2015-08-14-08-18-15/Genes/genes.gtf
# ./Annotation/Archives/archive-2015-08-14-08-18-15/Genes.gencode/genes.gtf
# ./Sequence/Bowtie2Index/genome.1.bt2 ...
# ./Sequence/BWAIndex/version0.5.x/genome.fa.sa ...
# ./Sequence/Chromosomes/chr5.fa ...
# ./Sequence/BowtieIndex/genome.2.ebwt ...
# ./Sequence/WholeGenomeFasta/genome.fa

# [wilsonte@wilsonte-n1 mm10]$ find . -type f -size +100M
# ./Annotation/Archives/archive-2015-07-17-14-33-26/Variation/snp138.txt
# ./Annotation/Archives/archive-2013-03-06-15-06-02/Variation/snp137.txt.gz
# ./Annotation/Archives/archive-2014-05-23-16-05-10/Variation/snp137.txt
# ./Sequence/Bowtie2Index/genome.1.bt2 ...
# ./Sequence/BWAIndex/version0.5.x/genome.fa.sa ...
# ./Sequence/Chromosomes/chr5.fa ...
# ./Sequence/BowtieIndex/genome.2.ebwt ...
# ./Sequence/WholeGenomeFasta/genome.fa
