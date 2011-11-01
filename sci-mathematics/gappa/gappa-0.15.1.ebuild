# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="An automatic theorem prover for Satisfiability Modulo Theories (SMT) problems."
HOMEPAGE="http://gappa.gforge.inria.fr/"
SRC_NUMBER=29004
SRC_URI="https://gforge.inria.fr/frs/download.php/${SRC_NUMBER}/${P}.tar.gz"

LICENSE="CeCILL GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
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
	emake DESTDIR="${D}" \
		install || die
	dodoc COPYING COPYING.GPL ChangeLog README
}
