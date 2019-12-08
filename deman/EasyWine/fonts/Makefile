TOPSRCDIR = ..
TOPOBJDIR = ..
SRCDIR    = .

MODULE    = none
fontdir   = $(datadir)/fonts/wine

BITMAP_FONTS  = \
	wine_coure.fon \
	wine_couree.fon \
	wine_courer.fon \
	wine_sserife.fon \
	wine_sserifee.fon \
	wine_sserifer.fon \
	wine_vgasys.fon \
	wine_vgasyse.fon \
	wine_vgasysr.fon

TRUETYPE_FONTS = \
	wine_marlett.ttf

FONTS = \
	$(BITMAP_FONTS) \
	$(TRUETYPE_FONTS)

all: $(FONTS)


# Global rules shared by all makefiles     -*-Makefile-*-
#
# Each individual makefile must define the following variables:
# TOPSRCDIR    : top-level source directory
# TOPOBJDIR    : top-level object directory
# SRCDIR       : source directory for this module
# MODULE       : name of the module being built
#
# Each individual makefile may define the following additional variables:
# C_SRCS       : C sources for the module
# C_SRCS16     : 16-bit C sources for the module
# RC_SRCS      : resource source files
# EXTRA_SRCS   : extra source files for make depend
# EXTRA_OBJS   : extra object files
# IMPORTS      : dlls to import
# DELAYIMPORTS : dlls to import in delayed mode
# SUBDIRS      : subdirectories that contain a Makefile
# EXTRASUBDIRS : subdirectories that do not contain a Makefile
# INSTALLSUBDIRS : subdirectories to run make install/uninstall into

# First some useful definitions

SHELL     = /bin/sh
CC        = gcc
CFLAGS    = -g -O2
CPPFLAGS  = 
LIBS      = 
BISON     = bison
YACC      = $(BISON) -y
LEX       = flex
LEXLIB    = -lfl
EXEEXT    = 
OBJEXT    = o
LIBEXT    = so
DLLEXT    = .so
IMPLIBEXT = def
LDSHARED  = $(CC) -shared $(SONAME:%=-Wl,-soname,%) $(VERSCRIPT:%=-Wl,--version-script=%)
DLLTOOL   = i586-mingw32msvc-dlltool
DLLWRAP   = 
AR        = ar rc
RANLIB    = ranlib
STRIP     = strip
WINDRES   = false
LN        = ln
LN_S      = ln -s
TOOLSDIR  = $(TOPOBJDIR)
AS        = as
LD        = ld
LDFLAGS   = 
RM        = rm -f
MV        = mv
LINT      = 
LINTFLAGS = 
FONTFORGE = fontforge
INCLUDES     = -I$(SRCDIR) -I. -I$(TOPSRCDIR)/include -I$(TOPOBJDIR)/include $(EXTRAINCL)
EXTRACFLAGS  = -Wall -pipe -mpreferred-stack-boundary=2 -fno-strict-aliasing -gstabs+ -Wpointer-arith
ALLCFLAGS    = $(INCLUDES) $(DEFS) $(DLLFLAGS) $(EXTRACFLAGS) $(CPPFLAGS) $(CFLAGS)
ALLLINTFLAGS = $(INCLUDES) $(DEFS) $(LINTFLAGS)
IDLFLAGS     = $(INCLUDES) $(DEFS) $(EXTRAIDLFLAGS)
MKINSTALLDIRS= $(TOPSRCDIR)/tools/mkinstalldirs -m 755
WINAPI_CHECK = $(TOPSRCDIR)/tools/winapi_check/winapi_check
WINEWRAPPER  = $(TOPSRCDIR)/tools/winewrapper
C2MAN        = $(TOPSRCDIR)/tools/c2man.pl
RUNTEST      = $(TOPSRCDIR)/tools/runtest
WINEBUILD    = $(TOOLSDIR)/tools/winebuild/winebuild
MAKEDEP      = $(TOOLSDIR)/tools/makedep
WRC          = $(TOOLSDIR)/tools/wrc/wrc
BIN2RES      = $(TOOLSDIR)/tools/bin2res
WMC          = $(TOOLSDIR)/tools/wmc/wmc
WIDL         = $(TOOLSDIR)/tools/widl/widl
WINEGCC      = $(TOOLSDIR)/tools/winegcc/winegcc
SFNT2FNT     = $(TOOLSDIR)/tools/sfnt2fnt
FNT2FON      = $(TOOLSDIR)/tools/fnt2fon
RC           = $(WRC)
RC16         = $(WRC)
RCFLAGS      = --nostdinc $(INCLUDES) $(DEFS) $(EXTRARCFLAGS)
RC16FLAGS    = -O res16 $(RCFLAGS)
LDPATH       = LD_LIBRARY_PATH="$(TOOLSDIR)/libs/unicode:$$LD_LIBRARY_PATH"
DLLDIR       = $(TOPOBJDIR)/dlls
LIBDIR       = $(TOPOBJDIR)/libs
LIBPORT      = -L$(TOPOBJDIR)/libs/port -lwine_port
LIBUNICODE   = -L$(TOPOBJDIR)/libs/unicode -lwine_unicode
LIBWINE      = -L$(TOPOBJDIR)/libs/wine -lwine



