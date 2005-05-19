From: adrian@humboldt.co.uk (Adrian Cox)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: MPC107 I2C driver
Message-Id: <1044359381.19358.44.camel@newt>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-embedded@lists.linuxppc.org
Cc: sensors@stimpy.netroedge.com

The first version of my driver for the I2C unit in Motorola's MPC107
bridge chip, plus the 824x integrated processors, is released:

http://www.humboldt.co.uk/mpc10xi2c.html

I'd like to know if it works for other people. I've so far tested it
with a pair of LM75 sensors attached to an MPC107 bridge.

I've used an obvious dummy ID number for the I2C interface: I'd like to
get a real one and move the code into the kernel once I have more
results.

- Adrian Cox
http://www.humboldt.co.uk/

