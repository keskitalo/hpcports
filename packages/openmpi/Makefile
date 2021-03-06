
include ../pkg_defs.make

# Package parameters

PKG_NAME = openmpi

PKG_FORMAT = tar
PKG_TAR = openmpi-$(PKG_VERSION).tar.bz2
PKG_TAR_FETCH = $(WGET) -O $(HPCP_POOL)/$(PKG_TAR) http://www.open-mpi.org/software/ompi/v1.8/downloads/openmpi-$(PKG_VERSION).tar.bz2
PKG_TAR_EXTRACT = $(BXTAR)

PKG_SRCDIR = openmpi-$(PKG_VERSION)

PKG_BUILDDIR = $(PKG_SRCDIR)

PKG_PATCHES =


# rules for this package

pkg-prefetch :
	@echo "" > /dev/null


pkg-configure :
	@cd $(STAGE)/$(PKG_BUILDDIR); \
	dyn=""; \
	if [ "x$(BUILD_DYNAMIC)" != "xTRUE" ]; then \
		dyn="--disable-shared --enable-static --disable-dlopen"; \
	fi; \
	if [ "x$(BUILD_FORTRAN)" = "xFALSE" ]; then \
		fort="--disable-mpi-f77 --disable-mpi-f90"; \
	fi; \
	platform=""; \
	if [ -e ../../../../system/$(HPCP_HOST).openmpi_platform ]; then \
		platform="--with-platform=../../../../system/$(HPCP_HOST).openmpi_platform"; \
	fi; \
	CC="$(CC)" CFLAGS="$(CFLAGS)" \
	CXX="$(CXX)" CXXFLAGS="$(CXXFLAGS)" \
	FC="$(FC)" FCFLAGS="$(FCFLAGS)" \
	LDFLAGS="$(LDFLAGS)" LIBS="$(LIBS)" \
	./configure $${dyn} $${fort} $(openmpi_EXTRA) $${platform} \
	--disable-vt --disable-silent-rules \
	--prefix=$(HPCP_PREFIX)/$(PKG_NAME)-$(PKG_FULLVERSION)


pkg-build :
	@cd $(STAGE)/$(PKG_BUILDDIR); \
	$(MAKE)


pkg-install :
	@cd $(STAGE)/$(PKG_BUILDDIR); \
	$(MAKE) install; \
	if [ -e $(HPCP_PREFIX)/$(PKG_NAME)-$(PKG_FULLVERSION)/lib/mpi.mod ]; then \
		cp $(HPCP_PREFIX)/$(PKG_NAME)-$(PKG_FULLVERSION)/lib/mpi.mod $(HPCP_PREFIX)/$(PKG_NAME)-$(PKG_FULLVERSION)/include/mpi.mod; \
	fi; \
	if [ -e ../../../../system/$(HPCP_HOST).openmpi_conf ]; then \
		cat ../../../../system/$(HPCP_HOST).openmpi_conf >> $(HPCP_PREFIX)/$(PKG_NAME)-$(PKG_FULLVERSION)/etc/openmpi-mca-params.conf; \
	fi


pkg-clean :
	@cd $(STAGE)/$(PKG_BUILDDIR); \
	$(MAKE) clean


# Include common package rules

include ../pkg.make



