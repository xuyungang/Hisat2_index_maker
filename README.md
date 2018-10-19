# Hisat2_Index_Maker
# Used to generate the HISAT2 index files from the ENSEMBL genomes.
## Usage
download the .sh file, and run it in command line:

bash make_ensmbl_index.sh <release_version> <species_name> [out_directory]

## parameters
<release_version> <integer> required; the release version number of Ensembl.
  
<species_name> <string> required; the name of the species for which you build the genome index;
  
  a list of valid names can be found at, for example the release 94, ftp://ftp.ensembl.org/pub/release-94/fasta/;
  
  you may change the release number to check the availability of other releases.
  
  [out_directory] optional; the folder name, where you would like put the index into; relative path to this BASH file.

## Example
  bash make_ensmbl_index.sh 94 homo_sapiens CRCh38.94 
  
  When it's done, the index files will be located in the folder GRCh38.94/, including files: genome.fa, index files and matched gtf files.
