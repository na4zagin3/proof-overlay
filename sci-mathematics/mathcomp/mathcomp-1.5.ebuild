# Copyright 2013 Sakamoto Noriaki <mrty.ityt.pt@gmail.com>
# Distributed under the terms of the GNU General Public License v2 or latter version

EAPI="5"

inherit versionator

DESCRIPTION="Mathematical library for SSReflect"
HOMEPAGE="http://ssr.msr-inria.inria.fr/"
SRC_URI="
	http://ssr.msr-inria.inria.fr/FTP/${P}.tar.gz
	"

LICENSE="CeCILL-B"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

RDEPEND="
	>=sci-mathematics/ssreflect-1.5
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

S=${WORKDIR}/${P}

neededdocments="html"

src_unpack () {
	unpack "${A}"
}

src_configure() {
	myconf="
		COQBIN=/usr/bin/
		COQLIBINSTALL=$(get_libdir)/coq/user-contrib
	    COQDOCINSTALL=share/doc/${PF}"
}

src_compile() {
	cd ${P}
	emake STRIP="true" DSTROOT=/usr/ $myconf || die "make failed"
	if use doc ; then
		emake DSTROOT=/usr/ $myconf doc || die "make failed"
	fi
}

src_install() {
	cd ${P}
	emake STRIP="true" $myconf DSTROOT=${D}/usr/ install || die
	dodoc AUTHORS README

	local d
	for d in ${neededdocments} ; do
		if [[ -s "${d}" ]] ; then
			[[ -f "${d}" ]] && dodoc "$d"
			[[ -d "${d}" ]] && dodoc -r "$d"
		fi
	done
}
