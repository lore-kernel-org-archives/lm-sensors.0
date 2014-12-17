From: Sean O'Brien <sean451@hotmail.com>
Date: Wed, 17 Dec 2014 18:16:30 +0000
Subject: Re: [lm-sensors] Supermicro X7DBU configuration
Message-Id: <BLU175-W343C552D73F4342710ACF3E66D0@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU175-DS1275A243EB8731D1852460E66C0@phx.gbl>
In-Reply-To: <BLU175-DS1275A243EB8731D1852460E66C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org



> Date: Wed, 17 Dec 2014 10:06:08 -0800
> From: linux@roeck-us.net
> To: sean451@hotmail.com
> CC: jdelvare@suse.de; lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] Supermicro X7DBU configuration
>=20
> On Wed, Dec 17, 2014 at 12:59:38PM -0500, Sean O'Brien wrote:
>> Thanks Guenter. Unfortunately I dont see the adapter in the output. I ha=
d to load the i2c-dev driver manually and the output is as follows:
>> $ sudo i2cdetect -li2c-0 i2c Radeon i2c bit bus DVI_DDC I2C adapteri2c-1=
 i2c Radeon i2c bit bus VGA_DDC I2C adapteri2c-2 i2c Radeon i2c bit bus MON=
ID I2C adapteri2c-3 i2c Radeon i2c bit bus CRT2_DDC I2C adapter
>>=20
> In general, please don't top-post. Also, your output seems to be
> messed up. Do you use Outlook ? Just wondering.
>=20
> Anyway, guess that explains why you don't see the chip ;-).
> Wonder why you see it with sensors-detect, though.
>=20
> Try "sudo modprobe i2c-i801".
>=20
> Thanks,
> Guenter
>=20
>>> Date: Wed, 17 Dec 2014 09:40:24 -0800
>>> From: linux@roeck-us.net
>>> To: sean451@hotmail.com
>>> CC: jdelvare@suse.de; lm-sensors@lm-sensors.org
>>> Subject: Re: [lm-sensors] Supermicro X7DBU configuration
>>>=20
>>> On Wed, Dec 17, 2014 at 11:54:24AM -0500, Sean O'Brien wrote:
>>>> Thanks for the help guys.
>>>> The driver is loaded. It is placed into /etc/modules by a run of senso=
r-detect, so it sees it. It shows up in the output of lsmod and a replace o=
f the module using modprobe doesn't show any errors when loading it. Howeve=
r, as you point out, it doesn't show up in the output of the sensors comman=
ds (after running sensors -s also). Perhaps this is also and issue with the=
 /etc/sensors3.conf files not having the appropriate entries for this board=
? The entry in there for this chip is as follows:
>>>> chip "w83793-*"
>>>> label in0 "VcoreA" label in1 "VcoreB" label in7 "+5V" label in8 "5VSB"=
 label in9 "Vbat"
>>>> set in7_min 5.0 * 0.90 set in7_max 5.0 * 1.10 set in8_min 5.0 * 0.90 s=
et in8_max 5.0 * 1.10 set in9_min 3.0 * 0.90 set in9_max 3.0 * 1.10
>>>>=20
>>>=20
>>> The configuration file should not cause the chip to disappear completel=
y.=20
>>>=20
>>> Can you provide the output of i2cdump for the w83793 ? i2cdetect -l sho=
uld show
>>> you which bus it is on after loading the 2ic-dev driver; it is the i801=
 adapter.
>>> Command would be "sudo i2cdump <bus> 0x2f".
>>>=20
>>>> Btw. I found the machine doesn't have the IPMI board fitted, so no go =
there.
>>>> Thanks again.
>>>>=20
>>> sensors-detect reports the IPMI BMC, though, so I would assume it is th=
ere.
>>> Maybe you refer to the ipmi ethernet board ?
>>>=20
>>> Thanks,
>>> Guenter
>>>=20
>>>>> Date: Wed, 17 Dec 2014 08:27:12 -0800
>>>>> From: linux@roeck-us.net
>>>>> To: jdelvare@suse.de
>>>>> CC: sean451@hotmail.com; lm-sensors@lm-sensors.org
>>>>> Subject: Re: [lm-sensors] Supermicro X7DBU configuration
>>>>>=20
>>>>> On Wed, Dec 17, 2014 at 04:47:58PM +0100, Jean Delvare wrote:
>>>>>> Le Wednesday 17 December 2014 =E0 06:43 -0800, Guenter Roeck a =E9cr=
it :
>>>>>>> On 12/17/2014 02:08 AM, Jean Delvare wrote:
>>>>>>>> This chip is missing from the output of "sensors" below. You need =
to
>>>>>>>> figure out why. Is the w83793 kernel module available on your syst=
em?
>>>>>>>> Is it loaded? If not, what happens if you try to load it manually?=
 Any
>>>>>>>> error message in the kernel log? The fans are certainly connected =
to
>>>>>>>> that chip.
>>>>>>>=20
>>>>>>> Hardware monitoring might be disabled for this chip. I have seen th=
is
>>>>>>> with other Supermicro boards; on mine, for example, they use the se=
cond
>>>>>>> SuperIO chip only for additional serial ports. The kernel log might
>>>>>>> give a hint if that is the case.
>>>>>>=20
>>>>>> I doubt this is the case here, as the W83793G is a dedicated hardware
>>>>>> monitoring chip. There's no point in putting it on the board if they
>>>>>> don't use the feature.
>>>>>>=20
>>>>>>> Another option might be that the missing chip is the one used for h=
ardware
>>>>>>> monitoring but its register space is reserved by ACPI. That would e=
xplain
>>>>>>> why the chip listed below doesn't report much useful data. Again, t=
he
>>>>>>> kernel log should give a hint.
>>>>>>=20
>>>>>> I don't think this can happen for an SMBus device. If the SMBus
>>>>>> controller had an ACPI I/O resource conflict, sensors-detect would n=
ot
>>>>>> have been able to scan it. And there is no notion of I2C/SMBus resou=
rce
>>>>>> space in ACPI.
>>>>>>=20
>>>>> Good point. Maybe the w83793 driver is simply not loaded.
>>>>>=20
>>>>> Guenter
>>>>=20
>>=20

Yes. I am using outlook. I switched to plain text. My apologies.

Loading the module produced the following:

$ sudo =A0i2cdetect -l
i2c-0 =A0 i2c =A0 =A0 =A0 =A0 =A0 =A0 Radeon i2c bit bus DVI_DDC =A0 =A0 =
=A0 =A0 =A0 =A0 =A0I2C adapter
i2c-1 =A0 i2c =A0 =A0 =A0 =A0 =A0 =A0 Radeon i2c bit bus VGA_DDC =A0 =A0 =
=A0 =A0 =A0 =A0 =A0I2C adapter
i2c-2 =A0 i2c =A0 =A0 =A0 =A0 =A0 =A0 Radeon i2c bit bus MONID =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0I2C adapter
i2c-3 =A0 i2c =A0 =A0 =A0 =A0 =A0 =A0 Radeon i2c bit bus CRT2_DDC =A0 =A0 =
=A0 =A0 =A0 =A0 I2C adapter
i2c-4 =A0 smbus =A0 =A0 =A0 =A0 =A0 SMBus I801 adapter at 1100 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0SMBus adapter




 		 	   		 =20
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
