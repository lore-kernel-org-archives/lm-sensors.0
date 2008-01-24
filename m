From: Matt Roberds <mattroberds@cox.net>
Date: Thu, 24 Jan 2008 16:37:59 +0000
Subject: Re: [lm-sensors] adt7475 support (Asus M2N-SLI Deluxe)
Message-Id: <Pine.LNX.4.64.0801241029490.32185@birdbird.example.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="655872-1795066863-1201192265=:32185"
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0801211406570.32720@birdbird.example.com>
In-Reply-To: <Pine.LNX.4.64.0801211406570.32720@birdbird.example.com>
To: lm-sensors@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--655872-1795066863-1201192265=:32185
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.64.0801241031281.32185@birdbird.example.com>

On Tue, 22 Jan 2008, Jordan Crouse wrote:
> Revamped driver is attached.

I got it compiled, after changing I2C_DRIVERID_ADT74XX to
I2C_DRIVERID_ADT7475 in i2c-id.h .  Here are the results:

---
ADT7475-i2c-5-2e
Adapter: SMBus nForce2 adapter at 1c40
vccp:        +0.00 V  (min =3D  +0.00 V, max =3D  +2.99 V)   ALARM
vcc:         +3.24 V  (min =3D  +0.00 V, max =3D  +4.28 V)
fan1:          0 RPM  (min =3D    0 RPM)
fan2:          0 RPM  (min =3D    0 RPM)
fan3:          0 RPM  (min =3D    0 RPM)
fan4:          0 RPM  (min =3D    0 RPM)
remote1:       FAULT  (low  =3D -63.0=B0C, high =3D +191.0=B0C)  ALARM
local:       +40.2=B0C  (low  =3D -63.0=B0C, high =3D +191.0=B0C)
remote2:       FAULT  (low  =3D -63.0=B0C, high =3D +191.0=B0C)  ALARM
---

For reference, here is the output from Hans de Goede's work-in-progress
driver:

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

At first glance, Jordan's driver has probably more accurate names, a
more sensible value for vcc, and recognizes that remote[12] probably
aren't hooked up.

I think my next move will be to hook up some fans to the "chassis fan"
connectors on the motherboard and see if that makes the fan inputs
report anything.  I am guessing that the standard test for this is to
1) see if the driver reports any RPM at all when the fan is turning and
then 2) with the fan turning, put your thumb on the hub and make sure
the reported RPM goes down.  (I do have a function generator, but what
fun is that?)

Thanks!

Matt Roberds

--655872-1795066863-1201192265=:32185
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--655872-1795066863-1201192265=:32185--
