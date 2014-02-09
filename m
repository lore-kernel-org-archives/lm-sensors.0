From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 09 Feb 2014 09:32:49 +0000
Subject: Re: [lm-sensors] Missing fan speed readout for ASUS M5A97 EVO R2.0 motherboard
Message-Id: <20140209103249.27284d9b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAH2=CKyXKgmCdNLDoa0_qnDTerrCS+S=5v39hCMJ4m7eQgnbig@mail.gmail.com>
In-Reply-To: <CAH2=CKyXKgmCdNLDoa0_qnDTerrCS+S=5v39hCMJ4m7eQgnbig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Rune,

On Fri, 7 Feb 2014 16:16:29 +0100, Rune Kj=E6r Svendsen wrote:
> Hi Jean
>=20
> Sorry about the formatting :) I've enabled plain text mode in Gmail
> now (I hope that's sufficient).
>=20
> I actually just updated the BIOS a couple of days ago, so everything
> is up-to-date BIOS-wise.
>=20
> Enabling fan5 gives the following values, unfortunately:
>=20
> rune@rune-desktop:~$ cat /sys/class/hwmon/hwmon1/device/fan5_alarm
> 1
> rune@rune-desktop:~$ cat /sys/class/hwmon/hwmon1/device/fan5_input
> 0
> rune@rune-desktop:~$ cat /sys/class/hwmon/hwmon1/device/fan5_min
> -1

OK, no luck :-(

> Here's a register dump after setting the registers to enable fan5:
>=20
> root@rune-desktop:~# isadump -y 0x295 0x296
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 19 40 b7 02 00 00 00 00 00 80 58 0f 27 3e 0d e5
> 10: 0c 6a 09 77 c7 00 00 00 04 03 03 fa 3d c3 c3 c3
> 20: e5 e7 72 86 39 cd 10 19 8a 2a 23 80 80 c3 ad ad
> 30: af 65 69 da 32 ee 92 6d 87 be 4a 1a 6f 00 0a 57
> 40: 6f f8 e7 68 63 85 5f 40 ad 6a d4 00 ff ff ff ff
> 50: 2f 18 7f 7f 7f 40 00 00 90 00 38 12 60 00 00 00
> 60: 80 00 7f 00 00 41 00 ff 7f 7f 7f 80 00 00 00 ff
> 70: 80 00 7f 81 00 41 00 ff ff ff ff ff ff ff ff ff
> 80: 00 00 ff ff 00 00 00 00 00 00 00 00 00 27 02 0f
> 90: ff 00 00 00 ff 00 00 00 ff ff ff ff ff ff ff ff
> a0: ee 0b 0b 0b 0b 0b 0b ff ff ff ff ff ff ff ff ff
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

So the setting was properly written to the register, but apparently the
pin in question has no fan wired to it.

If you are ready to take some risk and think getting the third case fan
input is worth it, you can try enabling fan4. I say it is a bit more
risky because it involves changing the pin configuration. As we don't
know what this pin is actually used for and connected to, bad surprises
could happen. If you don't feel like doing it, just don't.

If you want to try enabling fan4, do the following:

# rmmod it87
# isaset -f 0x2e 0x87
# isaset -f 0x2e 0x01
# isaset -f 0x2e 0x55
# isaset -f 0x2e 0x55
# isaset 0x2e 0x2f 0x07 0x07
# isaset 0x2e 0x2f 0x26 0xb8
# isaset 0x2e 0x2f 0x02 0x02
(At this point you may double-check that value of register 0x26 was
properly changed, using "isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f
0x07".)
# isaset 0x295 0x296 0x0c 0x37 # modprobe it87

You may or may not get the extra fan speed reading you were looking
for. If you don't, then I suggest you restore the original chip
configuration, by either cold booting the machine, or going through the
following sequence:

# rmmod it87
# isaset 0x295 0x296 0x0c 0x07
# isaset -f 0x2e 0x87
# isaset -f 0x2e 0x01
# isaset -f 0x2e 0x55
# isaset -f 0x2e 0x55
# isaset 0x2e 0x2f 0x07 0x07
# isaset 0x2e 0x2f 0x26 0x98
# isaset 0x2e 0x2f 0x02 0x02
# modprobe it87

Good luck :-)

--=20
Jean Delvare
http://jdelvare.nerim.net/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
