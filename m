From: tsawyer@sandburst.com (Travis B. Sawyer)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: lm_sensors:  PCA9549, MAX6653
Message-Id: <1079465318.4136.52.camel@pavement.sandburst.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings!

I'm working on an embedded linux project that includes use of the i2c
busses on a ppc440gx.

I've download/patched my kernel source with the I2C 2.8.4 and LM Sensors
2.8.5.

However, our project includes the use of several PCA9548 (8 port i2c
mux), and MAX6653 (fan controller & temp sensor)

I found the patch from Brian Kuschak for subordinate busses and patched
that in (with some hand patching).  I'm hoping that'll work for the
pca9548, but I don't have high hopes.

For the 6653 I plan on basing code on the 6650 driver that currently
exists.

Is this a feasible attempt?  Is someone already developing the drivers I
need?

Thanx for the 2 packages, some of the devices we're using are already
support, makes my life much easier!

-travis

-- 
Travis B. Sawyer
Sandburst Corporation  http://www.sandburst.com
(978) 689-1620

