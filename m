From: Henrique de Moraes Holschuh <hmh@debian.org>
Date: Thu, 23 Jul 2009 18:10:41 +0000
Subject: Re: [lm-sensors] lm-sensors on IBM T42
Message-Id: <20090723181040.GA19369@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU0-SMTP81C7E5C9A311754F6D4AB2D0180@phx.gbl>
In-Reply-To: <BLU0-SMTP81C7E5C9A311754F6D4AB2D0180@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, 23 Jul 2009, Bruce Samhaber wrote:
> I have an IBM T42 and tried to install 'lm-sensors'=20
> But the detection routine did not find any 'I2C' devices.

Disable I2C in your laptop.  The sensors are not in the I2C buses Linux can
reach, AND you can brick the laptop if you screw with its I2C bus, so it is
best to not give anyone the opportunity to talk to the I2C bus on your T42.

Compile the kernel with the thinkpad-acpi driver, and then use a new enough
lm-sensors (v3.0.0 or later), it will read the sensors in your thinkpad.

> My machine is shutting down automatically when I run it at full clock rat=
e.=20

Unless you are in a VERY hot climate (say, 40=B0C), your machine has a
hardware defect and you need to have it repaired.  The two most likely
causes are:

1. Fan is going bad, or it is very dirty, or you are using some program to
make it run slower, which is always a very bad idea.

2. The thermal interface (aka thermal grease, thermal pad, thermal
coumpund...) between the heatsink and the CPU is cracked, and needs to be
replaced.

You want to ask more about this in one of the thinkpad forums, or on the
linux-thinkpad ML.  And check http://www.thinkwiki.org to educate yourself
about your laptop.

That said, Linux should be trying to avoid the CPU overheating, apparently
it isn't working very well... but even if it did, it would do so by dropping
performance to the floor, so you need to have the laptop repaired anyway.

Make sure to use a recent kernel version, 2.6.27.27 or newer.

> I would like to get lm-sensors working on this laptop.

Install thinkpad-acpi. And don't bother with any i2c drivers nor with
sensors-detect.  Sensor reporting for ThinkPads is fully automatic, and it
will report every sensor that is available in your thinkpad as long as the
correct driver (thinkpad-acpi) is loaded.

PS: If you haven't already, update your T42 firmware to the lastest
available.  Refer to BIOS upgrades in http://www.thinkwiki.org

--=20
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
