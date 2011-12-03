From: Eddi De Pieri <eddi@depieri.net>
Date: Sat, 03 Dec 2011 16:42:16 +0000
Subject: Re: [lm-sensors] [PATCH] i2c multiplexer driver for Proliant
Message-Id: <CAKdnbx54R9t-mS9-EvyT-618wVp-YH0YDO++=m5t-JqR6h=GCw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAKdnbx7xeygkOK=BR+3vUrWT3GEt=PZrxgrEMvEB5nkOfAF0bg@mail.gmail.com>
 <20111127225514.GO19115@trinity.fluff.org> <CAKdnbx4u6+_WJjjMJ3jnDLSU8eJ0yXX0Mg-dcr=3F4FaOd2R=g@mail.gmail.com>
 <20111203162757.GA24302@ericsson.com>
In-Reply-To: <20111203162757.GA24302-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

Actually I don't have a development system with latest git. I build my
patch on my debian with 2.6.32 kernel..

The patch is based on i2c-amd756-s4882.c and adapted to work with sb8xx...

i2c-amd756-s4882.c is still present and don't use i2c-mux infrastructure.

However if you are interested in porting my work to latest git, you
will be welcome!

Regards Eddi


On Sat, Dec 3, 2011 at 5:27 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Sat, Dec 03, 2011 at 10:31:30AM -0500, Eddi De Pieri wrote:
>> This patch add support to multiplexed smbus for proliant microserver
>> N36L and may be applicable to other configuration based on sb8xx
>> southbus.
>>
>
> Did you read Documentation/SubmittingPatches ?
>
> The patch doesn't follow the canonical patch format, I can see that lines=
 are split,
> the patch isn't based on the linux root directory but on some other direc=
tory which
> I guess you expect the reader to figure out, the patch description includ=
es lots
> of information which is irrelevant for the changelog, and it is based on =
2.6.32
> instead of the current release and thus pretty much guaranteed not to app=
ly
> to the current kernel version. All that w/o even looking into the code.
>
> The patch implements an I2C multiplexer but doesn't use the I2C multiplex=
er
> infrastructure. I am not one of the I2C maintainers, but that alone would=
 cause me
> to reject this patch (on top of all the other reasons above).
>
> Guenter
>
>> root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -l
>> i2c-0 =A0 smbus =A0 =A0 =A0 =A0 =A0 SMBus piix4 adapter (SDA0) =A0 =A0 =
=A0 =A0 =A0 =A0 =A0SMBus adapter
>> i2c-1 =A0 smbus =A0 =A0 =A0 =A0 =A0 SMBus piix4 adapter (SDA2) =A0 =A0 =
=A0 =A0 =A0 =A0 =A0SMBus adapter
>> i2c-2 =A0 smbus =A0 =A0 =A0 =A0 =A0 SMBus piix4 adapter (SDA3) =A0 =A0 =
=A0 =A0 =A0 =A0 =A0SMBus adapter
>> i2c-3 =A0 smbus =A0 =A0 =A0 =A0 =A0 SMBus piix4 adapter (SDA4) =A0 =A0 =
=A0 =A0 =A0 =A0 =A0SMBus adapter
>> root@proliant:/usr/src/lm-sensors/eddi#
>>
>> yes SDA1 is reserved... so i can't multiplex it
>>
>> root@proliant:/usr/src/lm-sensors/eddi# sensors
>> k10temp-pci-00c3
>> Adapter: PCI adapter
>> temp1: =A0 =A0 =A0 +24.5=B0C =A0(high =3D +70.0=B0C, crit =3D +100.0=B0C)
>>
>> w83795adg-i2c-1-2f
>> Adapter: SMBus piix4 adapter (SDA2)
>> in0: =A0 =A0 =A0 =A0 +1.02 V =A0(min =3D =A0+0.00 V, max =3D =A0+2.05 V)
>> in1: =A0 =A0 =A0 =A0 +1.52 V =A0(min =3D =A0+0.00 V, max =3D =A0+2.05 V)
>> in2: =A0 =A0 =A0 =A0 +1.10 V =A0(min =3D =A0+0.00 V, max =3D =A0+2.05 V)
>> in3: =A0 =A0 =A0 =A0 +0.89 V =A0(min =3D =A0+0.00 V, max =3D =A0+2.05 V)
>> in12: =A0 =A0 =A0 =A0+3.35 V =A0(min =3D =A0+0.00 V, max =3D =A0+6.14 V)
>> in13: =A0 =A0 =A0 =A0+3.28 V =A0(min =3D =A0+0.00 V, max =3D =A0+6.14 V)
>> fan1: =A0 =A0 =A0 =A0703 RPM =A0(min =3D =A0329 RPM)
>> temp1: =A0 =A0 =A0 +23.0=B0C =A0(high =3D +109.0=B0C, hyst =3D +109.0=B0=
C)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (crit =3D +109.0=B0C, hyst =
=3D +109.0=B0C) =A0sensor =3D thermal diode
>> temp2: =A0 =A0 =A0 +33.2=B0C =A0(high =3D +105.0=B0C, hyst =3D +105.0=B0=
C)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (crit =3D +105.0=B0C, hyst =
=3D +105.0=B0C) =A0sensor =3D thermal diode
>> temp5: =A0 =A0 =A0 +14.0=B0C =A0(high =3D +39.0=B0C, hyst =3D +39.0=B0C)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (crit =3D +44.0=B0C, hyst =
=3D +44.0=B0C) =A0sensor =3D thermistor
>> beep_enable:disabled
>>
>> jc42-i2c-0-18
>> Adapter: SMBus piix4 adapter (SDA0)
>> temp1: =A0 =A0 =A0 +20.5=B0C =A0(low =A0=3D =A0+0.0=B0C, high =3D =A0+0.=
0=B0C) =A0ALARM
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (crit =3D =A0+0.0=B0C, hyst =
=3D =A0+0.0=B0C) =A0ALARM
>>
>>
>> root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -y 0
>> =A0 =A0 =A00 =A01 =A02 =A03 =A04 =A05 =A06 =A07 =A08 =A09 =A0a =A0b =A0c=
 =A0d =A0e =A0f