# Installation infos

INSTALL         = /usr/bin/install -c $(INSTALL_FLAGS)
INSTALL_PROGRAM = ${INSTALL} $(INSTALL_PROGRAM_FLAGS)
INSTALL_SCRIPT  = ${INSTALL} $(INSTALL_SCRIPT_FLAGS)
INSTALL_DATA    = ${INSTALL} -m 644 $(INSTALL_DATA_FLAGS)
prefix          = /usr
exec_prefix     = ${prefix}
bindir          = ${exec_prefix}/bin
libdir          = ${exec_prefix}/lib
datadir         = ${prefix}/share
infodir         = ${prefix}/info
mandir          = ${prefix}/man
sysconfdir      = ${prefix}/etc
includedir      = ${prefix}/include/wine
dlldir          = ${exec_prefix}/lib/wine
prog_manext     = 1
api_manext      = 3w
conf_manext     = 5
CLEAN_FILES     = *.o *.a *.so *.ln *.$(LIBEXT) \\\#*\\\# *~ *% .\\\#* *.bak *.orig *.rej \
                  *.flc *.spec.c *.spec.def *.dbg.c *.tab.c *.tab.h lex.yy.c core

OBJS = $(C_SRCS:.c=.o) $(EXTRA_OBJS)

RCOBJS = $(RC_SRCS:.rc=.res.o)
LINTS  = $(C_SRCS:.c=.ln)

# Implicit rules

.SUFFIXES: .mc .rc .mc.rc .res .res.o .spec .spec.c .spec.def .idl .h .ok .sfd .ttf

.c.o:
	$(CC) -c $(ALLCFLAGS) -o $@ $<

.s.o:
	$(AS) -o $@ $<

.mc.mc.rc:
	$(LDPATH) $(WMC) -i -U -H /dev/null -o $@ $<

.rc.res:
	$(LDPATH) $(RC) $(RCFLAGS) -fo$@ $<

.res.res.o:
	$(WINDRES) -i $< -o $@

.spec.spec.c:
	$(WINEBUILD) $(DEFS) -o $@ --main-module $(MODULE) --dll $<

.spec.spec.def:
	$(WINEBUILD) -w $(DEFS) -o $@ --def $<

.idl.h:
	$(WIDL) $(IDLFLAGS) -h -H $@ $<

.c.ln:
	$(LINT) -c $(ALLLINTFLAGS) $< || ( $(RM) $@ && exit 1 )

.c.ok:
	$(RUNTEST) $(RUNTESTFLAGS) $< && touch $@

.sfd.ttf:
	$(FONTFORGE) -script $(TOPSRCDIR)/fonts/genttf.ff $<

# 'all' target first in case the enclosing Makefile didn't define any target

all: Makefile

filter:
	@$(TOPSRCDIR)/tools/winapi/make_filter --make $(MAKE) all

.PHONY: all filter

# Rules for resources

$(RC_BINARIES): $(BIN2RES) $(RC_BINSRC)
	$(BIN2RES) -f -o $@ $(SRCDIR)/$(RC_BINSRC)

$(RC_SRCS:.rc=.res) $(RC_SRCS16:.rc=.res): $(WRC) $(RC_BINARIES)

# Rule for main module debug channels

$(MODULE).dbg.c: $(C_SRCS) $(C_SRCS16) $(WINEBUILD)
	$(WINEBUILD) $(DEFS) -o $@ --debug -C$(SRCDIR) $(C_SRCS) $(C_SRCS16)

# Rules for makefile

Makefile: Makefile.in

# Rule for linting

$(MODULE).ln : $(LINTS)
	if test "$(LINTS)" ; \
	then \
		$(LINT) $(ALLLINTFLAGS) -o$(MODULE) $(LINTS) ; \
	        $(MV) llib-l$(MODULE).ln $(MODULE).ln ; \
	else \
		$(LINT) $(ALLLINTFLAGS) -C$(MODULE) /dev/null ; \
	fi

