From: virusmaster@qip-net.de (Thomas Gruber)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: problem with 2.6?
Message-Id: <Pine.LNX.4.56.0307152345480.29705@draco.qip-net.lan>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi people of lm-sensors (what a start) =)

3 days ago i compiled the 2.6.0-test1 kernel on my system (which runs very
smoothly, i must say) however: if i try to compile lm-sensors, all fails.

In README you tell to use the lm-sensors drivers inside the kernel...
well, they are compiled, insmod'ed and i see the i2c devices in /dev/i2c
(devfs) but here is the problem itself:

i installed lm-sensors of the debian distrib which delivers me sensors and
detect-sensors. when i run detect-sensors, all runs fine till a point,
when it tries to open /proc/bus/i2c/chips or /proc/sys/dev/i2c..... these
two thingies dont exist... quite logical, since i2c-proc doesnt exist
anymore since kernel 2.5.6X ...

now my question: how do i get it running? =)

MFG
Thomas Gruber
