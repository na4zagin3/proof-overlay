# Copyright 2013 Sakamoto Noriaki <mrty.ityt.pt@gmail.com>
# Distributed under the terms of the GNU General Public License v2 or latter version

EAPI="5"

inherit versionator

MY_PV=$(get_version_component_range 1-2)
MY_P=${PN}-${MY_PV}
COQMAJVAR=$(get_version_component_range 3)
COQMINVAR=$(get_version_component_range 4)
COQPATCHVAR=$(get_version_component_range 5)
COQVAR=${COQMAJVAR}.${COQMINVAR}
if [[ "" != "$COQPATCHVAR" ]] ; then
	COQVAR="${COQVAR}_p${COQPATCHVAR}"
fi


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

neededdocments="html mlihtml gallinahtml all.pdf all-gal.pdf"

src_prepare () {
	unpack "${A}"
	cd "${S}/${MY_P}"
	epatch "${FILESDIR}/${MY_P}-escape-for-ocamldoc.patch"
}

src_configure() {
	myconf="
		COQBIN=/usr/bin/
		COQLIBINSTALL=$(get_libdir)/coq/user-contrib
	    COQDOCINSTALL=share/doc/${PF}"
}

src_compile() {
	cd ${MY_P}
	emake STRIP="true" DSTROOT=/usr/ $myconf || die "make failed"
	if use doc ; then
		for d in ${neededdocments} ; do
			emake -f Makefile.coq "$d" DSTROOT=/usr/ $myconf
		done
	fi
}

src_install() {
	cd ${MY_P}
	emake STRIP="true" $myconf DSTROOT=${D}/usr/ install || die
	dodoc ANNOUNCE README

	local d
	for d in ${neededdocments} ; do
		if [[ -s "${d}" ]] ; then
			[[ -f "${d}" ]] && dodoc "$d"
			[[ -d "${d}" ]] && dohtml -r "$d"
		fi
	done

	insinto /usr/share/emacs/site-lisp
	doins pg-ssr.el
}
