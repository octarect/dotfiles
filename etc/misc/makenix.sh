#!/usr/bin/env bash

findpkgdir() {
	local name="$1"
	filename=$(find ${work_dir} -mindepth 1 -maxdepth 1 -type d | xargs -I{} basename {} | grep "${name}")
	echo "${work_dir}/${filename}"
}

perllibdir() {
	local candidates=$(find ${work_dir}/lib -type d -name site_perl)
	if [[ ! -z "${candidates}" ]]; then
		local first=$(echo "${candidates}" | head -n1)
		echo "$(dirname ${first})"
	fi
}

set -ex

work_dir=${HOME}/nix-boot
ssl_dir=${work_dir}/opt/ssl
# ssl_dir=${work_dir}
nix_store=${HOME}/nix/store
nix_var=${HOME}/nix/var

mkdir -p ${work_dir}

deps=(
	http://nixos.org/releases/nix/nix-1.11.16/nix-1.11.16.tar.xz
	https://sources.archlinux.org/other/packages/bzip2/bzip2-1.0.6.tar.gz
	# https://www.openssl.org/source/openssl-1.0.2r.tar.gz
	# https://curl.haxx.se/download/curl-7.35.0.tar.lzma
	http://www.sqlite.org/2014/sqlite-autoconf-3080300.tar.gz
	https://cpan.metacpan.org/authors/id/T/TI/TIMB/DBI-1.631.tar.gz
	https://cpan.metacpan.org/authors/id/I/IS/ISHIGAKI/DBD-SQLite-1.40.tar.gz
	https://cpan.metacpan.org/authors/id/E/ET/ETHER/YAML-Tiny-1.73.tar.gz
	https://cpan.metacpan.org/authors/id/E/ET/ETHER/Module-Install-1.19.tar.gz
	https://cpan.metacpan.org/authors/id/S/SZ/SZBALINT/WWW-Curl-4.15.tar.gz
)

cur_dir=$(pwd)
cd ${work_dir}

for dep_url in ${deps[@]}
do
	echo "GET: ${dep_url}"
	filename=$(basename ${dep_url})
	save_path="${work_dir}/${filename}"

	curl -X GET -L ${dep_url} > ${save_path}
	ext="${filename##*.}"
	case "${ext}" in
	gz)
		tar -zxvf ${save_path}
		;;
	xz)
		tar -Jxvf ${save_path}
		;;
	lzma)
		tar -xvf ${save_path} --lzma
		;;
	esac
done

export PATH="${work_dir}/bin:${PATH}"
export PKG_CONFIG_PATH=${work_dir}/lib/pkgconfig:$PKG_CONFIG_PATH
export LDFLAGS="-L${work_dir}/lib $LDFLAGS"
export CPPFLAGS="-I${work_dir}/include $CPPFLAGS"

# for curl with ssl
export CFLAGS="-I${work_dir}/include $CFLAGS"

cd $(findpkgdir bzip2)
make -f Makefile-libbz2_so
make install PREFIX=${work_dir}
cp libbz2.so.1.0 libbz2.so.1.0.6 $HOME/nix-boot/lib

# cd $(findpkgdir openssl)
# mkdir -p ${ssl_dir}
# ./config --openssldir=${ssl_dir}
# make
# make install

# cd $(findpkgdir curl)
#./configure --prefix=${work_dir} --with-ssl=${ssl_dir} --enable-libcurl-option
# PKG_CONFIG_PATH=${ssl_dir}/lib/pkgconfig ./configure --prefix=${work_dir} --with-ssl
# make
# make install

cd $(findpkgdir sqlite)
./configure --prefix=${work_dir}
make
make install

cd $(findpkgdir DBI)
perl Makefile.PL PREFIX=${work_dir}
make
make install

export PERL5OPT="-I$(perllibdir)/site_perl -I${work_dir}/share/perl5/site_perl"

cd $(findpkgdir DBD-SQLite)
perl Makefile.PL PREFIX=${work_dir}
make
make install

cd $(findpkgdir YAML-Tiny)
perl Makefile.PL PREFIX=${work_dir}
make
make install

cd $(findpkgdir Module-Install)
perl Makefile.PL PREFIX=${work_dir}
make
make install

cd $(findpkgdir WWW-Curl)
curl -X GET -L "https://rt.cpan.org/Public/Ticket/Attachment/1668211/895272/WWW-Curl-4.17-Skip-preprocessor-symbol-only-CURL_STRICTER.patch" | git apply -v
perl Makefile.PL PREFIX=${work_dir}
make
make install

cd $(findpkgdir nix)
./bootstrap.sh
./configure --prefix=${work_dir} --with-store-dir=${nix_store} --localstatedir=${nix_var}
make
make install

cd ${cur_dir}
