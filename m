From: Eduardo Valentin <eduardo.valentin@ti.com>
Date: Sat, 21 Sep 2013 23:30:35 +0000
Subject: Re: [lm-sensors] [PATCHv3 05/16] hwmon: lm75: expose to thermal fw via DT nodes
Message-Id: <523E2C1B.9010307@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6647073896813237409=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1379457325-18192-1-git-send-email-eduardo.valentin@ti.com> <1379521314-16959-1-git-send-email-eduardo.valentin@ti.com> <523DE01F.4020607@roeck-us.net>
In-Reply-To: <523DE01F.4020607@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, rui.zhang@intel.com, wni@nvidia.com, grant.likely@linaro.org, durgadoss.r@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>

--===============6647073896813237409==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9x4MDBE764IgUNxf3PGiCru6VpXDCprP3"

--9x4MDBE764IgUNxf3PGiCru6VpXDCprP3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 21-09-2013 14:06, Guenter Roeck wrote:
> On 09/18/2013 09:21 AM, Eduardo Valentin wrote:
>> This patch adds to lm75 temperature sensor the possibility
>> to expose itself as thermal zone device, registered on the
>> thermal framework.
>>
>> The thermal zone is built only if a device tree node
>> describing a thermal zone for this sensor is present
>> inside the lm75 DT node. Otherwise, the driver behavior
>> will be the same.
>>
>> Cc: Jean Delvare <khali@linux-fr.org>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: lm-sensors@lm-sensors.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
>=20
> Acked-by: Guenter Roeck <linux@roeck-us.net>
>=20

Cool! thanks again for taking the time to review this.

> I assume this will be sent upstream through the thermal tree ?

Yeah, that is the idea, at least for the core part. The hwmon changes I
believe goes via hwmon tree, right?


I still need acks from device tree maintainers before moving forward,
though.


>=20
> Guenter
>=20
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--9x4MDBE764IgUNxf3PGiCru6VpXDCprP3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlI+LBsACgkQCXcVR3XQvP1YkgEA+thEwLny2zsb7vO5ODX15WSW
cqta5NCW0piq29l+mqIBAKFJSPshORy6eRR4I+hAw6GSFYhQ0bqUsz07MY/dQOIW
=FscP
-----END PGP SIGNATURE-----

--9x4MDBE764IgUNxf3PGiCru6VpXDCprP3--


--===============6647073896813237409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6647073896813237409==--
