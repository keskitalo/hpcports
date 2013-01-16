
# This generates the shell snippet which exports the per-package
# environment variables, and also the module file.  Also generate
# the shell snippet sourced by configure and other targets that need
# dependency information.

PKG=$1
VER=$2
PREFIX=$3
TARGET=$4
ENV=$5
PYSITE=$6
MOD=$7

# dependency names

deps=`head -n 1 ../deps`

# find conflicting packages

conflict=""
if [ -e "../conflict" ]; then
	conflict=`head -n 1 ../conflict`
fi

# File headers

echo "# This file auto-generated by \"make extract\" " > ${PKG}-${VER}.sh

echo '#%Module###<-magic cookie ####################################################
##' > ${PKG}.module
echo "##   ${PKG} " >> ${PKG}.module
echo '##   HPCPorts module file
##
##
# variables for Tcl script use only' >> ${PKG}.module
echo "set     version  ${VER}" >> ${PKG}.module
echo "set     prefix   ${PREFIX}/${PKG}-${VER}" >> ${PKG}.module
echo "" >> ${PKG}.module
echo "module-whatis \"Loads the HPCPorts version of ${PKG}\"" >> ${PKG}.module
echo "" >> ${PKG}.module

# Add dependencies to package env shell script

for dep in ${deps}; do
	if [ ! -e ../../overrides_${TARGET}/${dep} ]; then
		# FIXME!!!  This does not handle dependencies with generated versions.
		# This means that all packages with generated versions that are not
		# equal to $(HPCP_ENV) cannot be used as dependencies.
		depver=${ENV}
		if [ -e ../../${dep}/version ]; then
			depver=`head -n 1 ../../${dep}/version`
		fi
		echo "source ${PREFIX}/env/${dep}-${depver}.sh" >> ${PKG}-${VER}.sh
	else
		# grab the package version from the module version file
		depver=`cat ../../overrides_${TARGET}/${dep}.version | grep ModulesVersion | sed -e "s#.*\"\(.*\)-${ENV}\".*#\1#"`
		echo "source ${PREFIX}/env/${dep}-${depver}.sh" >> ${PKG}-${VER}.sh
	fi
done

# Process package vars:

