From: Luca Tettamanti <kronos.it@gmail.com>
Date: Mon, 24 Jan 2011 22:59:06 +0000
Subject: Re: [lm-sensors] insane readings on Asus A7M266 motherboard
Message-Id: <AANLkTimVB_REwV3m6Jp7vbFi80cfxEfYX4uZCO9AsJy3@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <761574.42437.qm@web36601.mail.mud.yahoo.com>
In-Reply-To: <761574.42437.qm@web36601.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, Jan 24, 2011 at 10:55 PM, Audio Phile <da_audiophile@yahoo.com> wro=
te:
> --- On Mon, 1/24/11, Luca Tettamanti <kronos.it@gmail.com> wrote:
>> Ok, now I'm curious :) Probably it's the ACPI thermal
>> zone.
>> Can you send me a copy of /sys/firmware/acpi/tables/DSDT?
>
> Glad to... It's on its way to your gmail account. =C2=A0Please let me kno=
w what it means!

Nothing is wrong ;-) The system firmware (ACPI) claims the SMBus
interface resources for itself, so newer kernels prevent the
i2a-viapro driver from loading in order to avoid possible conflicts. I
just wanted to see what the BIOS was using the chip for.

ACPI code has methods for fiddling with the i2c bus, not sure why,
I'll have to dig out the specs.
There are two public methods \_SI._MSG, and \_SI.SST, plus other
places where the bus is used.

L

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
