# Copyright 2013 Sakamoto Noriaki <mrty.ityt.pt@gmail.com>
# Distributed under the terms of the GNU General Public License v2 or latter version

EAPI="5"

inherit versionator

MY_PV=$(get_version_component_range 1-2)
MY_P=${PN}-${MY_PV}
COQMAJVAR=$(get_version_component_range 3)
COQMINVAR=$(get_version_component_range 4)
COQVAR=${COQMAJVAR}.${COQMINVAR}

DESCRIPTION="A Small Scale Reflection Extension for the Coq system"
HOMEPAGE="http://ssr.msr-inria.inria.fr/"
SRC_URI="http://ssr.msr-inria.inria.fr/FTP/${MY_P}-coq${COQVAR}.tar.gz"

LICENSE="CeCILL-B"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

RDEPEND=">=sci-mathematics/coq-${COQVAR}[camlp5]
	<sci-mathematics/coq-${COQMAJVAR}.$((${COQMINVAR}+1))[camlp5]
	"
DEPEND="${RDEPEND}
	doc? (
		media-libs/netpbm[png,zlib]
		virtual/latex-base
		dev-tex/hevea
		dev-tex/xcolor
		dev-texlive/texlive-pictures
		dev-texlive/texlive-mathextra
		dev-texlive/texlive-latexextra
		)"

S=${WORKDIR}/${MY_P}

src_configure() {
	myconf="
		COQBIN=/usr/bin/
		COQLIBINSTALL=$(get_libdir)/coq/user-contrib
	    COQDOCINSTALL=share/doc/${PF}"
}

src_compile() {
	cd ${MY_P}
	emake STRIP="true" DSTROOT=/usr/ $myconf || die "make failed"
}

src_install() {
	cd ${MY_P}
	emake STRIP="true" $myconf DSTROOT=${D}/usr/ install || die
	dodoc ANNOUNCE README

	insinto /usr/share/emacs/site-lisp
	doins pg-ssr.el
}
