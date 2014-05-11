# Copyright 2013 Sakamoto Noriaki <mrty.ityt.pt@gmail.com>
# Distributed under the terms of the GNU General Public License v2 or latter version

EAPI="5"

inherit versionator

DESCRIPTION="A Small Scale Reflection Extension for the Coq system"
HOMEPAGE="http://ssr.msr-inria.inria.fr/"
SRC_URI="
	http://ssr.msr-inria.inria.fr/FTP/${P}.tar.gz
	"

LICENSE="CeCILL-B"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc +proofgeneral"

RDEPEND="
	>=sci-mathematics/coq-8.4_p2[camlp5]
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

neededdocments="html mlihtml gallinahtml all.pdf all-gal.pdf"

src_unpack () {
	unpack "${A}"
}

src_configure() {
	myconf="
		COQBIN=/usr/bin/
		COQLIBINSTALL=$(get_libdir)/coq/user-contrib
	    COQDOCINSTALL=share/doc/${PF}"
	PGSSRDIR=/usr/share/emacs/site-lisp
}

src_compile() {
	cd ${P}
	emake STRIP="true" DSTROOT=/usr/ $myconf || die "make failed"
	if use doc ; then
		for d in ${neededdocments} ; do
			emake -f Makefile.coq "$d" DSTROOT=/usr/ $myconf
		done
	fi
}

src_install() {
	cd ${P}
	emake STRIP="true" $myconf DSTROOT=${D}/usr/ install || die
	dodoc ANNOUNCE README

	local d
	for d in ${neededdocments} ; do
		if [[ -s "${d}" ]] ; then
			[[ -f "${d}" ]] && dodoc "$d"
			[[ -d "${d}" ]] && dohtml -r "$d"
		fi
	done

	if use proofgeneral ; then
		insinto $PGSSRDIR
		doins pg-ssr.el
	fi
}

pkg_postinst() {
	if use proofgeneral ; then
		insinto /usr/share/emacs/site-lisp
		doins pg-ssr.el
    	elog "A script for ProofGeneral was installed into $PGSSRDIR."
    	elog "Please add following line to your ~/.emacs."
    	elog "    (load-file \"$PGSSRDIR/pg-ssr.el\")"
	fi
}
