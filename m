From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 25 Jun 2014 06:26:48 +0000
Subject: Re: [lm-sensors] [RFT][PATCH] hwmon: (w83l786ng) Convert to devm_hwmon_device_register_with_groups
Message-Id: <53AA6BA8.2030102@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1403609228.348.1.camel@phoenix>
In-Reply-To: <1403609228.348.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 06/24/2014 10:49 PM, Jean Delvare wrote:
> Hi Guenter,
>
> On Tue, 24 Jun 2014 07:38:46 -0700, Guenter Roeck wrote:
>> The driver could also benefit from some cleanup. It wastes code space by=
 using
>> function macros instead of SENSOR_ATTR_2, and functions should be reorde=
red
>> to get rid of forward declarations. Difficult to do without HW or at lea=
st
>> simulation, though. Jean, do you have a register dump, by any chance ?
>
> I have the following:
>
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 20: c0 c1 c2 XX XX 25 26 XX 88 89 XX ff 00 ff 00 ff
> 30: 00 XX XX XX XX 50 4b 50 4b XX XX ff ff f0 f0 XX
> 40: 01 00 00 de fe 00 00 00 XX 00 00 00 a3 5c 80 XX
> 50: XX 00 04 41 11 XX XX XX XX XX XX XX XX XX XX XX
> 80: 3c ff ff 00 00 00 00 ff ff 00 00 00 00 33 XX 22
> 90: 00 14 0a 00 00 00 19 19 XX XX XX XX XX XX XX XX
>
> It was stored under the name w83l786ng-powerup.dump, so it is likely
> that I generated it based on the default register values in the
> datasheet and this isn't an real chip dump. Hope that helps anyway.
>

Seems to be working. This is what I get after applying the patches:

w83l786ng-i2c-7-2e
Adapter: SMBus stub driver
in0:          +1.54 V  (min =3D  +0.00 V, max =3D  +2.04 V)
in1:          +1.54 V  (min =3D  +0.00 V, max =3D  +2.04 V)
in2:          +1.55 V  (min =3D  +0.00 V, max =3D  +2.04 V)
fan1:        4963 RPM  (min =3D    0 RPM, div =3D 2)
fan2:        4927 RPM  (min =3D    0 RPM, div =3D 2)
temp1:        +37.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
temp2:        +38.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)

Do you have all those register dumps online, by any chance ?
That would be quite valuable.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
