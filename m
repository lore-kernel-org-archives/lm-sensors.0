From: dcb@pa.net (Douglas Bollinger)
Date: Sat, 25 Mar 2006 23:45:52 +0000
Subject: [lm-sensors] Kernel module load order can kill sensors
Message-Id: <20060325184552.d1df0abf.dcb@pa.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

At first I joined this list to ask for help because I couldn't get the sensors
working with my board.  Luckily I solved the problem on my own but thought you
guys might be interested in what was the cause of the conflict.

Kernel: 2.6.14-ck9n
Sensors: 2.10.0
Board: Tyan K8E S2865

Since Tyan supplies a sensor.conf for this board, I thought getting sensors
running would be a breeze.  After following their instructions, I found that I
got no sensor output at all with "sensors" reporting a missing filesystem or
something.

I use a old brooktree video capture board with this board.  What I found was
that if I rmmod all bttv stuff I could then successfully get sensors to work.

The ultimate solution was to load the sensor kernel modules before bttv and
then everything worked together.  I'm using Gentoo, so in
/etc/modules.autoload.d/kernel-2.6:

usbcore
i2c-nforce2
lm85 force_emc6d100=0,0x2e
ide-cd
nls_utf8
loop
bttv

This module-loading order works well.  Originally bttv was before the
i2c-nforce2 and lm85 modules and that was causing all the problems.

Thanks for all the work in getting hardware sensors working in Linux!

-- 
: is not an identifier