lint:: $(MODULE).ln

# Rules for Windows API checking

winapi_check:: dummy
	$(WINAPI_CHECK) $(WINAPI_CHECK_FLAGS) $(WINAPI_CHECK_EXTRA_FLAGS) .

.PHONY: winapi_check

# Rules for dependencies

$(SUBDIRS:%=%/__depend__): dummy
	cd `dirname $@` && $(MAKE) depend

depend: $(IDL_SRCS:.idl=.h) $(SUBDIRS:%=%/__depend__)
	$(MAKEDEP) $(INCLUDES) -C$(SRCDIR) $(C_SRCS) $(C_SRCS16) $(RC_SRCS) $(RC_SRCS16) $(MC_SRCS) $(IDL_SRCS) $(EXTRA_SRCS)

.PHONY: depend $(SUBDIRS:%=%/__depend__)

# Rules for cleaning

$(SUBDIRS:%=%/__clean__): dummy
	cd `dirname $@` && $(MAKE) clean

$(SUBDIRS:%=%/__testclean__): dummy
	cd `dirname $@` && $(MAKE) testclean

$(EXTRASUBDIRS:%=%/__clean__): dummy
	-cd `dirname $@` && $(RM) $(CLEAN_FILES)

testclean:: $(SUBDIRS:%=%/__testclean__)

clean:: $(SUBDIRS:%=%/__clean__) $(EXTRASUBDIRS:%=%/__clean__)
	$(RM) $(CLEAN_FILES) $(RC_SRCS:.rc=.res) $(RC_SRCS16:.rc=.res) $(MC_SRCS:.mc=.mc.rc) $(IDL_SRCS:.idl=.h) $(PROGRAMS) $(RC_BINARIES)

.PHONY: clean testclean $(SUBDIRS:%=%/__clean__) $(SUBDIRS:%=%/__testclean__) $(EXTRASUBDIRS:%=%/__clean__)

# Rules for installing

$(SUBDIRS:%=%/__install__): dummy
	cd `dirname $@` && $(MAKE) install

$(SUBDIRS:%=%/__install-lib__): dummy
	cd `dirname $@` && $(MAKE) install-lib

$(SUBDIRS:%=%/__install-dev__): dummy
	cd `dirname $@` && $(MAKE) install-dev

$(SUBDIRS:%=%/__uninstall__): dummy
	cd `dirname $@` && $(MAKE) uninstall

install:: $(INSTALLSUBDIRS:%=%/__install__)

uninstall:: $(INSTALLSUBDIRS:%=%/__uninstall__)

.PHONY: install install-lib install-dev uninstall \
	$(SUBDIRS:%=%/__install__) $(SUBDIRS:%=%/__uninstall__) \
	$(SUBDIRS:%=%/__install-lib__) $(SUBDIRS:%=%/__install-dev__)

# Rules for checking that no imports are missing

$(SUBDIRS:%=%/__checklink__): dummy
	@cd `dirname $@` && $(MAKE) checklink

.PHONY: checklink $(SUBDIRS:%=%/__checklink__)

# Rules for testing

$(SUBDIRS:%=%/__test__): dummy
	@cd `dirname $@` && $(MAKE) test

$(SUBDIRS:%=%/__crosstest__): dummy
	@cd `dirname $@` && $(MAKE) crosstest

.PHONY: check test crosstest $(SUBDIRS:%=%/__test__) $(SUBDIRS:%=%/__crosstest__)

# Misc. rules

$(MC_SRCS:.mc=.mc.rc): $(WMC)

$(IDL_SRCS:.idl=.h): $(WIDL)

$(SUBDIRS): dummy
	@cd $@ && $(MAKE)

dummy:

.PHONY: dummy $(SUBDIRS)

# End of global rules

wine_courier-1252-96-13.fnt: wine_courier.ttf $(SFNT2FNT)
	$(LDPATH) $(SFNT2FNT) wine_courier.ttf 13 1252 96 128 8

wine_courier-1250-96-13.fnt: wine_courier.ttf $(SFNT2FNT)
	$(LDPATH) $(SFNT2FNT) wine_courier.ttf 13 1250 96 128 8

wine_courier-1251-96-13.fnt: wine_courier.ttf $(SFNT2FNT)
	$(LDPATH) $(SFNT2FNT) wine_courier.ttf 13 1251 96 128 8

wine_sans_serif-1252-96-13.fnt: wine_sans_serif.ttf $(SFNT2FNT)
	$(LDPATH) $(SFNT2FNT) wine_sans_serif.ttf 13 1252 96 129 5

