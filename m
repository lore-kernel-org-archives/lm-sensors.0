From: =?iso-8859-1?Q?Bj=F6rn_Gerhart?= <oss@extracloud.de>
Date: Tue, 27 Mar 2012 19:12:56 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (it87) Add support for  IT8781F, IT8782F, IT8783E/F
Message-Id: <9A52E6F1-F011-461D-BCCE-8EECF8AAB018@extracloud.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <6.2.5.6.2.20120324091434.02773d68@roeck-us.net>
In-Reply-To: <6.2.5.6.2.20120324091434.02773d68@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

HI Guenter,

Am 26.03.2012 um 21:05 schrieb Guenter Roeck:
> On Mon, 2012-03-26 at 12:08 -0400, Bj=F6rn Gerhart wrote:
>> Hi Guenter,
>>=20
>> Am 24.03.2012 um 19:07 schrieb Guenter Roeck:
>>> On Sat, Mar 24, 2012 at 12:23:13PM -0400, Guenter Roeck wrote:
>>>> Hi Bjoern,
>>>>=20
>>>> At 01:11 AM 3/24/2012, Bj=F6rn Gerhart wrote:
>>>> [ ... ]
>>>>=20
>>>>>   label temp3 "CPU T."
>>>>>   compute temp3 100+@,-1*(100-@)
>>>>=20
>>>> Is it possible that this is due to a bad sensor type configuration ?
>>>>=20
>>>> Thermal diodes have a "current mode" and a=20
>>>> "voltage mode", and if misconfigured (or=20
>>>> miswired) the reported temperature difference is=20
>>>> just about in that range. Difference in wiring,=20
>>>> if I understand it correctly, is that the + pin=20
>>>> is pulled high with a resistor in voltage mode,=20
>>>> which is not the case in current mode.
>>>>=20
>> As I have learned this morning from our hardware developers, neither "cu=
rrent" nor "voltage" mode is used with temp3, but digital "PECI" mode. In t=
his case, temp3's value describes the _difference_ between the actual tempe=
rature and the CPU's maximum temperature (where the CPU will begin to throt=
tle).
>> So actually, I think the static sensors.conf is the wrong place to speci=
fy this value, because different CPU models have different maximum temperat=
ures. Therefore, dealing with 100 in our own sensors.conf (as implemented b=
y now) is just a very rough inexact value.
>>=20
>> Afaik, only temp3@IT8783 can be used in PECI mode, and in general other =
ITE sensor chip models can be driven in PECI mode also.
>>=20
>> So, how could the PECI mode be handled on the driver side?
>> Detecting if it8783 is in PECI mode:
>> - Index register 0x2C, bit 6: set to 1 (Enable PECI)
>> - temp3 value is negative until CPU is not throttling
>>=20
> Possibly also register 0x55 (ADC Temperature Extra Channel Enable
> Register), bit 7.
>=20
> Can you check with your HW folks ?
>=20
Your're right, checked that point with my HW colleagues this morning. They =
say when bit7 is 1 (as it is in our design), then the chip is in PECI resp.=
 SST mode for getting digital temperatures @temp3.

Bj=F6rn


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
