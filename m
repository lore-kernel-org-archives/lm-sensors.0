From: =?iso-8859-1?Q?Bj=F6rn_Gerhart?= <oss@extracloud.de>
Date: Wed, 16 May 2012 17:07:52 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (it87) Drop uart6 condition for vin5&vin6 for IT8783F
Message-Id: <E86A87F2-35DF-42E8-9CD9-E736E996B836@extracloud.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <50AE10ED-22C6-474A-90F2-81685F17B042@extracloud.de>
In-Reply-To: <50AE10ED-22C6-474A-90F2-81685F17B042@extracloud.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

Am 16.05.2012 um 11:23 schrieb Jean Delvare:
> On Wed, 16 May 2012 08:52:31 +0200, Jean Delvare wrote:
>> On Tue, 15 May 2012 12:51:08 -0700, Guenter Roeck wrote:
>>> The data sheet says, with Register 0x27/Bit 0:
>>>=20
>>> Function Selection of Pin 93 (FSP)
>>> 0: VIN5/FAN_TAC3/SIN6
>>> If bit 2 of index 2Ch is 1, FAN_TAC3/SIN6 input is enabled; otherwise
>>> select VIN5 input.
>>> 1: GP30
>>>=20
>>> Assuming the above is correct, I think I'll rename "uart6" to "fan3" and
>>> use
>>>=20
>>> 	fan3 =3D reg2C & (1 << 2);
>>> ...
>>> 	/* Check if fan3 is there or not */
>>> 	if ((reg27 & (1 << 0)) || !fan3)
>>>                sio_data->skip_fan |=3D (1 << 2);
>>> ...
>>> 	if ((reg27 & (1 << 0)) || fan3)
>>> 		sio_data->skip_in |=3D (1 << 5); /* No VIN5 */
>>>=20
>>> Does that make sense ?
>>=20
>> That's what the datasheet says, at least. I find it weird that enabling
>> UART6 has an effect on VIN5 vs. FAN3_TAC, especially when UART6 pins
>> can be remapped to a completely different location, but maybe this is
>> really how the chip works.
>>=20
Yes, our hw developers formerly also had to contact ITE for discussions abo=
ut different contexts for their hw wiring/implementation.

>> I think I wouldn't introduce variable fan3, as it is kind of a
>> misnomer, and a proper name would be overly long. But this is an
>> implementation detail.
>>=20
>> Bj=F6rn, what is your design using pin 93 for?
>=20
As discussed with our hw developers, in our design pin 93 is used for FAN_T=
AC3. The reason is, that uart6 gets moved. If uart6 would not get moved, th=
en pin 93 would be SIN6. So in turn the decision between FAN_TAC3 and SIN6 =
is not detectable.
However, maybe the proper design-specific sensors.conf could ignore fan3 if=
 pin 93 is used for SIN6.

> I've updated the driver at
> http://khali.linux-fr.org/devel/misc/it87/
>=20
> with Bj=F6rn's patch updated per the discussion above. Bj=F6rn, can you
> please give it a try and confirm it works for you?
>=20
Thanks for the update! I agree with the logic part you modified.
And yes, it works like expected (tested on IT8783F@kernel 2.6.32, configure=
d as described above)  ;-)

Bj=F6rn


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