process_var () {
	var=$1
	shift
	shift
	vals=$@
	if [ ! "x${vals}" = "x" ]; then
		if [ "x${var}" = "xpath" ]; then
			for val in ${vals}; do
				echo "export PATH=\"${PREFIX}/${PKG}-${VER}/${val}:\${PATH}\"" >> ${PKG}-${VER}.sh
				echo "prepend-path PATH \"${PREFIX}/${PKG}-${VER}/${val}\"" >> ${PKG}.module
			done
		elif [ "x${var}" = "xman" ]; then
			for val in ${vals}; do
				echo "export MANPATH=\"${PREFIX}/${PKG}-${VER}/${val}:\${MANPATH}\"" >> ${PKG}-${VER}.sh
				echo "prepend-path MANPATH \"${PREFIX}/${PKG}-${VER}/${val}\"" >> ${PKG}.module
			done
		elif [ "x${var}" = "xpython" ]; then
			for val in ${vals}; do
				echo "export PYTHONPATH=\"${PREFIX}/${PKG}-${VER}/${val}/${PYSITE}/site-packages:\${PYTHONPATH}\"" >> ${PKG}-${VER}.sh
				echo "prepend-path PYTHONPATH \"${PREFIX}/${PKG}-${VER}/${val}/${PYSITE}/site-packages\"" >> ${PKG}.module
			done
		elif [ "x${var}" = "xheader" ]; then
			for val in ${vals}; do
				echo "export CPATH=\"${PREFIX}/${PKG}-${VER}/${val}:\${CPATH}\"" >> ${PKG}-${VER}.sh
				echo "prepend-path CPATH \"${PREFIX}/${PKG}-${VER}/${val}\"" >> ${PKG}.module
			done
		elif [ "x${var}" = "xdata" ]; then
			echo "export ${PKG}_DATA=\"${vals}\"" >> ${PKG}-${VER}.sh
			echo "setenv ${PKG}_DATA \"${vals}\"" >> ${PKG}.module
		elif [ "x${var}" = "xld" ]; then
			for val in ${vals}; do
				echo "export LIBRARY_PATH=\"${PREFIX}/${PKG}-${VER}/${val}:\${LIBRARY_PATH}\"" >> ${PKG}-${VER}.sh
				echo "export LD_LIBRARY_PATH=\"${PREFIX}/${PKG}-${VER}/${val}:\${LD_LIBRARY_PATH}\"" >> ${PKG}-${VER}.sh
				echo "prepend-path LIBRARY_PATH \"${PREFIX}/${PKG}-${VER}/${val}\"" >> ${PKG}.module
				echo "prepend-path LD_LIBRARY_PATH \"${PREFIX}/${PKG}-${VER}/${val}\"" >> ${PKG}.module
			done
		elif [ "x${var}" = "xlib_CC" ]; then
			echo "export ${PKG}_LIBS_CC=\"${vals}\"" >> ${PKG}-${VER}.sh
			echo "setenv ${PKG}_LIBS_CC \"${vals}\"" >> ${PKG}.module
		elif [ "x${var}" = "xlib_CXX" ]; then
			echo "export ${PKG}_LIBS_CXX=\"${vals}\"" >> ${PKG}-${VER}.sh
			echo "setenv ${PKG}_LIBS_CXX \"${vals}\"" >> ${PKG}.module
		elif [ "x${var}" = "xlib_F77" ]; then
			echo "export ${PKG}_LIBS_F77=\"${vals}\"" >> ${PKG}-${VER}.sh
			echo "setenv ${PKG}_LIBS_F77 \"${vals}\"" >> ${PKG}.module
		elif [ "x${var}" = "xlib_FC" ]; then
			echo "export ${PKG}_LIBS_FC=\"${vals}\"" >> ${PKG}-${VER}.sh
			echo "setenv ${PKG}_LIBS_FC \"${vals}\"" >> ${PKG}.module
		elif [ "x${var}" = "xlib_MPICC" ]; then
			echo "export ${PKG}_LIBS_MPICC=\"${vals}\"" >> ${PKG}-${VER}.sh
			echo "setenv ${PKG}_LIBS_MPICC \"${vals}\"" >> ${PKG}.module
		elif [ "x${var}" = "xlib_MPICXX" ]; then
			echo "export ${PKG}_LIBS_MPICXX=\"${vals}\"" >> ${PKG}-${VER}.sh
			echo "setenv ${PKG}_LIBS_MPICXX \"${vals}\"" >> ${PKG}.module
		elif [ "x${var}" = "xlib_MPIF77" ]; then
			echo "export ${PKG}_LIBS_MPIF77=\"${vals}\"" >> ${PKG}-${VER}.sh
			echo "setenv ${PKG}_LIBS_MPIF77 \"${vals}\"" >> ${PKG}.module
		elif [ "x${var}" = "xlib_MPIFC" ]; then
			echo "export ${PKG}_LIBS_MPIFC=\"${vals}\"" >> ${PKG}-${VER}.sh
			echo "setenv ${PKG}_LIBS_MPIFC \"${vals}\"" >> ${PKG}.module
		else
			echo "export ${var}=\"${vals}\"" >> ${PKG}-${VER}.sh
			echo "setenv ${var} \"${vals}\"" >> ${PKG}.module
		fi
	fi
	return 0
}

echo "export ${PKG}_PREFIX=\"${PREFIX}/${PKG}-${VER}\"" >> ${PKG}-${VER}.sh
echo "setenv ${PKG}_PREFIX \"${PREFIX}/${PKG}-${VER}\"" >> ${PKG}.module
echo "export ${PKG}_VERSION=\"${VER}\"" >> ${PKG}-${VER}.sh
echo "setenv ${PKG}_VERSION \"${VER}\"" >> ${PKG}.module

cat ../vars | \
while read line; do
	process_var ${line}
done

echo "" >> ${PKG}.module

if [ ${PKG} = "hpcp" ]; then
	cat base.module >> ${PKG}.module
	echo "" >> ${PKG}.module
fi


# module file boiler-plate

