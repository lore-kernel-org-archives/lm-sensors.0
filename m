From: "Stephan Unger" <stephan@sunger.de>
Date: Thu, 05 Mar 2009 12:45:57 +0000
Subject: [lm-sensors] i2c_i801 module in kernel 2.4.33?
Message-Id: <A4EACE15D1B84EA49E6786D5CDA1F323@mephisto>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello List,

I'm trying to install / configure lm-sensors on my Debian Etch system with
kernel 2.4.33, but I have quiet a problem in setting it up correctly.

What I was able to achieve so far:
- enable and compile I2C Support into the kernel. The kernel starts and
loads the compiled-in module well:
(dmesg:) i2c-core.o: i2c core module version 2.6.1 (20010830)
- Modules i2c-dev and i2c-proc are being loaded as well without error
messages. These can be (un)loaded during runtime.

If I now run the Perl-Script "sensors-detect", I receive the following
error:
Sorry, no sensors were detected.
Either your sensors are not supported, or they are connected to an
I2C or SMBus adapter that is not supported. See doc/FAQ,
doc/lm_sensors-FAQ.html or http://www.lm-sensors.org/wiki/FAQ
(FAQ #4.24.3) for further information.
If you find out what chips are on your board, check
http://www.lm-sensors.org/wiki/Devices for driver status.

This probably happens because the script couldn't load the i2c_i801 module,
which I need for my mainboard.

Could you please tell me, whether there is any way to get this modul for
kernel 2.4.33 and if so, where do I get it? If it is a kernel patch, I can
apply it with:
cat lm-sensors-kernel-patch.diff | patch -p0 (or p1)
Correct?

Any help would be appreciated.
Greetings from rainy germany

Stephan



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
