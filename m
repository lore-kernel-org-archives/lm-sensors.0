From: jonsmirl@yahoo.com (Jon Smirl)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: I2C on 2.6
Message-Id: <20040206032153.63685.qmail@web14917.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On kernel 2.6 I2C creates /sys/class/i2c-adapter. This directory contains all of
my I2C busses. Now when I modprobe i2c-dev in it makes /sys/class/i2c-dev which
also contains all of my I2C buses with the addition of a 'dev' file. Udev then
picks up on this 'dev' file and makes the devices. Do we really need two I2C
/sys/class entries? Could these be combined?

==Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! Finance: Get your refund fast by filing online.
http://taxes.yahoo.com/filing.html
