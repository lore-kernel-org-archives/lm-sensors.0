From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 05 Mar 2009 09:09:23 +0000
Subject: Re: [lm-sensors] Found unknown SMBus adapter 10de:0752 - how can I
Message-Id: <20090305100923.1b99b7eb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200903041438.45638.zbiggy@o2.pl>
In-Reply-To: <200903041438.45638.zbiggy@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, 5 Mar 2009 00:13:36 +0100, Zbigniew Luszpinski wrote:
> Wednesday 04 of March 2009 22:58:46 Jean Delvare napisa=C5=82(a):
> > If this gives resonable results I will add the new device ID to the
> > sensors-detect script and the i2c-nforce2 driver.
>=20
> I will probe file /dev/i2c-3.
> I will probe address range 0x03-0x77.
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- 08 -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 50: 50 51 -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --
>=20
> I will probe file /dev/i2c-4.
> I will probe address range 0x03-0x77.
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- 08 -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 50: 50 51 52 53 54 55 56 57 -- -- -- -- -- -- -- --
> 60: -- 61 -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 70: 70 -- -- -- -- -- -- --

This looks good. Can you please verify that:
# i2cdump -y 3 0x50 b
# i2cdump -y 3 0x50 c
# i2cdump -y 3 0x50 W
all return the exact same data?

You can now run sensors-detect again, but I doubt it will find any
hardware monitoring chip on the SMBus.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
