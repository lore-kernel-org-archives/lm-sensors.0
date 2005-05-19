From: leif.lindholm@i3micro.com (Leif Lindholm)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: I2C slave mode for Linux host
Message-Id: <1094205518.28654.27.camel@fortress>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi

I was directed here from the irc channel - please cc any replies to me
as I'm not subscribed to the list.

I'm implementing slave mode transfers (well, just reads for now) on an
embedded board, and noticed there wasn't really any support in the
subsystem for this (other than two unused function pointers in a struct
in linux/i2c.h.

For now the code is mostly located in the algo driver, but I was
wondering if you had any design thoughts for integrating it into the
core/dev files?

As far as I can see, the modifications required would be:
* a flag in the adapter struct indicating master/slave mode
* ioctl in i2c_control for setting master/slave mode (with function
  pointer - or should this be all in the algo driver?)
* hooks in i2cdev_read/write() for distinguishing between modes
* putting read/write buffers in the adapter struct

Thoughts?

regards
	/
		Leif