>> 00: =A0 =A0 =A0 =A0 =A0-- -- -- -- -- -- -- -- -- -- -- -- --
>> 10: -- -- -- -- -- -- -- -- UU -- -- -- -- -- -- --
>> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 50: 50 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 70: -- -- -- -- -- -- -- --
>>
>> root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -y 1
>> =A0 =A0 =A00 =A01 =A02 =A03 =A04 =A05 =A06 =A07 =A08 =A09 =A0a =A0b =A0c=
 =A0d =A0e =A0f
>> 00: =A0 =A0 =A0 =A0 =A0-- -- -- -- -- -- -- -- -- -- -- -- --
>> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- UU
>> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 60: -- 61 -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 70: -- -- -- -- -- -- -- --
>>
>> root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -y 2
>> =A0 =A0 =A00 =A01 =A02 =A03 =A04 =A05 =A06 =A07 =A08 =A09 =A0a =A0b =A0c=
 =A0d =A0e =A0f
>> 00: =A0 =A0 =A0 =A0 =A0-- -- -- -- -- -- -- -- -- -- -- -- --
>> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 40: -- -- -- -- -- -- -- -- -- -- -- -- 4c -- -- --
>> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 70: -- -- -- -- -- -- -- --
>>
>> root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -y 3
>> =A0 =A0 =A00 =A01 =A02 =A03 =A04 =A05 =A06 =A07 =A08 =A09 =A0a =A0b =A0c=
 =A0d =A0e =A0f
