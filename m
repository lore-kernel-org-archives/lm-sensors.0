From: Eduardo Valentin <eduardo.valentin@ti.com>
Date: Tue, 14 Jan 2014 19:07:24 +0000
Subject: Re: [lm-sensors] [PATCHv5 05/20] cpufreq: cpufreq-cpu0: add dt node parsing for cooling device prope
Message-Id: <52D58AEC.6020706@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7435640024801067869=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com> <1384285582-16933-6-git-send-email-eduardo.valentin@ti.com> <744357E9AAD1214791ACBA4B0B909263011C9A19@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: <744357E9AAD1214791ACBA4B0B909263011C9A19@SHSMSX101.ccr.corp.intel.com>
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux@roeck-us.net" <linux@roeck-us.net>, "wni@nvidia.com" <wni@nvidia.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "R, Durgadoss" <durgadoss.r@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

--===============7435640024801067869==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rqLhxVutw0XWqBrJW52q0JlnNclgB2BIN"

--rqLhxVutw0XWqBrJW52q0JlnNclgB2BIN
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12-01-2014 10:31, Zhang, Rui wrote:
> config: make ARCH=3Darm multi_v7_defconfig
> All warnings:
> warning: (ARM_HIGHBANK_CPUFREQ) selects GENERIC_CPUFREQ_CPU0 which=20
> has unmet direct dependencies (ARCH_HAS_CPUFREQ && CPU_FREQ &&=20
> HAVE_CLK && REGULATOR && PM_OPP && OF && THERMAL && CPU_THERMAL)

Rui,

BTW, I am not able to reproduce the above warning :-(

Are you sure you simply do a
$  make ARCH=3Darm multi_v7_defconfig

??

--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--rqLhxVutw0XWqBrJW52q0JlnNclgB2BIN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlLViuwACgkQCXcVR3XQvP3RagD/Xt1EHXcz+FELfwfsdUrW+7R1
ScNyjka4lEYI14kCm0cBAKIqssi1UhKAhXv0aLfEw9BSW/lyNmIdALWHF+R4TpUx
=/xy1
-----END PGP SIGNATURE-----

--rqLhxVutw0XWqBrJW52q0JlnNclgB2BIN--


--===============7435640024801067869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7435640024801067869==--
