From: Eduardo Valentin <eduardo.valentin@ti.com>
Date: Wed, 24 Jul 2013 15:04:57 +0000
Subject: Re: [lm-sensors] RFC: device thermal limits represented in device tree nodes
Message-Id: <51EFED19.5090900@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4590673166942367991=="
List-Id: <lm-sensors.vger.kernel.org>
References: <51ED40E3.5020703@ti.com> <51EF3186.9060001@wwwdotorg.org> <1374664745.25700.118.camel@hornet>
In-Reply-To: <1374664745.25700.118.camel@hornet>
To: Pawel Moll <pawel.moll@arm.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, Mark Rutland <Mark.Rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Guenter Roeck <linux@roeck-us.net>, Durgadoss R <durgadoss.r@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, Wei Ni <wni@nvidia.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--===============4590673166942367991==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="brPAFs9Ui6IIWQVl7uc8ph9kqklGF76xr"

--brPAFs9Ui6IIWQVl7uc8ph9kqklGF76xr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


Pawel,

On 24-07-2013 07:19, Pawel Moll wrote:
> Greeting,
>=20
> Funnily enough I had this discussion couple a months ago and made my
> mind back then :-)
>=20

:-)

>> On 07/22/2013 07:25 AM, Eduardo Valentin wrote:
>>> representing in device tree would not
>>> infringe the original purpose of this data structure  ("The Device
>>> Tree is a data structure for describing hardware."[2]).
>=20
> I couldn't agree more, with a few remarks...
>=20

Nice.

>>> In this current proposal, a 'thermal_zone' node would be embedded
>>> inside a temperature sensor node, for simplicity. But other
>>> possible builds could embedded them in the device with thermal
>>> limits (CPU nodes, for instance) or they could be not embedded in
>>> any specific node.
>=20
> So this is the detail that actually caused most of the disagreement :-)=

>=20
> My position on this can be summarized as follows:
>=20
> 1. As you have pointed out, the thermal limits are related to the
> *device being monitored*, not the sensor itself.
>=20

Yeah, thinking of it now, this original proposal, it lacks a stronger
relationship mapping between monitored and monitoring devices. But it
does have it..

> 2. Therefore the tree should express relation between those two; a
> sensor mode should be connected (via phandle most likely) to the device=


=2E. this is done, more or less, by means of the 'type' property (see
original RFC binding).

> being monitored, eg. (I'm not suggesting any property names, just tryin=
g
> to express the idea ;-) memory mapped PVT "sensor" monitoring a core
> (cpu) temperature could look like this:
> 	cpu0: cpu@0 {
> 	};
>=20
> 	sensor@xxxx {
> 		reg =3D <xxx>;
> 		device_monitored =3D <&cpu0>;
> 	};

To, this is not a sensor property. It could be a property in the
thermal_zone node itself.

> while I2C or 1Wire sensor measuring temperature of the board (or even
> inside the device enclosure) would point at the root of the tree.
>=20
> 3. Basing on the above, the thermal limits of the device could be
> described in the tree (again, don't pay attention to naming):
> 	cpu0: cpu@0 {
> 		thermal_limits {
> 			cooling {
> 			};
> 			critical {
> 			};
> 		};
> 	};
> or "hardcoded" in the device driver. After all, as you have pointed out=
,

For example:
cpu0: cpu@0 {
	/* ... cpu needed bindings  */

	thermal_zone {
		type =3D "CPU";

		monitoring_device =3D <&sensor@xxxx
				    &sensor@yyyy>;

		mask =3D <0x03>; /* trips writability */
		passive_delay =3D <250>; /* milliseconds */
		polling_delay =3D <1000>; /* milliseconds */
		policy =3D "step_wise";
		trips {
			alert@100000{
				temperature =3D <100000>; /* milliCelsius
				hysteresis =3D <2000>; /* milliCelsius */
				type =3D <THERMAL_TRIP_PASSIVE>;
			};
			crit@125000{
				temperature =3D <125000>; /* milliCelsius
				hysteresis =3D <2000>; /* milliCelsius */
				type =3D <THERMAL_TRIP_CRITICAL>;
			};
		};
		bind_params {
			action@0{
				cooling_device =3D "thermal-cpufreq";
				weight =3D <100>; /* percentage */
				mask =3D <0x01>;
				/* no limits, using defaults */
			};
		};
	};
};

/* .. other binding .. */

sensor@xxxx {
	reg =3D <xxx>;
	compatible =3D <xxx>;
};

sensor@yyyy {
	reg =3D <yyyy>;
	compatible =3D <yyyy>;
};


The above way, I think it is less intrusive to sensor bindings. Besides,
it gives the flexibility to have more that one sensor monitoring a
thermal zone. In Linux we don't have this support, but in practice, we
do have this requirement. Durgadoss has proposed an improvement of the
thermal framework as a RFC. So, the support to have several sensors per
zone will come.

Another way, as I mentioned in the original RFC, an option would be to
have the thermal_zone node not embedded in any device node. But them, we
would need to firmly link it to other device nodes, to describe what is
monitored and what is used for monitoring. Something like:
thermal_zone {
	type =3D "CPU";
	monitored_device =3D <&cpu0>;
	monitoring_device =3D <&sensor@xxxx
			    &sensor@yyyy>;
	mask =3D <0x03>; /* trips writability */
	passive_delay =3D <250>; /* milliseconds */
	polling_delay =3D <1000>; /* milliseconds */
	policy =3D "step_wise";
	trips {
		alert@100000{
			temperature =3D <100000>; /* milliCelsius
			hysteresis =3D <2000>; /* milliCelsius */
			type =3D <THERMAL_TRIP_PASSIVE>;
		};
		crit@125000{
			temperature =3D <125000>; /* milliCelsius
			hysteresis =3D <2000>; /* milliCelsius */
			type =3D <THERMAL_TRIP_CRITICAL>;
		};
	};
	bind_params {
		action@0{
			cooling_device =3D "thermal-cpufreq";
			weight =3D <100>; /* percentage */
			mask =3D <0x01>;
			/* no limits, using defaults */
		};
	};
};

With the above I believe we could have dts(i) files describing only
thermal, for instance.

> the limits are the device's characteristic, so I see no problem with th=
e
> "SOC driver" registering the trip points on its own. I'm sure there wil=
l
> be situations when it's better to parametrize such data via Device Tree=
,
> so it makes perfect sense to have bindings defined for such occasion.
> Anyway, as long as the tree describes the relation between the monitore=
d
> device, the sensor and the cooling device all should work.
>=20
> Now, my personal opinion is that the tree should focus at "system level=
"
> data (ie. how is the device connected to others) and describe as little=

> information that can be probed in runtime - a small (small!) array of
> silicon variants in the driver doesn't hurt (unless we're talking about=

> hundreds of possibilities, where the device tree is obviously the place=

> to have them). But this is just a rule of thumb I'm following.
>=20
> Cheers!
>=20
> Pawel
>=20
>=20
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--brPAFs9Ui6IIWQVl7uc8ph9kqklGF76xr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlHv7RkACgkQCXcVR3XQvP20VwD+K4KUu8bOJCXMQrmyw8ozN6/L
1qYpGWsZad8U0l5yPMcBAKzEkdv/R5aNDhUghDdSD9cb0VvZQ6YXctNBIuzYJo2X
=zvL7
-----END PGP SIGNATURE-----

--brPAFs9Ui6IIWQVl7uc8ph9kqklGF76xr--


--===============4590673166942367991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4590673166942367991==--