>> 00: =A0 =A0 =A0 =A0 =A0-- -- -- -- -- -- -- -- -- -- -- -- --
>> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 70: -- -- -- -- -- -- -- --
>>
>> pay attention that the msleep seems to be really needed...
>>
>> Signed-off-by: Eddi De Pieri <eddi@depieri.net>
>>
>> Regards,
>>
>> Eddi
>>
>> follows patch....
>>
>> diff -u -N -r 2.6.32.orig/i2c-piix4.c 2.6.32/i2c-piix4.c
>> --- 2.6.32.orig/i2c-piix4.c =A0 =A0 2011-11-16 17:07:03.000000000 +0100
>> +++ 2.6.32/i2c-piix4.c =A02011-11-16 15:21:17.000000000 +0100
>> @@ -97,7 +97,8 @@
>> =A0static unsigned short piix4_smba;
>> =A0static int srvrworks_csb5_delay;
>> =A0static struct pci_driver piix4_driver;
>> -static struct i2c_adapter piix4_adapter;
>> +struct i2c_adapter piix4_adapter;
>> +EXPORT_SYMBOL_GPL(piix4_adapter);
>>
>> =A0static struct dmi_system_id __devinitdata piix4_dmi_blacklist[] =3D {
>> =A0 =A0 =A0 =A0 {
>> @@ -246,10 +247,22 @@
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "0x%x already in use!\n"=
, smba_idx);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
>> =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 outb_p(smb_en, smba_idx);
>> - =A0 =A0 =A0 smba_en_lo =3D inb_p(smba_idx + 1);
>> - =A0 =A0 =A0 outb_p(smb_en + 1, smba_idx);
>> - =A0 =A0 =A0 smba_en_hi =3D inb_p(smba_idx + 1);
>> + =A0 =A0 =A0 outb_p(smb_en, smba_idx); =A0 =A0 =A0 =A0 =A0 =A0 =A0 //se=
leziono il registro 0x2c
>> + =A0 =A0 =A0 smba_en_lo =3D inb_p(smba_idx + 1); =A0 =A0 =A0 //leggo il=
 dato L del registro 0x2c
>> + =A0 =A0 =A0 outb_p(smb_en + 1, smba_idx); =A0 =A0 =A0 =A0 =A0 //selezi=
ono il registro 0x2c + 1
>> + =A0 =A0 =A0 smba_en_hi =3D inb_p(smba_idx + 1); =A0 =A0 =A0 //leggo il=
 dato H del registro 0x2c
>> +
>> + =A0 =A0 =A0 outb_p(smb_en, smba_idx); =A0 =A0 =A0 =A0 =A0 =A0 =A0 //se=
leziono il registro 0x2c
>> + =A0 =A0 =A0 outb_p(smba_en_lo & 0xF9 , smba_idx + 1); //seleziono la p=
orta 0 00 0
>> + =A0 =A0 =A0 outb_p(smb_en + 1, smba_idx); =A0 =A0 =A0 =A0 =A0 //selezi=
ono il registro 0x2c + 1
>> + =A0 =A0 =A0 outb_p(smba_en_hi, smba_idx + 1);
>> +
>> + =A0 =A0 =A0 outb_p(smb_en, smba_idx); =A0 =A0 =A0 =A0 =A0 =A0 =A0 //se=
leziono il registro 0x2c
>> + =A0 =A0 =A0 smba_en_lo =3D inb_p(smba_idx + 1); =A0 =A0 =A0 //leggo il=
 dato L del registro 0x2c
>> + =A0 =A0 =A0 outb_p(smb_en + 1, smba_idx); =A0 =A0 =A0 =A0 =A0 //selezi=
ono il registro 0x2c + 1
>> + =A0 =A0 =A0 smba_en_hi =3D inb_p(smba_idx + 1); =A0 =A0 =A0 //leggo il=
 dato H del registro 0x2c
>> +
>> +
>> =A0 =A0 =A0 =A0 release_region(smba_idx, 2);
>>
>> =A0 =A0 =A0 =A0 if ((smba_en_lo & 1) =3D=3D 0) {
>> @@ -258,6 +271,8 @@
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> =A0 =A0 =A0 =A0 }
>>
>> + =A0 =A0 =A0 dev_info(&PIIX4_dev->dev,"Selected Default Smbus Port 0x%x=
",
>> (smba_en_lo & 0x6) >> 1);
>> +
>> =A0 =A0 =A0 =A0 piix4_smba =3D ((smba_en_hi << 8) | smba_en_lo) & 0xffe0;
>> =A0 =A0 =A0 =A0 if (acpi_check_region(piix4_smba, SMBIOSIZE, piix4_drive=
r.name))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> @@ -466,7 +481,7 @@
>> =A0 =A0 =A0 =A0 .functionality =A0=3D piix4_func,
>> =A0};
>>
>> -static struct i2c_adapter piix4_adapter =3D {
>> +struct i2c_adapter piix4_adapter =3D {
>> =A0 =A0 =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,
>> =A0 =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D I2C_CLASS_HWMON | I2C_CLAS=
S_SPD,
>> =A0 =A0 =A0 =A0 .algo =A0 =A0 =A0 =A0 =A0 =3D &smbus_algorithm,
>> diff -u -N -r 2.6.32.orig/i2c-piix4-n36l.c 2.6.32/i2c-piix4-n36l.c
>> --- 2.6.32.orig/i2c-piix4-n36l.c =A0 =A0 =A0 =A01970-01-01 01:00:00.0000=
00000 +0100
>> +++ 2.6.32/i2c-piix4-n36l.c =A0 =A0 2011-11-16 16:02:01.000000000 +0100
>> @@ -0,0 +1,247 @@
>> +/*
>> + * i2c-piix4-n36l.c - i2c-piix4 extras for the HP proliant
>> microserver n36l motherboard
>> + *
>> + * Copyright (C) 2004, 2008 Jean Delvare <khali@linux-fr.org>
>> + * Copyright (C) 2011 =A0Eddi De Pieri <eddi@depieri.net>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>> + */
>> +
>> +/*
>> + * We select the channels by sending commands to the sb800 southbus
>> + * the selection bit
>> + * http://support.amd.com/us/Embedded_TechDocs/45482.pdf
>> + * =A0Smbus0En - RW =E2=80=93 16 bits - [PM_Reg: 2Ch]
>> + * =A0Field Name Bits Default Description
>> + * =A0SmBus0En 0 0b Set to 1 to enable SMBUS0 function and decoding.
>> + * =A0SmBus0Sel 2:1 00b SmBus port selection when PM_Reg 2Fh bit 0 is s=
et to 0
>> + * =A000: Port 0
>> + * =A001: Port 2
>> + * =A010: Port 3
>> + * =A011: Port 4
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/slab.h>
>> +#include <linux/init.h>
>> +#include <linux/i2c.h>
>> +#include <linux/mutex.h>
>> +#include <asm/io.h>
>> +
>> +extern struct i2c_adapter piix4_adapter;
>> +
>> +static struct i2c_adapter *n36l_adapter;
>> +static struct i2c_algorithm *n36l_algo;
>> +
>> +/* Wrapper access functions for multiplexed SMBus */
>> +static DEFINE_MUTEX(piix4_lock);
>> +
>> +/* We remember the last used channels combination so as to only switch
>> + =A0 channels when it is really needed. This greatly reduces the SMBus
>> + =A0 overhead, but also assumes that nobody will be writing to the PCA9=
556
>> + =A0 in our back. */
>> +static u8 last_channels;
>> +
>> +static inline s32 piix4_access_channel(struct i2c_adapter * adap, u16 a=
ddr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 unsigned short flags, char read_write,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 u8 command, int size,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 union i2c_smbus_data * data,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 u8 channels)
>> +{
>> + =A0 =A0 =A0 int error;
>> + =A0 =A0 =A0 unsigned short smba_idx =3D 0xcd6;
>> + =A0 =A0 =A0 u8 smba_en_lo, smba_en_hi, smb_en =3D 0x2c;
>> +
>> + =A0 =A0 =A0 mutex_lock(&piix4_lock);
>> +
>> + =A0 =A0 =A0 if (last_channels !=3D channels) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 union i2c_smbus_data mplxdata;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mplxdata.byte =3D channels;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Determine the address of the SMBus area=
s */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!request_region(smba_idx, 2, "smba_idx=
")) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&piix4_adapter.dev=
, "SMBus base address index region "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "0x%x alre=
ady in use!\n", smba_idx);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 outb_p(smb_en, smba_idx); =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 //seleziono il registro 0x2c
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 smba_en_lo =3D inb_p(smba_idx + 1); =A0 =
=A0 =A0 //leggo il dato L del registro 0x2c
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 outb_p(smb_en + 1, smba_idx); =A0 =A0 =A0 =
=A0 =A0 //seleziono il registro 0x2c + 1
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 smba_en_hi =3D inb_p(smba_idx + 1); =A0 =
=A0 =A0 //leggo il dato H del registro 0x2c
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(50);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 outb_p(smb_en, smba_idx); =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 //seleziono il registro 0x2c
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 outb_p((smba_en_lo & 0xF9 )+ ( channels <<=
 1) , smba_idx + 1);
>> //seleziono la porta 0 00 0
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 outb_p(smb_en + 1, smba_idx); =A0 =A0 =A0 =
=A0 =A0 //seleziono il registro 0x2c + 1
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 outb_p(smba_en_hi, smba_idx + 1);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(50);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_region(smba_idx, 2);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&piix4_adapter.dev,"Selected Smbu=
s Port 0x%x", (smba_en_lo
>> & 0x6) >> 1);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 last_channels =3D channels;
>> +
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 error =3D piix4_adapter.algo->smbus_xfer(adap, addr, flags=
, read_write,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 command, size, data);
>> +
>> +
>> + =A0 =A0 =A0 mutex_unlock(&piix4_lock);
>> + =A0 =A0 =A0 return error;
>> +}
>> +
>> +static s32 piix4_access_virt0(struct i2c_adapter * adap, u16 addr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned sh=
ort flags, char read_write,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u8 command,=
 int size,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0union i2c_s=
mbus_data * data)
>> +{
>> + =A0 =A0 =A0 return piix4_access_channel(adap, addr, flags, read_write,=
 command,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0size, data, 0);
>> +}
>> +
>> +static s32 piix4_access_virt1(struct i2c_adapter * adap, u16 addr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned sh=
ort flags, char read_write,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u8 command,=
 int size,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0union i2c_s=
mbus_data * data)
>> +{
>> + =A0 =A0 =A0 return piix4_access_channel(adap, addr, flags, read_write,=
 command,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0size, data, 1);
>> +}
>> +
>> +static s32 piix4_access_virt2(struct i2c_adapter * adap, u16 addr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned sh=
ort flags, char read_write,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u8 command,=
 int size,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0union i2c_s=
mbus_data * data)
>> +{
>> + =A0 =A0 =A0 return piix4_access_channel(adap, addr, flags, read_write,=
 command,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0size, data, 2);
>> +}
>> +
>> +static s32 piix4_access_virt3(struct i2c_adapter * adap, u16 addr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned sh=
ort flags, char read_write,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u8 command,=
 int size,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0union i2c_s=
mbus_data * data)
>> +{
>> + =A0 =A0 =A0 return piix4_access_channel(adap, addr, flags, read_write,=
 command,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0size, data, 3);
>> +}
>> +
>> +static int __init piix4_n36l_init(void)
>> +{
>> + =A0 =A0 =A0 int i, error;
>> +
>> + =A0 =A0 =A0 if (!piix4_adapter.dev.parent)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> +
>> + =A0 =A0 =A0 printk(KERN_INFO "Configure the AMD SB800 Multiplexer\n");
>> +
>> + =A0 =A0 =A0 /* Unregister physical bus */
>> + =A0 =A0 =A0 error =3D i2c_del_adapter(&piix4_adapter);
>> + =A0 =A0 =A0 if (error) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&piix4_adapter.dev, "Physical bus =
removal failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto ERROR0;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 printk(KERN_INFO "Enabling SMBus multiplexing for Hp Proli=
ant
>> Microserver N36l\n");
>> + =A0 =A0 =A0 /* Define the 4 virtual adapters and algorithms structures=
 */
>> + =A0 =A0 =A0 if (!(n36l_adapter =3D kzalloc(5 * sizeof(struct i2c_adapt=
er),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 GFP_KERNEL))) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto ERROR1;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 if (!(n36l_algo =3D kzalloc(5 * sizeof(struct i2c_algorith=
m),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0GFP=
_KERNEL))) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto ERROR2;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /* Fill in the new structures */
>> + =A0 =A0 =A0 n36l_algo[0] =3D *(piix4_adapter.algo);
>> + =A0 =A0 =A0 n36l_algo[0].smbus_xfer =3D piix4_access_virt0;
>> + =A0 =A0 =A0 n36l_adapter[0] =3D piix4_adapter;
>> + =A0 =A0 =A0 snprintf(n36l_adapter[0].name, sizeof(n36l_adapter[0].name=
),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"SMBus piix4 adapter (SDA0)");
>> + =A0 =A0 =A0 n36l_adapter[0].algo =3D n36l_algo;
>> + =A0 =A0 =A0 n36l_adapter[0].dev.parent =3D piix4_adapter.dev.parent;
>> + =A0 =A0 =A0 for (i =3D 1; i < 4; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 n36l_algo[i] =3D *(piix4_adapter.algo);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 n36l_adapter[i] =3D piix4_adapter;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snprintf(n36l_adapter[i].name, sizeof(n36l=
_adapter[i].name),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"SMBus piix4 adapter (S=
DA%d)", i + 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 n36l_adapter[i].algo =3D n36l_algo+i;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 n36l_adapter[i].dev.parent =3D piix4_adapt=
er.dev.parent;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 n36l_algo[1].smbus_xfer =3D piix4_access_virt1;
>> + =A0 =A0 =A0 n36l_algo[2].smbus_xfer =3D piix4_access_virt2;
>> + =A0 =A0 =A0 n36l_algo[3].smbus_xfer =3D piix4_access_virt3;
>> +
>> + =A0 =A0 =A0 /* Register virtual adapters */
>> + =A0 =A0 =A0 for (i =3D 0; i < 4; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D i2c_add_adapter(n36l_adapter+i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (error) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "i2c-piix4=
-n36l: "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Virtual ad=
apter %d registration "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"failed, mo=
dule not inserted\n", i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i--; i >=3D 0; i--)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_del_ad=
apter(n36l_adapter+i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto ERROR3;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return 0;
>> +
>> +ERROR3:
>> + =A0 =A0 =A0 kfree(n36l_algo);
>> + =A0 =A0 =A0 n36l_algo =3D NULL;
>> +ERROR2:
>> + =A0 =A0 =A0 kfree(n36l_adapter);
>> + =A0 =A0 =A0 n36l_adapter =3D NULL;
>> +ERROR1:
>> + =A0 =A0 =A0 /* Restore physical bus */
>> + =A0 =A0 =A0 i2c_add_adapter(&piix4_adapter);
>> +ERROR0:
>> + =A0 =A0 =A0 return error;
>> +}
>> +
>> +static void __exit piix4_n36l_exit(void)
>> +{
>> + =A0 =A0 =A0 if (n36l_adapter) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int i;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < 5; i++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_del_adapter(n36l_adapt=
er+i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(n36l_adapter);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 n36l_adapter =3D NULL;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 kfree(n36l_algo);
>> + =A0 =A0 =A0 n36l_algo =3D NULL;
>> +
>> + =A0 =A0 =A0 /* Restore physical bus */
>> + =A0 =A0 =A0 if (i2c_add_adapter(&piix4_adapter))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "i2c-piix4-n36l: "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Physical bus restoration f=
ailed\n");
>> +}
>> +
>> +MODULE_AUTHOR("Eddi De Pieri <eddi@depieri.net");
>> +MODULE_DESCRIPTION("n36l SMBus multiplexing");
>> +MODULE_LICENSE("GPL");
>> +
>> +module_init(piix4_n36l_init);
>> +module_exit(piix4_n36l_exit);
>>
>>
>> On Sun, Nov 27, 2011 at 11:55 PM, Ben Dooks <ben-i2c@fluff.org> wrote:
>> >
>> > On Fri, Nov 25, 2011 at 11:07:21PM +0100, Eddi De Pieri wrote:
>> >> This patch add support to multiplexed smbus for proliant microserver
>> >> N36L and may be applicable to other configuration based on sb8xx
>> >> southbus.
>> >>
>> >> root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -l
>> >> i2c-0 =A0 smbus =A0 =A0 =A0 =A0 =A0 SMBus piix4 adapter (SDA0) =A0 =
=A0 =A0 =A0 =A0 =A0 =A0SMBus adapter
>> >> i2c-1 =A0 smbus =A0 =A0 =A0 =A0 =A0 SMBus piix4 adapter (SDA2) =A0 =
=A0 =A0 =A0 =A0 =A0 =A0SMBus adapter
>> >> i2c-2 =A0 smbus =A0 =A0 =A0 =A0 =A0 SMBus piix4 adapter (SDA3) =A0 =
=A0 =A0 =A0 =A0 =A0 =A0SMBus adapter
>> >> i2c-3 =A0 smbus =A0 =A0 =A0 =A0 =A0 SMBus piix4 adapter (SDA4) =A0 =
=A0 =A0 =A0 =A0 =A0 =A0SMBus adapter
>> >> root@proliant:/usr/src/lm-sensors/eddi#
>> >
>> > patch should go inline so it can be reviewed, thanks.
>> >
>> > --
>> > Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/
>> >
>> > Large Hadron Colada: A large Pina Colada that makes the universe disap=
pear.
>> >
>>
>> _______________________________________________
>> lm-sensors mailing list
>> lm-sensors@lm-sensors.org
>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
