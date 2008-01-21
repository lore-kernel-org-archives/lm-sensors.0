From: Matt Roberds <mattroberds@cox.net>
Date: Mon, 21 Jan 2008 20:52:55 +0000
Subject: [lm-sensors] adt7475 support (Asus M2N-SLI Deluxe)
Message-Id: <Pine.LNX.4.64.0801211406570.32720@birdbird.example.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="655872-352042579-1200948775=:32720"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--655872-352042579-1200948775=:32720
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello all!

I recently built a system using an Asus M2N-SLI Deluxe motherboard,
which has an Analog Devices ADT7475 thermal monitor and fan control
chip.  sensors-detect knows about it but says there is no driver.  I've
been looking through the mailing list archives and found a post from
Hans de Goede in December with a partial driver (see
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-December/022169.html =
).

I downloaded that driver and it built as a module under kernel 2.6.18,
after commenting out a few lines of code.  sensors (from lm-sensors
3.0.0) says:

---
adt7475-i2c-5-2e
Adapter: SMBus nForce2 adapter at 1c40
in0:         +0.03 V  (min =3D  +0.00 V, max =3D  +7.47 V)
in1:        +32.42 V  (min =3D  +0.00 V, max =3D +10.71 V)
fan1:          0 RPM  (min =3D    0 RPM)
fan2:          0 RPM  (min =3D    0 RPM)
fan3:          0 RPM  (min =3D    0 RPM)
fan4:          0 RPM  (min =3D    0 RPM)
temp1:       -64.0=B0C  (low  =3D  +1.0=B0C, high =3D +127.0=B0C)
temp2:       +39.5=B0C  (low  =3D  +1.0=B0C, high =3D +127.0=B0C)
temp3:       -64.0=B0C  (low  =3D  +1.0=B0C, high =3D +127.0=B0C)
---

so at least the temp2 value seems to be working.

This motherboard has two sensor chips: an ITE IT8716F and the ADT7475.
I suspect that the IT8716 is used as a monitor (read only) for fan
speeds, temperatures, and voltages, while the ADT7475 is actually
controlling the fan speeds.  Interestingly, the motherboard has four
chassis fan connectors, and the ADT7475 seems to have four fan control
channels.  I don't yet have any fans plugged into the chassis fan
connectors on the motherboard, so it could be that those channels
are working correctly and reporting the truth: there are no fans
plugged in.  (I do have a couple of spare fans I could plug in for
testing.)

One complication is that Analog Devices seems to have sold this line of
chips to ON Semiconductor, and ON doesn't yet have the data sheet for
the ADT7475 online.  I was able to get it from one of those data sheet
archives, and have posted it at
http://members.cox.net/~mroberds/adt7475-datasheet.pdf .

I'd like to get this driver fully working.  I can hack on it myself,
or test code that other people have hacked on.  What is the best way
to proceed?

Thanks!

Matt Roberds

--655872-352042579-1200948775=:32720
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--655872-352042579-1200948775=:32720--
