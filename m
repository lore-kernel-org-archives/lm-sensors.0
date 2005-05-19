From: adrian@humboldt.co.uk (Adrian Cox)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: MPC10x I2C driver update
Message-Id: <1064915037.12438.1142.camel@newt>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Cc: lm78@Stimpy.netroedge.com

I have released a small update to my driver for the
MPC107/MPC8240/MPC8245 I2C adapter. This corrects a bug reported by
several people: the transfer function now follows the other I2C
algorithm drivers by returning the number of elements transferred.

http://www.humboldt.co.uk/mpc10xi2c.html

I'd like to get this into the kernel. Which would be more useful to
people:
1) Getting it into lm-sensors?
2) Getting it into linuxppc-2.4-devel?

- Adrian Cox
http://www.humboldt.co.uk/

