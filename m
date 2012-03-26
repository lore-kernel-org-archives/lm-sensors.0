From: =?iso-8859-1?Q?Bj=F6rn_Gerhart?= <oss@extracloud.de>
Date: Mon, 26 Mar 2012 16:08:35 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (it87) Add support for  IT8781F, IT8782F, IT8783E/F
Message-Id: <C199F6E3-4C69-489C-83EE-8C4F91AC8F80@extracloud.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <6.2.5.6.2.20120324091434.02773d68@roeck-us.net>
In-Reply-To: <6.2.5.6.2.20120324091434.02773d68@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Guenter,

Am 24.03.2012 um 19:07 schrieb Guenter Roeck:
> On Sat, Mar 24, 2012 at 12:23:13PM -0400, Guenter Roeck wrote:
>> Hi Bjoern,
>>=20
>> At 01:11 AM 3/24/2012, Bj=F6rn Gerhart wrote:
>> [ ... ]
>>=20
>>>    label temp3 "CPU T."
>>>    compute temp3 100+@,-1*(100-@)
>>=20
>> Is it possible that this is due to a bad sensor type configuration ?
>>=20
>> Thermal diodes have a "current mode" and a=20
>> "voltage mode", and if misconfigured (or=20
>> miswired) the reported temperature difference is=20
>> just about in that range. Difference in wiring,=20
>> if I understand it correctly, is that the + pin=20
>> is pulled high with a resistor in voltage mode,=20
>> which is not the case in current mode.
>>=20
As I have learned this morning from our hardware developers, neither "curre=
nt" nor "voltage" mode is used with temp3, but digital "PECI" mode. In this=
 case, temp3's value describes the _difference_ between the actual temperat=
ure and the CPU's maximum temperature (where the CPU will begin to throttle=
).
So actually, I think the static sensors.conf is the wrong place to specify =
this value, because different CPU models have different maximum temperature=
s. Therefore, dealing with 100 in our own sensors.conf (as implemented by n=
ow) is just a very rough inexact value.

Afaik, only temp3@IT8783 can be used in PECI mode, and in general other ITE=
 sensor chip models can be driven in PECI mode also.

So, how could the PECI mode be handled on the driver side?
Detecting if it8783 is in PECI mode:
- Index register 0x2C, bit 6: set to 1 (Enable PECI)
- temp3 value is negative until CPU is not throttling

Where to get current CPU's maximum temperature from:
- MSR 0x1A2, bit23...bit 16

If actually it is the job of the module to do such calculations, I would of=
fer to create an it87 patch for IT8783 fixing this - analog to an existing =
module with a similar behavior (if you know one).


>> Problem with the wrong reading is that it affects=20
>> the sensor's dynamic range. You don't have much=20
>> dynamic range left if the reading is off by 100 degrees.
>>=20
> Hi again,
>=20
> you might want to check registers 0x56, 0x57, and 0x59.
> It might be better to adjust temperature values with those registers
> than with sensors.conf, to retain the sensor's dynamic range.
>=20
Thanks for your attentive review.

Bj=F6rn


> Thanks,
> Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
