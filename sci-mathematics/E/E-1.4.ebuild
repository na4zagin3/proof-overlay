# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

DESCRIPTION="A theorem prover for full first-order logic with equality."
HOMEPAGE="http://www4.informatik.tu-muenchen.de/~schulz/E/E.html"
SRC_URI="http://www4.in.tum.de/~schulz/WORK/E_DOWNLOAD/V_${PV}/${PN}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
>=dev-lang/python-2.0

"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-manpath.patch"
}

src_configure() {
#	./configure --exec-prefix=/usr --man-prefix=/usr/share || die
	./configure "--exec-prefix=${D}usr" "--man-prefix=${D}usr/share/man" || die
}

src_compile() {
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	mkdir "${D}usr/man/man1"
	mv "${D}usr/man/*.1" "${D}usr/man/man1"
	dodoc README COPYING
}
