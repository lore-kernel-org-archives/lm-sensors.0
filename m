From: Eduardo Valentin <eduardo.valentin@ti.com>
Date: Thu, 14 Nov 2013 11:31:04 +0000
Subject: Re: [lm-sensors] [PATCHv9 02/20] thermal: introduce device tree parser
Message-Id: <5284B478.8090503@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0439602365297579021=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com> <1384285582-16933-3-git-send-email-eduardo.valentin@ti.com> <2523089.oKCvZdz31U@flatron>
In-Reply-To: <2523089.oKCvZdz31U@flatron>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com, wni@nvidia.com, grant.likely@linaro.org, durgadoss.r@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

--===============0439602365297579021==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gWrompVAELBKjsVwPaW8vmJdhgwtWMBHq"

--gWrompVAELBKjsVwPaW8vmJdhgwtWMBHq
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13-11-2013 12:57, Tomasz Figa wrote:
> Hi Eduardo,
>=20

Hello Tomaz

> On Tuesday 12 of November 2013 15:46:04 Eduardo Valentin wrote:
>> This patch introduces a device tree bindings for
>> describing the hardware thermal behavior and limits.
>> Also a parser to read and interpret the data and feed
>> it in the thermal framework is presented.
> [snip]
>> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/D=
ocumentation/devicetree/bindings/thermal/thermal.txt
>> new file mode 100644
>> index 0000000..59f5bd2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
>> @@ -0,0 +1,586 @@
> [snip]
>> +* Cooling device nodes
>> +
>> +Cooling devices are nodes providing control on power dissipation. The=
re
>> +are essentially two ways to provide control on power dissipation. Fir=
st
>> +is by means of regulating device performance, which is known as passi=
ve
>> +cooling. A typical passive cooling is a CPU that has dynamic voltage =
and
>> +frequency scaling (DVFS), and uses lower frequencies as cooling state=
s.
>> +Second is by means of activating devices in order to remove
>> +the dissipated heat, which is known as active cooling, e.g. regulatin=
g
>> +fan speeds. In both cases, cooling devices shall have a way to determ=
ine
>> +the state of cooling in which the device is.
>> +
>> +Required properties:
>> +- cooling-min-state:	An integer indicating the smallest
>> +  Type: unsigned	cooling state accepted. Typically 0.
>> +  Size: one cell
>=20
> Could you explain (just in a reply) what a cooling state is and what ar=
e
> the min and max values used for?

Cooling state is an unsigned integer which represents heat control that
a cooling device implies.

>=20
>> +
>> +- cooling-max-state:	An integer indicating the largest
>> +  Type: unsigned	cooling state accepted.
>> +  Size: one cell
>> +
>> +- #cooling-cells:	Used to provide cooling device specific information=

>> +  Type: unsigned	while referring to it. Must be at least 2, in order
>> +  Size: one cell      	to specify minimum and maximum cooling state u=
sed
>> +			in the reference. The first cell is the minimum
>> +			cooling state requested and the second cell is
>> +			the maximum cooling state requested in the reference.
>> +			See Cooling device maps section below for more details
>> +			on how consumers refer to cooling devices.
>> +
>> +* Trip points
>> +
>> +The trip node is a node to describe a point in the temperature domain=

>> +in which the system takes an action. This node describes just the poi=
nt,
>> +not the action.
>> +
>> +Required properties:
>> +- temperature:		An integer indicating the trip temperature level,
>> +  Type: signed		in millicelsius.
>> +  Size: one cell
>> +
>> +- hysteresis:		A low hysteresis value on temperature property (above)=
=2E
>> +  Type: unsigned	This is a relative value, in millicelsius.
>> +  Size: one cell
>=20
> What about replacing temperature and hysteresis with a single temperatu=
re
> property that can be either one cell for 0 hysteresis or two cells to
> specify lower and upper range of temperatures?

What is the problem with using two properties? I think we loose
representation by gluing two properties into one just because one cell.

>=20
>> +
>> +- type:			a string containing the trip type. Supported values are:
>> +	"active":	A trip point to enable active cooling
>> +	"passive":	A trip point to enable passive cooling
>=20
> The two above seem to be implying action, as opposed to the general
> comment about trip points.

They do not imply action, they specify type of trip.

>=20
>> +	"hot":		A trip point to notify emergency
>> +	"critical":	Hardware not reliable.
>> +  Type: string
>> +
> [snip]
>> +* Examples
>> +
>> +Below are several examples on how to use thermal data descriptors
>> +using device tree bindings:
>> +
>> +(a) - CPU thermal zone
>> +
>> +The CPU thermal zone example below describes how to setup one thermal=
 zone
>> +using one single sensor as temperature source and many cooling device=
s and
>> +power dissipation control sources.
>> +
>> +#include <dt-bindings/thermal/thermal.h>
>> +
>> +cpus {
>> +	/*
>> +	 * Here is an example of describing a cooling device for a DVFS
>> +	 * capable CPU. The CPU node describes its four OPPs.
>> +	 * The cooling states possible are 0..3, and they are
>> +	 * used as OPP indexes. The minimum cooling state is 0, which means
>> +	 * all four OPPs can be available to the system. The maximum
>> +	 * cooling state is 3, which means only the lowest OPPs (198MHz@0.85=
V)
>> +	 * can be available in the system.
>> +	 */
>> +	cpu0: cpu@0 {
>> +		...
>> +		operating-points =3D <
>> +			/* kHz    uV */
>> +			970000  1200000
>> +			792000  1100000
>> +			396000  950000
>> +			198000  850000
>> +		>;
>> +		cooling-min-state =3D <0>;
>> +		cooling-max-state =3D <3>;
>> +		#cooling-cells =3D <2>; /* min followed by max */
>=20
> I believe you don't need the min- and max-state properties here then. Y=
our
> thermal core can simply query the cpufreq driver (which would be a cool=
ing
> device here) about the range of states it supports

This binding is not supposed to be aware of cpufreq, which is Linux
specific implementation.

Besides, the cpufreq layer is populated by data already specified in DT.
=2E
>=20
>> +	};
>> +	...
>> +};
>> +
>> +&i2c1 {
>> +	...
>> +	/*
>> +	 * A simple fan controller which supports 10 speeds of operation
>> +	 * (represented as 0-9).
>> +	 */
>> +	fan0: fan@0x48 {
>> +		...
>> +		cooling-min-state =3D <0>;
>> +		cooling-max-state =3D <9>;
>=20
> This is similar. The fan driver will probaby know about available
> fan speed levels and be able to report the range of states to thermal
> core.

Then we loose also the flexibility to assign cooling states to trip
points, as described in this binding.

>=20
> That's just for the binding. I will try to review the code when I find
> a bit more time.

ok.

>=20
> Best regards,
> Tomasz
>=20
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--gWrompVAELBKjsVwPaW8vmJdhgwtWMBHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlKEtHgACgkQCXcVR3XQvP2AQAD/V+9c81AkF8cH1mIhuyxXT8oE
efYyyYI1eFpk85bUfh8A/3BUhCQZfv26Y2Vum+U+Iu+QiduOitkyqDOaG9yYbN7J
=93CD
-----END PGP SIGNATURE-----

--gWrompVAELBKjsVwPaW8vmJdhgwtWMBHq--


--===============0439602365297579021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0439602365297579021==--
