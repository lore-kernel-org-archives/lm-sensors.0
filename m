From: Roman Mamedov <roman@rm.pp.ru>
Date: Mon, 01 Mar 2010 14:46:58 +0000
Subject: Re: [lm-sensors] ASUS CUSL2: sensors work with 2.6.30,
Message-Id: <20100301194658.11a37e17@natsu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2374985087693077855=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20100301033233.66b4f25f@natsu>
In-Reply-To: <20100301033233.66b4f25f@natsu>
To: lm-sensors@vger.kernel.org

--===============2374985087693077855==
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/+YtXM0+Se_2Kn5nm/OfVN7Y"; protocol="application/pgp-signature"

--Sig_/+YtXM0+Se_2Kn5nm/OfVN7Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Mar 2010 15:25:39 +0100
Luca Tettamanti <kronos.it@gmail.com> wrote:

> To revert to the old behaviour you can pass
> "acpi_enforce_resources=3Dlax" on the kernel command line, but I cannot
> guarantee that it's a safe operation.

Thanks, this helped. I wonder if similar situations could be detected and
pointed at during sensors-detect. E.g. failures to load modules because of
resource conflicts, if you see my earlier sensors-detect log, it is
completely silent about being unable to insert the module because of the
conflict (which is reported in dmesg only).

--=20
With respect,
Roman

--Sig_/+YtXM0+Se_2Kn5nm/OfVN7Y
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkuL02IACgkQTLKSvz+PZwhMiwCfVzVPE51Dwsls8+HojZ3uk2hx
kHAAn3slNsdWmLNvvPUcxhUX4IwWDZz1
=G2FT
-----END PGP SIGNATURE-----

--Sig_/+YtXM0+Se_2Kn5nm/OfVN7Y--


--===============2374985087693077855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2374985087693077855==--
