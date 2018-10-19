# Hisat2_Index_Maker
# Used to generate the HISAT2 index files from the ENSEMBL genomes.
## Usage
download the .sh file, and run it in command line:\n
bash make_ensmbl_index.sh <release_version> <species_name> [out_directory]\n

## parameters
release_version <integer> required; the release version number of Ensembl.\n
species_name <string> required; the name of the species for which you build the genome index;\n
  a list of valid names can be found at, for example the release 94, ftp://ftp.ensembl.org/pub/release-94/fasta/;\n
  you may change the release number to check the availability of other releases.\n
out_directory optional; the folder name, where you would like put the index into; relative path to this BASH file.\n

## Example
  bash make_ensmbl_index.sh 94 homo_sapiens CRCh38.94 \n
  after the fished, the index files will be located in the folder GRCh38.94/, including files: genome.fa, index files and matched gtf files.\n
