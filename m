From: "Marcelo Iturbe" <marcelo@tigabytes.com>
Date: Thu, 13 Sep 2007 16:26:28 +0000
Subject: [lm-sensors] Missing driver, coretemp and 2.6.15
Message-Id: <271366470709130926l3c4e1f97w2ff697eecc46cb41@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,
I am using Ubuntu kernel 2.6.15-29-server on an Intel D946GZTS motherboard

Running the latest sensors-detect as per instructions at
http://www.lm-sensors.org/wiki/iwiza...ensorsDetected

I get the following

#----cut here----
# I2C adapter drivers
modprobe i2c-i801
# Chip drivers
# no driver for Andigilog aSC7611 yet
# Warning: the required module coretemp is not currently installed
# on your system. For status of 2.6 kernel ports check
# http://www.lm-sensors.org/wiki/Devices. If driver is built
# into the kernel, or unavailable, comment out the following line.
modprobe coretemp
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----cut here----

Two things captured my atention:
1 - "no driver for Andigilog aSC7611 yet"
In the URL http://www.lm-sensors.org/wiki/Devices I found a link to a
patch to this driver
So I figured I would download the SVN version to apply the patch, but
then in the Download page it states:
  "Driver development for 2.6 kernels is taking place directly in the
kernel using GIT. Do not use the drivers from our SVN repository for
2.6 kernels, it will not work."

So what are my options to install this driver? How do I proceed?

2 - "Warning: the required module coretemp is not currently installed
on your system"
modprobe coretemp fails, indicating that the module does not exist.
Looking around in the forums I see that many people upgraded to 2.6.22
just to solve this.

Is there a way to solve this without changing the kernel?

I built a 2U server with this board and I need to keep an eye on the
CPU/MB to make sure the ventilation that I placed is enough.

Thanks

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
