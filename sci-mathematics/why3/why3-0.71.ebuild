# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="The next generation of the Why software verification platform."
HOMEPAGE="http://why3.lri.fr/"
SRC_NUMBER=29252
SRC_URI="https://gforge.inria.fr/frs/download.php/${SRC_NUMBER}/${P}.tar.gz"

LICENSE="LGPL-1.2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="X doc +bench coq tptp menhir hypothesis-selection doc profile"

DEPEND="
dev-lang/ocaml
tptp? (
	dev-ml/menhir
)
X? (
	dev-ml/lablgtk[sourceview]
)
doc? (
	dev-tex/rubber
)
coq? (
	sci-mathematics/coq
)
hypothesis-selection? (
	dev-ml/ocamlgraph
)
bench? (
	dev-ml/ocaml-sqlite3
)
"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_configure() {
	econf \
		$(use_enable doc ) \
		$(use_enable menhir menhirlib ) \
		$(use_enable tptp whytptp ) \
		$(use_enable coq coq-support ) \
		$(use_enable X ide ) \
		$(use_enable hypothesis-selection ) \
		$(use_enable profile profiling ) \
		$(use_enable bench ) \
		--enable-plugins \
	|| die
}

src_compile() {
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README LICENSE OCAML-LICENSE
}