wine_sans_serif-1252-96-16.fnt: wine_sans_serif.ttf $(SFNT2FNT)
	$(LDPATH) $(SFNT2FNT) wine_sans_serif.ttf 16 1252 96 129 7

wine_sans_serif-1252-96-20.fnt: wine_sans_serif.ttf $(SFNT2FNT)
	$(LDPATH) $(SFNT2FNT) wine_sans_serif.ttf 20 1252 96 129 8

wine_sans_serif-1250-96-13.fnt: wine_sans_serif.ttf $(SFNT2FNT)
	$(LDPATH) $(SFNT2FNT) wine_sans_serif.ttf 13 1250 96 129 5

wine_sans_serif-1250-96-16.fnt: wine_sans_serif.ttf $(SFNT2FNT)
	$(LDPATH) $(SFNT2FNT) wine_sans_serif.ttf 16 1250 96 129 7

wine_sans_serif-1251-96-13.fnt: wine_sans_serif.ttf $(SFNT2FNT)
	$(LDPATH) $(SFNT2FNT) wine_sans_serif.ttf 13 1251 96 129 5

wine_sans_serif-1251-96-16.fnt: wine_sans_serif.ttf $(SFNT2FNT)
	$(LDPATH) $(SFNT2FNT) wine_sans_serif.ttf 16 1251 96 129 7

wine_sans_serif-1251-96-20.fnt: wine_sans_serif.ttf $(SFNT2FNT)
	$(LDPATH) $(SFNT2FNT) wine_sans_serif.ttf 20 1251 96 129 8

wine_system-1252-96-16.fnt: wine_system.ttf $(SFNT2FNT)
	$(LDPATH) $(SFNT2FNT) wine_system.ttf 16 1252 96 128 7

wine_system-1250-96-16.fnt: wine_system.ttf $(SFNT2FNT)
	$(LDPATH) $(SFNT2FNT) wine_system.ttf 16 1250 96 128 7

wine_system-1251-96-16.fnt: wine_system.ttf $(SFNT2FNT)
	$(LDPATH) $(SFNT2FNT) wine_system.ttf 16 1251 96 128 7

wine_sserife.fon: wine_sans_serif-1252-96-13.fnt wine_sans_serif-1252-96-16.fnt wine_sans_serif-1252-96-20.fnt $(FNT2FON)
	$(FNT2FON) wine_sans_serif-1252-96-13.fnt wine_sans_serif-1252-96-16.fnt wine_sans_serif-1252-96-20.fnt $@

wine_sserifee.fon: wine_sans_serif-1250-96-13.fnt wine_sans_serif-1250-96-16.fnt $(FNT2FON)
	$(FNT2FON) wine_sans_serif-1250-96-13.fnt wine_sans_serif-1250-96-16.fnt $@

wine_sserifer.fon: wine_sans_serif-1251-96-13.fnt wine_sans_serif-1251-96-16.fnt wine_sans_serif-1251-96-20.fnt $(FNT2FON)
	$(FNT2FON) wine_sans_serif-1251-96-13.fnt wine_sans_serif-1251-96-16.fnt wine_sans_serif-1251-96-20.fnt $@

wine_vgasys.fon: wine_system-1252-96-16.fnt $(FNT2FON)
	$(FNT2FON) wine_system-1252-96-16.fnt $@

wine_vgasyse.fon: wine_system-1250-96-16.fnt $(FNT2FON)
	$(FNT2FON) wine_system-1250-96-16.fnt $@

wine_vgasysr.fon: wine_system-1251-96-16.fnt $(FNT2FON)
	$(FNT2FON) wine_system-1251-96-16.fnt $@

wine_coure.fon: wine_courier-1252-96-13.fnt $(FNT2FON)
	$(FNT2FON) wine_courier-1252-96-13.fnt $@

wine_couree.fon: wine_courier-1250-96-13.fnt $(FNT2FON)
	$(FNT2FON) wine_courier-1250-96-13.fnt $@

wine_courer.fon: wine_courier-1251-96-13.fnt $(FNT2FON)
	$(FNT2FON) wine_courier-1251-96-13.fnt $@

install:: $(FONTS)
	$(MKINSTALLDIRS) $(fontdir)
	for i in $(FONTS); do $(INSTALL_DATA) $$i $(fontdir)/$$i || exit 1; done

uninstall::
	-cd $(fontdir) && $(RM) $(FONTS)
	-rmdir $(fontdir)

clean::
	$(RM) *.fon *.fnt *.ttf

### Dependencies:
