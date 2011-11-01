# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit findlib

DESCRIPTION="A LR(1) parser generator for the Objective Caml programming language"
HOMEPAGE="http://gallium.inria.fr/~fpottier/menhir/"
SRC_URI="http://gallium.inria.fr/~fpottier/menhir/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
dev-lang/ocaml
"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_configure() {
	return
}

src_compile() {
	make PREFIX=/usr || die
}

src_install() {
	PREFIX="${D}usr" findlib_src_install
	dodoc LICENSE AUTHORS CHANGES
}
