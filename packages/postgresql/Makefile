
include ../pkg_defs.make

# Package parameters

PKG_NAME = postgresql

PKG_FORMAT = tar
PKG_TAR = postgresql-$(PKG_VERSION).tar.bz2
PKG_TAR_FETCH = $(WGET) -O $(HPCP_POOL)/$(PKG_TAR) http://ftp.postgresql.org/pub/source/v$(PKG_VERSION)/postgresql-$(PKG_VERSION).tar.bz2
PKG_TAR_EXTRACT = $(BXTAR)

PKG_SRCDIR = postgresql-$(PKG_VERSION)

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
	dyn="--enable-shared --with-python"; \
	if [ "x$(BUILD_DYNAMIC)" != "xTRUE" ]; then \
		dyn="--disable-shared --without-python"; \
	fi; \
	CC="$(CC)" CFLAGS="$(CFLAGS)" \
	CPPFLAGS="-I$(openssl_PREFIX)/include" \
	LDFLAGS="-L$(openssl_PREFIX)/lib $(LDFLAGS)" \
	LIBS="$(LIBS)" \
	./configure $${dyn} $${host} \
	--with-openssl \
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