echo "proc ModulesHelp { } {" >> ${PKG}.module
echo "  global version" >> ${PKG}.module
echo "  puts stderr \"\\\t    ${PKG} - Version \$version\\\n\"" >> ${PKG}.module
echo "  puts stderr \"\\\t This module file was auto-generated for the ${PKG}\"" >> ${PKG}.module
echo "  puts stderr \"\\\t package as part of the HPCPorts installation system.\"" >> ${PKG}.module
echo "  puts stderr \"\\\t In general, this module may modify the PATH,\"" >> ${PKG}.module
echo "  puts stderr \"\\\t LD_LIBRARY_PATH, and MANPATH environment variables,\"" >> ${PKG}.module
echo "  puts stderr \"\\\t as well as setting any variables needed for compiling\"" >> ${PKG}.module
echo "  puts stderr \"\\\t and linking against libraries in this package.\"" >> ${PKG}.module
echo "  puts stderr \"\"" >> ${PKG}.module
echo "}" >> ${PKG}.module
echo "" >> ${PKG}.module

# Add conflicts

echo "conflict ${PKG}${MOD}" >> ${PKG}.module
for con in ${conflict}; do
	echo "conflict ${con}${MOD}" >> ${PKG}.module
done
echo "" >> ${PKG}.module

# Handle dependencies

echo "# This file auto-generated by \"make extract\" " > dep_env.sh

for dep in ${deps}; do
	depver=""
	if [ -e ../../overrides_${TARGET}/${dep} ]; then
		echo "if [ module-info mode load ] {" >> ${PKG}.module
		echo "	if [ is-loaded ${dep}${MOD} ] {" >> ${PKG}.module
		echo "	} else {" >> ${PKG}.module
		echo "	  module load ${dep}${MOD}" >> ${PKG}.module
		echo "	}" >> ${PKG}.module
		echo "}" >> ${PKG}.module
		echo "" >> ${PKG}.module
		# grab the package version from the module version file
		depver=`cat ../../overrides_${TARGET}/${dep}.version | grep ModulesVersion | sed -e "s#.*\"\(.*\)-${ENV}\".*#\1#"`
	else
		# FIXME!!!  This does not handle dependencies with generated versions.
		# This means that all packages with generated versions that are not
		# equal to $(HPCP_ENV) cannot be used as dependencies.
		depver=${ENV}
		if [ -e ../../${dep}/version ]; then
			depver=`head -n 1 ../../${dep}/version`
		fi
		echo "if [ module-info mode load ] {" >> ${PKG}.module
		echo "	if [ is-loaded ${dep}${MOD} ] {" >> ${PKG}.module
		echo "	} else {" >> ${PKG}.module
		echo "	  module load ${dep}${MOD}/${depver}-${ENV}" >> ${PKG}.module
		echo "	}" >> ${PKG}.module
		echo "}" >> ${PKG}.module
		echo "" >> ${PKG}.module
	fi
	echo "source ${PREFIX}/env/${dep}-${depver}.sh" >> dep_env.sh
done

if [ ${PKG} = "hpcp" ]; then
	if [ -e ../../../system/${TARGET}.module ]; then
		echo "if [ module-info mode load ] {" >> ${PKG}.module
		cat ../../../system/${TARGET}.module >> ${PKG}.module
		echo "}" >> ${PKG}.module
		echo "" >> ${PKG}.module
	fi
else
	echo "if [ module-info mode load ] {" >> ${PKG}.module
	echo "	if [ is-loaded hpcp ] {" >> ${PKG}.module
	echo "	} else {" >> ${PKG}.module
	echo "	  module load hpcp/${ENV}" >> ${PKG}.module
	echo "	}" >> ${PKG}.module
	echo "}" >> ${PKG}.module
	echo "" >> ${PKG}.module
fi

echo "" >> ${PKG}.module

# module file version

echo '#%Module###################################################################
####' > ${PKG}.version
echo "## version file for ${PKG}${MOD}" >> ${PKG}.version
echo '##' >> ${PKG}.version
if [ ${PKG} = "hpcp" ]; then
	echo "set ModulesVersion      \"${VER}\"" >> ${PKG}.version
else
	echo "set ModulesVersion      \"${VER}-${ENV}\"" >> ${PKG}.version
fi


