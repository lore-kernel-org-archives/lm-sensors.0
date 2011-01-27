From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 27 Jan 2011 08:15:19 +0000
Subject: Re: [lm-sensors] Identifying i2c devices on Asus P8P67 sandybridge
Message-Id: <20110127091519.7bfd1937@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D40E39E.4030406@cfl.rr.com>
In-Reply-To: <4D40E39E.4030406@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Philip,

On Wed, 26 Jan 2011 22:16:46 -0500, Phillip Susi wrote:
> ( moved from linux-i2c to lm-sensors )
>=20
> > No, the device isn't even listed on lm-sensors.org's wiki, I am not
> > aware of anyone working on it.
> >
> > The datasheet isn't available for download from Nuvoton, but can
> > probably be requested from them.
>=20
> I signed up for an account and downloaded the datasheet today.  I'll=20

Signed up for an account where? The only way I know to get Nuvoton
datasheets is asking for them by e-mail. Did you find another way?

> take a look at some of the other drivers that are probably quite similar =

> and see if I can modify one to work on this chip.

If any of our drivers is suitable for addition of NCT6776F support,
this would most likely be w83627ehf. But only a close look at the
datasheet will tell if this is possible and a desirable.

> >> Then again, I wonder if it might be better to come up with an SSDT I c=
an
> >> dynamically load to define the ACPI FAN and TZ objects and let the
> >> regular acpi driver manage it.
> >
> > What an horrid idea. The ACPI FAN and TZ interfaces are very limited.
> > If the ACPI BIOS doesn't block access to the NCT6776F's I/O ports,
> > you'll be much better with a native driver.
>=20
> Why is this a horrid idea?  It seems like the idea is that ACPI systems=20
> are supposed to provide the TZ and FAN interfaces so that the OS can=20
> monitor the temperature and fan speed and get automatic fan speed=20
> control, or choose to override it, all without the bother of hardware=20
> specific drivers.  That seems good to me.

First of all, I am not aware of any ACPI interface for automatic fan
speed control, not even for fan speed reporting. All I've ever seen
from standard ACPI interfaces are: temperature values with a 1=B0C
resolution, and fan on/off switching. As I said, this is very limited.
Mind you, there is a reason why Asus came up with their own "standard"
(ATK0110).

Secondly, if you are going to write the code, writing it in the SSDT
won't save you any effort compared to writing native code (except that
I find ASL syntax horrible compared to C). The only interest of ACPI
implementations is that the OS needs no specific code to handle them,
but you still have hardware-specific driving code in the end. Simply,
it's in the BIOS, provided by the vendor, instead of being in the OS.

> Also here is the DIMM SPD dump that decode-dimms does not like:
>=20
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 93 10 0b 02 02 11 00 09 03 52 01 08 0f 00 1e 00    ??????.??R???.?.
> 10: 69 78 69 3c 69 10 f0 8c 70 03 3c 3c 00 f0 03 04    ixi<i???p?<<.???
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 01    ..............??
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 70: 00 00 00 00 00 84 b0 02 00 00 00 00 00 00 3f 58    .....???......?X
> 80: 4f 43 5a 33 50 31 36 30 30 43 36 4c 56 32 47 20    OCZ3P1600C6LV2G
> 90: 20 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00      ..............
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................

Decoded correctly by decode-dimms version 5733. I guess you were using
an old version of the script which didn't know about DDR3.

I am surprised by the tRAS though, it seems way too high, there may be a
bug in the script.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
