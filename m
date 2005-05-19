From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: i2c multi-master mode
Message-Id: <20040804015614.GA2843@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <200407300939.54751.bjanz@mac.com>
In-Reply-To: <200407300939.54751.bjanz@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Burt:

* Burt Janz <bjanz@mac.com> [2004-07-30 09:39:54 -0400]:
> I am in need of an MPC5200 I2C driver which operates in multi-master mode.  My 
> immediate need is for the MPC5200, but I'll be happy with mods to the main 
> I2C tree which allow me to use any supported device in multi-master mode...
> 
> ..and, since I haven't found anything in the tree to do this, I am currently 
> hacking *my own* changes into the Denx 2.4.25 I2C driver "kit".
> 
> I've spoken via email to Simon Vogl, who recommends that I use an ioctl-based 
> command system to control my device.  Yes, this would work, but would be 
> specific to the MPC5200... and I may have to support multimaster mode on the 
> MPC8260/8270 in the future.
> 
> So, being a pedantic sort, I'm leaning towards changing "struct i2c_algorithm" 
> and adding " int (*slave_xfer)" to be symmetrical with the "int 
> (*master_xfer)" already in place.  I know this means that I'll be "changing 
> the world", but I'm really only interested in my own needs right now :-) LOL

First of all, you are confusing some terms.  I2C is a multi-master
bus, period.  There is no such multi-master "mode".  All of our i2c
host adapter drivers should operate properly on a bus with other
masters - if not that's a bug.

I think you just want to add slave support to i2c host adapters. 

On page 7 of the Philips I2C bus specification (V2.1) [1] there is
a table of terms, a diagram, and some text that will make this clear.  It
is required reading especially for pedants. :)

> This change would required a retrofit to all of the current I2C drivers in the 
> Denx kit (the base I'm working from).  The retrofit would be a NULL in each 
> non-5200-based driver's i2c_algorithm initialization data to provide the 
> "unsupported" placeholder for the new function.  This is a quickie change 
> that I can roll into all of the drivers I'm not working on... but, like I 
> said, I'm really only interested in *MY* driver... :-)

It's the first I've heard of the Denx kit.  What is *it* based on?  What
we have in CVS is somewhat different from what's in official 2.4, and
they're not likely to ever get back in sync.

Have you seen our CVS?  There are already *slave_send and *slave_recv
place-holders.  Not in use, AFAIK; also not sure why not *slave_xfer
as you mention.

> I also know that I'll need to add the underlying support for the slave_xfer 
> code to all of the internal routines within the I2C kit so that interrupt 
> handlers and other top-down function calls work properly.  This is something 
> I'm quite willing to do... ...my driver... yada yada... :-)
> 
> Unless, of course, someone has already implemented multimaster mode handlers 
> for the I2C kit so I can operate a master device in slave mode until it needs 
> to do a transmit...

Again with the terminology.  :)  I think you're asking if someone has
implemented host adapter slave support...  well, it's in the i2c package
TODO list for a long time now.  If you're adding support for kernel 2.4,
you'll probably be maintaining it yourself - we're not inclined to accept
new features, and Marcelo is definitely not accepting patches for I2C.

However, development continues on kernel 2.6.  If you come up with something
good for 2.4, maybe someone here could port it to 2.6.  I.e. whatever you
come up with, we'd like to see it... good luck.

[1] http://www.semiconductors.philips.com/buses/i2c/

-- 
Mark M. Hoffman
mhoffman@lightlink.com
