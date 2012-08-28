From: leroy christophe <christophe.leroy@c-s.fr>
Date: Tue, 28 Aug 2012 12:09:00 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/lm70: adding support for NS LM74 chip
Message-Id: <503CB4DC.70507@c-s.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <201208231532.q7NFWCQZ023407@localhost.localdomain> <20120823181317.GA5623@roeck-us.net> <20120826174721.GA32334@roeck-us.net>
In-Reply-To: <20120826174721.GA32334@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org


Le 26/08/2012 19:47, Guenter Roeck a =E9crit :
> On Thu, Aug 23, 2012 at 11:13:17AM -0700, Guenter Roeck wrote:
>> On Thu, Aug 23, 2012 at 05:32:12PM +0200, Christophe Leroy wrote:
>>> Hello,
>>>
>> Hi Christophe,
>>
> Hi again,
>
> [ ... ]
Hi Guenter,

>>>  =20
>>> -	/* 3-wire link (shared SI/SO) for LM70 */
>>> -	if (chip =3D=3D LM70_CHIP_LM70 && !(spi->mode & SPI_3WIRE))
>>> +	/* 3-wire link (shared SI/SO) for LM70 and LM74 */
>>> +	if ((chip =3D=3D LM70_CHIP_LM70 || chip =3D=3D LM70_CHIP_LM74)
>>> +			&& !(spi->mode & SPI_3WIRE))
>> Ok for now, but I'll have to check this. The driver does not really write
>> anything to the chip, so it should be irrelevant which mode the SPI mast=
er
>> controller supports (MOSI does not have to be connected). Besides, from =
the
>> chip specification it looks like it is possible to connect the chip to a
>> standard SPI interface by adding a 10k resistor between MOSI and MISO.
>>
> After looking into the above, the proper change or fix is really to remov=
e the
> above check for SPI_3WIRE entirely. The driver works perfectly fine if a =
LM70 is
> connected to a controller which does not explicitly support SPI_3WIRE; al=
l that
> needs to be done is to connect MOSI through a resistor or not at all. Thi=
s is,
> however, a board design decision, not a SPI master chip limitation.
Ok, then I'll prepare a patch for this.
>
> With that, we don't need to explicitly add any LM74 specific code to the =
driver,
> since the TMP121 code does the trick. All we need to do is to update the
> documentation, adding a note that LM74 is supported as well, and that it =
can be
> selected with 'tmp121'.
Yes, could be the solution, but I'm however a bit puzzled with doing=20
this. The driver is originaly for NS LM70 component. Later on an=20
extension has been added for TMP121 which is from a different family,=20
even if compatible. Now we are talking about the LM74 which is in the=20
same family as the original LM70. Therefore I would expect to be able to=20
handle the LM74 directly from this driver, not through a tricky=20
compatibility with the 'tmp121'. I would expect to handle it the other=20
way round, ie consider the 'tmp121' as compatible with the LM74.
One of the reasons for that is that the driver reports the component ID=20
through /sys/class/hwmon/hwmonX/name

As the 'tmp121' is already in the driver, it is not a good idea to=20
replace it by LM74, however, I would prefer having the LM74 explicitly=20
addressable by the driver, in additional to the 'tmp121'

I'm preparing a patch to include support for both LM71 and LM74 in the=20
LM70 driver, in order to have a driver handling the complete family. Do=20
you see a problem for that ? It would look strange that the LM70 driver=20
handles LM70 and LM71, but LM74 through the compatible 'tmp121'

Nb, refer to your first answer, implementation for 'tmp122/124' is=20
another story because those have a programmable precision, not a fixed one.
>
> Thanks,
> Guenter
>
Thanks
Christophe

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
