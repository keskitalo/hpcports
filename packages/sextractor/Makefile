
include ../pkg_defs.make

# Package parameters

PKG_NAME = sextractor

PKG_FORMAT = tar
PKG_TAR = sextractor-$(PKG_VERSION).tar.gz
PKG_TAR_FETCH = $(WGET) -O $(HPCP_POOL)/$(PKG_TAR) http://www.astromatic.net/download/sextractor/sextractor-$(PKG_VERSION).tar.gz
PKG_TAR_EXTRACT = $(GXTAR)

PKG_SRCDIR = sextractor-$(PKG_VERSION)

PKG_BUILDDIR = $(PKG_SRCDIR)

PKG_PATCHES = hpcp_lapack.patch


# rules for this package

pkg-prefetch :
	@echo "" > /dev/null


pkg-configure :
	@cd $(STAGE)/$(PKG_BUILDDIR); \
	host=""; \
	if [ "x$(HPCP_CROSS_HOST)" != "x" ]; then \
		host="--host=$(HPCP_CROSS_HOST)"; \
	fi; \
	dyn=""; \
	if [ "x$(BUILD_DYNAMIC)" != "xTRUE" ]; then \
		dyn="--disable-shared --enable-static"; \
	fi; \
	chmod +x autogen.sh; \
	./autogen.sh; \
	CC="$(CC)" CFLAGS="$(CFLAGS)" \
	LDFLAGS="$(LDFLAGS)" LIBS="$(LIBS)" \
	./configure $${dyn} $${host} \
	--enable-threads \
	--with-lapacke="$(lapack_LIBS_CC) $(blas_LIBS_CC) $(FCLIBS) $(OMPFLAGS)" \
	--prefix=$(HPCP_PREFIX)/$(PKG_NAME)-$(PKG_FULLVERSION)


pkg-build :
	@cd $(STAGE)/$(PKG_BUILDDIR); \
	$(MAKE)


pkg-install :
	@cd $(STAGE)/$(PKG_BUILDDIR); \
	$(MAKE) install


pkg-clean :
	@cd $(STAGE)/$(PKG_BUILDDIR); \
	$(MAKE) clean


# Include common package rules

include ../pkg.make



