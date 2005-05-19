From: lfcorreia@lfcorreia.dyndns.org (Luis Correia)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: Accessing i2c subsystem from within a kernel module
Message-Id: <414B7664.9000006@lfcorreia.dyndns.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

This question may or may not be related to lm_sensors, but you guys
are the I2C master around here.

I have a small embedded hardware (PcEngines) that I whish to include
a LCD display to use with lcd4linux.

For that I'm adapting a ppdev emulator driver, but now I need to know
if I can (and how) access the /dev/i2c-* interface from within a
kernel driver itself.

This is probably a very dumb question....


Thanks!

Luis Correia
Bering-uClibc Team Member
