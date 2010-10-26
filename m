From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 26 Oct 2010 19:06:23 +0000
Subject: Re: [lm-sensors] looking for help with W83795ADG
Message-Id: <20101026210623.61cbb211@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101022135607.6996731s0m2gcr48@webmail.mnet-online.de>
In-Reply-To: <20101022135607.6996731s0m2gcr48@webmail.mnet-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Karsten,

On Tue, 26 Oct 2010 20:46:48 +0200, Karsten de Freese wrote:
> hi Jean,
>=20
> Am 25.10.2010 09:30, schrieb Jean Delvare:
> > Now there is:
> >    http://khali.linux-fr.org/devel/misc/jc42/
> >   =20
> great - this did again work immediately :-)
>=20
> 'sensors' now gives:
> /
> karsten:~$ sensors
> jc42-i2c-0-18
> Adapter: SMBus PIIX4 adapter at 0b00
> temp1:       +21.5=B0C  (low  =3D  +0.0=B0C, high =3D  +0.0=B0C)  ALARM
>                        (crit =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM
>=20
> jc42-i2c-0-19
> Adapter: SMBus PIIX4 adapter at 0b00
> temp1:       +21.5=B0C  (low  =3D  +0.0=B0C, high =3D  +0.0=B0C)  ALARM
>                        (crit =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM

The 0 limits are a little odd. I would expect these sensor chips to get
up with sane defaults... But apparently they don't. I can't find any
mention of default values for these registers in the datasheet.

The good news is that your memory modules are pretty cool :)

>=20
> k10temp-pci-00c3
> Adapter: PCI adapter
> CPU Temp (internal): +25.0=B0C  (high =3D +70.0=B0C, crit =3D +100.0=B0C)=
 /
>=20
> So I wanted to change both names and thresholds for the two jc42=20
> readings. I succeeded with the names (after understanding the 'bus'=20
> statement..), but I did not manage to set temperature thresholds.
>=20
> The current config file:
>=20
> bus "i2c-0" "SMBus PIIX4 adapter at 0b00"
> /
> chip "jc42-i2c-0-18"
>          label temp1 "DRAM_0"
>          set temp1_min 0
>          set temp1_max 65
>          set temp1_crit 70
>=20
> chip "jc42-i2c-0-19"
>          label temp1 "DRAM_1"
>          set temp1_min 0
>          set temp1_max 65
>          set temp1_crit 70/

Assuming the trailing "/" is a typo, the above looks OK. Note that the
temp1_min are not needed, as the value is already 0. As I2C writes
aren't cheap, you may want to omit them for a slightly faster boot.

>=20
> still gives:
>=20
> /karsten:~$ sensors
> jc42-i2c-0-18
> Adapter: SMBus PIIX4 adapter at 0b00
> DRAM_0:      +21.5=B0C  (low  =3D  +0.0=B0C, high =3D  +0.0=B0C)  ALARM
>                        (crit =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM
>=20
> jc42-i2c-0-19
> Adapter: SMBus PIIX4 adapter at 0b00
> DRAM_1:      +21.5=B0C  (low  =3D  +0.0=B0C, high =3D  +0.0=B0C)  ALARM
>                        (crit =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM
>=20
> k10temp-pci-00c3
> Adapter: PCI adapter
> CPU Temp (internal): +25.5=B0C  (high =3D +70.0=B0C, crit =3D +100.0=B0C)
> /
> Could you think of an explanation?

I think you forgot to check the FAQ and in particular:
http://www.lm-sensors.org/wiki/FAQ/Chapter3#Isetnewlimitsanditdidntwork

> thanks and regards -
>=20
> Karsten
>=20
> (p.s.: I'll send another mail on the IMSI topic- please let me know once =

> this gets boring / annoying ;-)

Honestly, you are a very pleasant user to deal with. You're looking for
solutions by yourself before asking, you're polite, you write proper
English and you don't top post. I wish all users were like you!

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
