# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="An automatic theorem prover dedicated to program verification."
HOMEPAGE="http://alt-ergo.lri.fr/"
SRC_URI="http://alt-ergo.lri.fr/http/${P}.tar.gz"

LICENSE="CeCILL-C"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
>=dev-lang/ocaml-3.0.8
dev-ml/ocamlgraph
"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_configure() {
	econf || die
}

src_compile() {
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc COPYING README
}
