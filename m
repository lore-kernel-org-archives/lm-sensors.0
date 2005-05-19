From: bjanz@mac.com (Burt Janz)
Date: Thu, 19 May 2005 06:25:07 +0000
Subject: i2c multi-master mode
Message-Id: <200407300939.54751.bjanz@mac.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

I am in need of an MPC5200 I2C driver which operates in multi-master mode.  My 
immediate need is for the MPC5200, but I'll be happy with mods to the main 
I2C tree which allow me to use any supported device in multi-master mode...

..and, since I haven't found anything in the tree to do this, I am currently 
hacking *my own* changes into the Denx 2.4.25 I2C driver "kit".

I've spoken via email to Simon Vogl, who recommends that I use an ioctl-based 
command system to control my device.  Yes, this would work, but would be 
specific to the MPC5200... and I may have to support multimaster mode on the 
MPC8260/8270 in the future.

So, being a pedantic sort, I'm leaning towards changing "struct i2c_algorithm" 
and adding " int (*slave_xfer)" to be symmetrical with the "int 
(*master_xfer)" already in place.  I know this means that I'll be "changing 
the world", but I'm really only interested in my own needs right now :-) LOL

This change would required a retrofit to all of the current I2C drivers in the 
Denx kit (the base I'm working from).  The retrofit would be a NULL in each 
non-5200-based driver's i2c_algorithm initialization data to provide the 
"unsupported" placeholder for the new function.  This is a quickie change 
that I can roll into all of the drivers I'm not working on... but, like I 
said, I'm really only interested in *MY* driver... :-)

I also know that I'll need to add the underlying support for the slave_xfer 
code to all of the internal routines within the I2C kit so that interrupt 
handlers and other top-down function calls work properly.  This is something 
I'm quite willing to do... ...my driver... yada yada... :-)

Unless, of course, someone has already implemented multimaster mode handlers 
for the I2C kit so I can operate a master device in slave mode until it needs 
to do a transmit...

Thanks!!!

\but

--
Burt Janz
603.880.0482
bjanz@bit-net.com
www.ccsneinc.com/bjanz
