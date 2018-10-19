#!/bin/sh

#
# Downloads sequence for the a given version of the given species from
# ENSEMBL.
#
# The base files, named ??.fa.gz
#
# By default, this script builds and index for just the base files,
# since alignments to those sequences are the most useful. 
#two parameters
# $1 <integer> the release version of Ensembl
# $2 <string> the name of the species; '_' jointed name of multi words, lowercase. e.g., human = homo_sapiens;
#             A list of valid name can be found at ftp://ftp.ensembl.org/pub/release-94/fasta/
# $3 <string> the folder name, where you would like put the index into; relative path to this BASH file.

ENSBL_BASE=ftp://ftp.ensembl.org/pub/release-$1/fasta/$2/dna/

if test -z ${3}
then
      echo ${3} is not set. The index files will be generated in current directory.
	 
else
      echo The index files will be generated in ${3}.
	  mkdir -p ${3}
	  cd ${3}
fi

get() {
	file=$1
	if ! wget --version >/dev/null 2>/dev/null ; then
		if ! curl --version >/dev/null 2>/dev/null ; then
			echo "Please install wget or curl somewhere in your PATH"
			exit 1
		fi
		curl -o `basename $1` $1
		return $?
	else
		wget $1
		return $?
	fi
}

HISAT2_BUILD_EXE=./hisat2-build
if [ ! -x "$HISAT2_BUILD_EXE" ] ; then
	if ! which hisat2-build ; then
		echo "Could not find hisat2-build in current directory or in PATH"
		exit 1
	else
		HISAT2_BUILD_EXE=`which hisat2-build`
	fi
fi

rm -f genome.fa ## delete all existing seq files
for F in `curl -i ${ENSBL_BASE} | awk '{print $9}' | grep dna.chromosome.*.fa.gz`
do
	get ${ENSBL_BASE}/$F || (echo "Error getting $F" && exit 1)
	gunzip -c $F >> genome.fa || (echo "Error unzipping $F" && exit 1)
	rm $F
done
CMD="${HISAT2_BUILD_EXE} genome.fa genome"
echo Running $CMD
if $CMD ; then
	echo "genome index built; you may remove fasta files"
else
	echo "Index building failed; see error message"
fi

# get the matched GTFs

for F in `curl -i ftp://ftp.ensembl.org/pub/release-$1/gtf/$2/ | awk '{print $9}' | grep [0-9].gtf.gz`
do
	get ftp://ftp.ensembl.org/pub/release-$1/gtf/$2/$F || (echo "Error getting $F" && exit 1)
	gunzip $F || (echo "Error unzipping $F" && exit 1)
done
