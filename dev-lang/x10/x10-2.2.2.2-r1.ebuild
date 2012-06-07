EAPI=2
PYTHON_DEPEND="2"
inherit eutils

DESCRIPTION="A parallel language"
HOMEPAGE="http://x10.sourceforge.net/"
SRC_URI="mirror://sourceforge/x10/${P}-src.tar.bz2"

LICENSE="EPL-1.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="mpi pami +gc"

RDEPEND="
>=dev-java/ant-1.7
mpi? (
  >=virtual/mpi-2.0
)
"
DEPEND=""

use_tf() {
	if $(use $1) ; then
		return "true"
	else
		return "false"
	fi
}
src_compile() {
	cd x10.dist
	ant -DX10RT_MPI=$(usex mpi true false) -DX10RT_PAMI=$(usex mpi true false) \
	-DDISABLE_GC=$(usex mpi true false) squeakyclean dist
}
src_install() {
	cd x10.dist
	mkdir -p "${D}/opt/x10"
	cp -r etc include lib samples stdlib "${D}/opt/x10/"

	mkdir "${D}/opt/x10/bin"
	find ./bin -executable -exec cp {} "${D}/opt/x10/bin/" \;
}
pkg_postinst() {
	elog "Please add following line to your ~/bashrc"
	elog ""
	elog "	export PATH=\"/opt/x10/bin:\${PATH}\""
	elog ""
}
