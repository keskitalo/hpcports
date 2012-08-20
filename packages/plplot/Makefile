
# System configuration

include ../../system/$(HPCP_TARGET).make
include ../../system/defaults.make

# Package version

PKG_VERSION := $(shell head -n 1 version)

# Package parameters

PKG_NAME = plplot

PKG_FORMAT = tar
PKG_TAR = plplot-$(PKG_VERSION).tar.bz2
PKG_TAR_FETCH = $(WGET) -O $(HPCP_POOL)/$(PKG_TAR) http://sourceforge.net/projects/plplot/files/plplot/$(PKG_VERSION)%20Source/plplot-$(PKG_VERSION).tar.gz/download
PKG_TAR_EXTRACT = $(BXTAR)

PKG_SRCDIR = plplot-$(PKG_VERSION)

PKG_BUILDDIR = $(PKG_SRCDIR)/build

PKG_PATCHES =


# rules for this package

pkg-prefetch :
	@echo "" > /dev/null


pkg-configure :
	@cd $(STAGE); \
	mkdir -p $(PKG_BUILDDIR); \
	cd $(PKG_BUILDDIR); \
	dyn="-DBUILD_SHARED_LIBS:BOOL=ON"; \
	if [ "x$(BUILD_DYNAMIC)" != "xTRUE" ]; then \
		dyn="-DBUILD_SHARED_LIBS:BOOL=OFF"; \
	fi; \
	CC="$(CC) $(CFLAGS)" \
	LDFLAGS="$(LDFLAGS)" \
	LIBS="$(LIBS)" \
	CXX="$(CXX) $(CXXFLAGS)" \
	FC="$(F77) $(FFLAGS)" \
	cmake \
	$${dyn} \
	-DCMAKE_INSTALL_PREFIX=$(HPCP_PREFIX)/$(PKG_NAME)-$(PKG_VERSION) \
	..


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


