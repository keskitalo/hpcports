
GITHASH=$1
SUFFIX=$2

hpcp="--->"

echo "${hpcp}  Updating package list"

echo "# This file auto-generated by \"make update\" " > packages/pkg_list.make

pkgs=""
pkg_fetch=""
pkg_clean=""
pkg_purge=""
pkg_uninstall=""

for entry in `ls packages`; do
	if [ -d packages/${entry} ]; then
		ignore=`echo ${entry} | sed -e "s#overrides_.*#IGNORE#"`
		if [ "x${ignore}" != "xIGNORE" ]; then
			pkgs="${pkgs} ${entry}"
			pkg_fetch="${pkg_fetch} ${entry}-fetch"
			pkg_clean="${pkg_clean} ${entry}-clean"
			pkg_purge="${pkg_purge} ${entry}-purge"
			pkg_uninstall="${pkg_uninstall} ${entry}-uninstall"
		fi
	fi
done

echo "PKGS =${pkgs}" >> packages/pkg_list.make


echo "${hpcp}  Generating package build rules and dependencies"

echo "# This file auto-generated by \"make update\" " > packages/pkg_rules.make

echo "" >> packages/pkg_rules.make
echo "fetch : ${pkg_fetch}" >> packages/pkg_rules.make
echo "clean : ${pkg_clean}" >> packages/pkg_rules.make
echo "purge : ${pkg_purge}" >> packages/pkg_rules.make
echo "uninstall : ${pkg_uninstall}" >> packages/pkg_rules.make

