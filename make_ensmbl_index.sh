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

#get the matched GTFs
get ftp://ftp.ensembl.org/pub/release-$1/gtf/$2/*.gtf.gz
gunzip *.gtf.gz

:'
acanthochromis_polyacanthus
ailuropoda_melanoleuca
amphilophus_citrinellus
amphiprion_ocellaris
amphiprion_percula
anabas_testudineus
anas_platyrhynchos
anolis_carolinensis
aotus_nancymaae
astatotilapia_calliptera
astyanax_mexicanus
bos_taurus
caenorhabditis_elegans
callithrix_jacchus
canis_familiaris
capra_hircus
carlito_syrichta
cavia_aperea
cavia_porcellus
cebus_capucinus
cercocebus_atys
chinchilla_lanigera
chlorocebus_sabaeus
choloepus_hoffmanni
ciona_intestinalis
ciona_savignyi
colobus_angolensis_palliatus
cricetulus_griseus_chok1gshd
cricetulus_griseus_crigri
cynoglossus_semilaevis
cyprinodon_variegatus
danio_rerio
dasypus_novemcinctus
dipodomys_ordii
drosophila_melanogaster
echinops_telfairi
eptatretus_burgeri
equus_caballus
erinaceus_europaeus
esox_lucius
felis_catus
ficedula_albicollis
fukomys_damarensis
fundulus_heteroclitus
gadus_morhua
gallus_gallus
gambusia_affinis
gasterosteus_aculeatus
gorilla_gorilla
haplochromis_burtoni
heterocephalus_glaber_female
heterocephalus_glaber_male
hippocampus_comes
homo_sapiens
ictalurus_punctatus
ictidomys_tridecemlineatus
jaculus_jaculus
kryptolebias_marmoratus
labrus_bergylta
latimeria_chalumnae
lepisosteus_oculatus
loxodonta_africana
macaca_fascicularis
macaca_mulatta
macaca_nemestrina
mandrillus_leucophaeus
mastacembelus_armatus
maylandia_zebra
meleagris_gallopavo
mesocricetus_auratus
microcebus_murinus
microtus_ochrogaster
mola_mola
monodelphis_domestica
monopterus_albus
mus_caroli
mus_musculus
mus_musculus_129s1svimj
mus_musculus_aj
mus_musculus_akrj
mus_musculus_balbcj
mus_musculus_c3hhej
mus_musculus_c57bl6nj
mus_musculus_casteij
mus_musculus_cbaj
mus_musculus_dba2j
mus_musculus_fvbnj
mus_musculus_lpj
mus_musculus_nodshiltj/		9/6/18, 12:33:00 AM
mus_musculus_nzohlltj/		9/5/18, 11:41:00 PM
mus_musculus_pwkphj/		9/6/18, 12:37:00 AM
mus_musculus_wsbeij/		9/6/18, 1:42:00 AM
mus_pahari/		9/5/18, 10:11:00 PM
mus_spretus/		9/6/18, 5:03:00 AM
mustela_putorius_furo/		9/6/18, 3:09:00 AM
myotis_lucifugus/		9/6/18, 3:10:00 AM
nannospalax_galili/		9/5/18, 10:56:00 PM
neolamprologus_brichardi/		9/6/18, 2:22:00 AM
nomascus_leucogenys/		9/6/18, 1:29:00 AM
notamacropus_eugenii/		9/5/18, 8:04:00 AM
ochotona_princeps/		9/5/18, 9:25:00 PM
octodon_degus/		9/6/18, 7:18:00 AM
oreochromis_niloticus/		9/5/18, 2:36:00 AM
ornithorhynchus_anatinus/		9/5/18, 10:14:00 PM
oryctolagus_cuniculus/		9/6/18, 6:04:00 AM
oryzias_latipes/		9/6/18, 2:03:00 AM
oryzias_latipes_hni/		9/6/18, 12:15:00 AM
oryzias_latipes_hsok/		9/6/18, 5:46:00 AM
oryzias_melastigma/		9/6/18, 5:26:00 AM
otolemur_garnettii/		9/5/18, 1:36:00 AM
ovis_aries/		9/6/18, 3:57:00 AM
pan_paniscus/		9/6/18, 5:02:00 AM
pan_troglodytes/		9/6/18, 12:16:00 AM
panthera_pardus/		9/4/18, 8:56:00 PM
panthera_tigris_altaica/		9/6/18, 7:37:00 AM
papio_anubis/		9/6/18, 3:25:00 AM
paramormyrops_kingsleyae/		9/6/18, 1:44:00 AM
pelodiscus_sinensis/		9/6/18, 2:53:00 AM
periophthalmus_magnuspinnatus/		9/5/18, 11:55:00 PM
peromyscus_maniculatus_bairdii/		9/6/18, 2:12:00 AM
petromyzon_marinus/		9/5/18, 1:49:00 PM
poecilia_formosa/		9/6/18, 5:03:00 AM
poecilia_latipinna/		9/4/18, 8:47:00 PM
poecilia_mexicana/		9/6/18, 1:57:00 AM
poecilia_reticulata/		9/6/18, 4:50:00 AM
pongo_abelii/		9/6/18, 4:28:00 AM
procavia_capensis/		9/4/18, 10:13:00 PM
propithecus_coquereli/		9/5/18, 10:13:00 PM
pteropus_vampyrus/		9/6/18, 6:22:00 AM
pundamilia_nyererei/		9/6/18, 3:19:00 AM
pygocentrus_nattereri/		9/6/18, 3:26:00 AM
rattus_norvegicus/		9/6/18, 12:17:00 AM
rhinopithecus_bieti/		9/6/18, 4:11:00 AM
rhinopithecus_roxellana/		9/4/18, 11:22:00 PM
saccharomyces_cerevisiae/		9/6/18, 1:47:00 AM
saimiri_boliviensis_boliviensis/		9/5/18, 8:12:00 PM
sarcophilus_harrisii/		9/6/18, 5:47:00 AM
scleropages_formosus/		9/6/18, 2:19:00 AM
scophthalmus_maximus/		9/6/18, 7:15:00 AM
seriola_dumerili/		9/6/18, 5:39:00 AM
seriola_lalandi_dorsalis/		9/6/18, 2:00:00 AM
sorex_araneus/		9/6/18, 7:24:00 AM
stegastes_partitus/		9/6/18, 3:37:00 AM
sus_scrofa/		9/5/18, 6:18:00 PM
taeniopygia_guttata/		9/5/18, 10:28:00 PM
takifugu_rubripes/		9/5/18, 11:07:00 PM
tetraodon_nigroviridis/		9/6/18, 2:49:00 AM
tupaia_belangeri/		9/6/18, 6:17:00 AM
tursiops_truncatus/		9/6/18, 2:10:00 AM
vicugna_pacos/		9/5/18, 11:08:00 PM
xenopus_tropicalis/		9/6/18, 1:48:00 AM
xiphophorus_couchianus/		9/6/18, 2:54:00 AM
xiphophorus_maculatus/		9/5/18, 6:46:00 AM
'
