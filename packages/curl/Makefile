
include ../pkg_defs.make

# Package parameters

PKG_NAME = curl

PKG_FORMAT = tar
PKG_TAR = curl-$(PKG_VERSION).tar.bz2
PKG_TAR_FETCH = $(WGET) -O $(HPCP_POOL)/$(PKG_TAR) http://curl.haxx.se/download/curl-$(PKG_VERSION).tar.bz2
PKG_TAR_EXTRACT = $(BXTAR)

PKG_SRCDIR = curl-$(PKG_VERSION)

PKG_BUILDDIR = $(PKG_SRCDIR)

PKG_PATCHES =


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
		dyn="--disable-shared"; \
	fi; \
	cf=`echo "$(CFLAGS)" | sed -e "s#-D[^ ]*##g"`; \
	cpf=`echo "$(CFLAGS)" | sed -e "s#-[^D][^ ]*##g"`; \
	CC="$(CC)" CFLAGS="$${cf}" CPPFLAGS="$${cpf}" \
	LDFLAGS="$(LDFLAGS)" \
	LIBS="$(openssl_LIBS_CC) $(zlib_LIBS_CC) $(LIBS)" \
	CXX="$(CXX)" CXXFLAGS="$(CXXFLAGS)" \
	F77="$(F77)" FFLAGS="$(FFLAGS)" \
	FC="$(FC)" FCFLAGS="$(FCFLAGS)" \
	./configure $${dyn} $${host} \
	--with-ssl="$(openssl_PREFIX)" \
	--with-zlib="$(zlib_PREFIX)" \
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