for pkg in ${pkgs}; do

	echo "" >> packages/pkg_rules.make
	
	deps=`head -n 1 packages/${pkg}/deps`

	if [ ${pkg} = hpcp ]; then
		echo "${pkg} : ${deps}" >> packages/pkg_rules.make
	else
		echo "${pkg} : hpcp ${deps}" >> packages/pkg_rules.make
	fi

	echo "" >> packages/pkg_rules.make

	echo "${pkg} : install-common" >> packages/pkg_rules.make
	echo "	@if [ \"x\$(${pkg}_OVERRIDE)\" != \"xTRUE\" ]; then \\" >> packages/pkg_rules.make
	echo "		cd packages/${pkg}; \$(MAKE) install; \\" >> packages/pkg_rules.make
	echo "	else \\" >> packages/pkg_rules.make
	echo "		echo \"\$(HPCP)  ${pkg}:  Installing (module for overridden package)\"; \\" >> packages/pkg_rules.make
	echo "		mkdir -p packages/overrides_\$(HPCP_TARGET); \\" >> packages/pkg_rules.make
	echo "		cd packages/overrides_\$(HPCP_TARGET); \\" >> packages/pkg_rules.make
	echo "		touch ${pkg}; \\" >> packages/pkg_rules.make
	echo "		\$(SHELL) ../../tools/pkg_override.sh ${pkg} \$(HPCP_ENV) \"x\$(${pkg}_PREFIX)\" \"x\$(${pkg}_VERSION)\" \"x\$(${pkg}_CPPFLAGS)\" \"x\$(${pkg}_LDFLAGS)\" \"x\$(${pkg}_DATA)\" \"x\$(${pkg}_LIBS_CC)\" \"x\$(${pkg}_LIBS_CXX)\" \"x\$(${pkg}_LIBS_F77)\" \"x\$(${pkg}_LIBS_FC)\" \"x\$(${pkg}_LIBS_MPICC)\" \"x\$(${pkg}_LIBS_MPICXX)\" \"x\$(${pkg}_LIBS_MPIF77)\" \"x\$(${pkg}_LIBS_MPIFC)\"; \\" >> packages/pkg_rules.make
	echo "		mkdir -p \$(HPCP_PREFIX)/env/modulefiles/${pkg}${SUFFIX}; \\" >> packages/pkg_rules.make
	echo "		if [ -e \$(HPCP_PREFIX)/env/modulefiles/${pkg}${SUFFIX}/.version ]; then \\" >> packages/pkg_rules.make
	echo "			mv \$(HPCP_PREFIX)/env/modulefiles/${pkg}${SUFFIX}/.version \$(HPCP_PREFIX)/env/modulefiles/${pkg}${SUFFIX}/.oldversion; \\" >> packages/pkg_rules.make
	echo "		fi; \\" >> packages/pkg_rules.make
	echo "		cp ${pkg}.module \$(HPCP_PREFIX)/env/modulefiles/${pkg}${SUFFIX}/\$(${pkg}_VERSION)-\$(HPCP_ENV); \\" >> packages/pkg_rules.make
	echo "		cp ${pkg}.version \$(HPCP_PREFIX)/env/modulefiles/${pkg}${SUFFIX}/.version; \\" >> packages/pkg_rules.make
	echo "		chgrp -R \$(INST_GRP) \$(HPCP_PREFIX)/env/modulefiles/${pkg}${SUFFIX}; \\" >> packages/pkg_rules.make
	echo "		chmod -R \$(INST_PERM) \$(HPCP_PREFIX)/env/modulefiles/${pkg}${SUFFIX}; \\" >> packages/pkg_rules.make
	echo "	fi" >> packages/pkg_rules.make


	echo "" >> packages/pkg_rules.make
	echo "${pkg}-fetch :" >> packages/pkg_rules.make
	echo "	@if [ \"x\$(${pkg}_OVERRIDE)\" != \"xTRUE\" ]; then \\" >> packages/pkg_rules.make
	echo "		cd packages/${pkg}; \$(MAKE) fetch; \\" >> packages/pkg_rules.make
	echo "	fi" >> packages/pkg_rules.make


	echo "" >> packages/pkg_rules.make
	echo "${pkg}-clean :" >> packages/pkg_rules.make
	echo "	@if [ \"x\$(${pkg}_OVERRIDE)\" != \"xTRUE\" ]; then \\" >> packages/pkg_rules.make
	echo "		cd packages/${pkg}; \$(MAKE) clean; \\" >> packages/pkg_rules.make
	echo "	else \\" >> packages/pkg_rules.make
	echo "		rm -f packages/overrides_\$(HPCP_TARGET)/${pkg}; \\" >> packages/pkg_rules.make
	echo "		rm -f packages/overrides_\$(HPCP_TARGET)/${pkg}.module; \\" >> packages/pkg_rules.make
	echo "		rm -f packages/overrides_\$(HPCP_TARGET)/${pkg}.version; \\" >> packages/pkg_rules.make
	echo "	fi" >> packages/pkg_rules.make


	echo "" >> packages/pkg_rules.make
	echo "${pkg}-uninstall :" >> packages/pkg_rules.make
	echo "	@if [ \"x\$(${pkg}_OVERRIDE)\" != \"xTRUE\" ]; then \\" >> packages/pkg_rules.make
	echo "		cd packages/${pkg}; \$(MAKE) uninstall; \\" >> packages/pkg_rules.make
	echo "	else \\" >> packages/pkg_rules.make
	echo "		echo \"\$(HPCP)  ${pkg}:  Uninstalling (module for overridden package)\"; \\" >> packages/pkg_rules.make
	echo "		rm -f \$(HPCP_PREFIX)/env/${pkg}-\$(${pkg}_VERSION).sh; \\" >> packages/pkg_rules.make
	echo "		rm -f \$(HPCP_PREFIX)/env/modulefiles/${pkg}${SUFFIX}/\$(${pkg}_VERSION)-\$(HPCP_ENV); \\" >> packages/pkg_rules.make
	echo "		rm -f \$(HPCP_PREFIX)/env/modulefiles/${pkg}${SUFFIX}/.version; \\" >> packages/pkg_rules.make
	echo "		if [ -e \$(HPCP_PREFIX)/env/modulefiles/${pkg}${SUFFIX}/.oldversion ]; then \\" >> packages/pkg_rules.make
	echo "			mv \$(HPCP_PREFIX)/env/modulefiles/${pkg}${SUFFIX}/.oldversion \$(HPCP_PREFIX)/env/modulefiles/${pkg}${SUFFIX}/.version; \\" >> packages/pkg_rules.make
	echo "		else \\" >> packages/pkg_rules.make
	echo "			rm -rf \$(HPCP_PREFIX)/env/modulefiles/${pkg}${SUFFIX}; \\" >> packages/pkg_rules.make
	echo "		fi \\" >> packages/pkg_rules.make
	echo "	fi" >> packages/pkg_rules.make


	echo "" >> packages/pkg_rules.make
	echo "${pkg}-purge :" >> packages/pkg_rules.make
	echo "	@if [ \"x\$(${pkg}_OVERRIDE)\" != \"xTRUE\" ]; then \\" >> packages/pkg_rules.make
	echo "		cd packages/${pkg}; \$(MAKE) purge; \\" >> packages/pkg_rules.make
	echo "	else \\" >> packages/pkg_rules.make
	echo "		rm -f packages/overrides_\$(HPCP_TARGET)/${pkg}; \\" >> packages/pkg_rules.make
	echo "		rm -f packages/overrides_\$(HPCP_TARGET)/${pkg}.module; \\" >> packages/pkg_rules.make
	echo "		rm -f packages/overrides_\$(HPCP_TARGET)/${pkg}.version; \\" >> packages/pkg_rules.make
	echo "	fi" >> packages/pkg_rules.make

done


echo "" >> packages/pkg_rules.make


touch packages/up2date.${GITHASH}


