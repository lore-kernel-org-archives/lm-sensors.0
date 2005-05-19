From: adrian@humboldt.co.uk (Adrian Cox)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: MPC107 I2C driver, interrupt driven
Message-Id: <1048614855.20101.405.camel@newt>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-embedded@lists.linuxppc.org
Cc: sensors@stimpy.netroedge.com

The second version of my driver for the I2C unit in Motorola's MPC107
bridge chip, plus the 824x integrated processors, is now available:

http://www.humboldt.co.uk/mpc10xi2c.html

The changes in this release are:
*) Now interrupt driven.
*) Faster startup.
*) Fixed bug in the stop condition (thanks to Timo Rossi).
*) Uses official adapter and algorithm numbers.

Once more, I welcome feedback on how it works for other people.

- Adrian Cox
http://www.humboldt.co.uk/

