# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="An Automated Theorem Prover for First-Order Logic with Equality"
HOMEPAGE="http://www.spass-prover.org/index.html"
MY_P=$(echo "${P}" | sed -e 's/[-.]//g' -)
SRC_URI="http://www.spass-prover.org/download/sources/${MY_P}.tgz"

LICENSE="max-plank-spass"
SLOT="0"
KEYWORDS="~amd64"
IUSE="X"

DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}/$(echo "${PN}" | tr '[a-z]' '[A-Z]')-${PV}

src_unpack() {
	unpack ${A}
	mv "${S%/*}"/ "${S}"
	cd "${S}"

}

src_configure() {
#	econf $(use_enable X gui)
	econf
}

src_compile() {
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
}
