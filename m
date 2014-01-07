From: Eduardo Valentin <eduardo.valentin@ti.com>
Date: Tue, 07 Jan 2014 15:28:55 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/sensors: fix SENSORS_LM75 dependencies
Message-Id: <52CC1D37.40604@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5272829992561286220=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20140106204020.b47e53cc3ead8f90164ef5b7@canb.auug.org.au> <52CB0948.6030702@infradead.org> <20140106203209.GA21630@roeck-us.net> <52CB53DC.4030901@infradead.org> <52CB65DA.2010103@roeck-us.net> <20140107130401.23bffcd2@endymion.delvare> <52CBF1CF.2000603@ti.com> <744357E9AAD1214791ACBA4B0B909263011BC64C@SHSMSX101.ccr.corp.intel.com> <52CC15F0.6020209@ti.com> <20140107160738.4a76a6d0@endymion.delvare>
In-Reply-To: <20140107160738.4a76a6d0@endymion.delvare>
To: Jean Delvare <khali@linux-fr.org>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, "Zhang, Rui" <rui.zhang@intel.com>, Guenter Roeck <linux@roeck-us.net>, Randy Dunlap <rdunlap@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linux-pm@vger.kernel.org

--===============5272829992561286220==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QgwbA2aqk28CVpiw55qa319MSVul2MVnC"

--QgwbA2aqk28CVpiw55qa319MSVul2MVnC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07-01-2014 11:07, Jean Delvare wrote:
> On Tue, 7 Jan 2014 10:57:52 -0400, Eduardo Valentin wrote:
>> On 07-01-2014 10:05, Zhang, Rui wrote:
>>> BTW, I've been thinking of make CONFIG_THERMAL a bool since long time=
 ago, the only thing that blocks me is that Thermal subsystem needs to re=
gister a hwmon device for each thermal zone and CONFIG_HWMON is a tristat=
e.
>>
>> I agree with the move of having CONFIG_THERMAL as bool. Unless you hav=
e
>> use cases where users are dynamically loading and unloading thermal pe=
r
>> user demand, which I doubt.
>=20
> Modularity is not only about reloading modules (although this can be
> useful for developers in particular.) It's also about enabling many
> features in a generic distribution kernel and each feature only gets
> loaded/used on the hardware which needs it. This is why, as a

In fact, no one has said anything different than the above. I definitely
agree with you. Except that this needs to be taken with a bit of care.

> distribution kernel maintainer, I keep complaining when I see boolean
> options which might easily be tristates.

Well, I would say it is not that 'easy' and not that straight forward.
there a couple of items to be considered in the thermal case, the boot
requirements and API provisioning are two, just to mention. There are
use cases that waiting for init to be loaded and modules to be linked is
just no go for thermal constraints, in case the system is already booted
'hot'.

Besides, hiding APIs when a component is build is module is not very
'modular', even considering the statements you brought above.

>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--QgwbA2aqk28CVpiw55qa319MSVul2MVnC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlLMHTcACgkQCXcVR3XQvP2L/AEA4/uDi0hCpifWJeYLb+YQgufP
1lslHDJXpn5p02CzRyIBAMydMpbvxLHckrsoQvd6xF4hkIcsPxG+sAZIWRpRMghc
=XGl3
-----END PGP SIGNATURE-----

--QgwbA2aqk28CVpiw55qa319MSVul2MVnC--


--===============5272829992561286220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5272829992561286220==--
