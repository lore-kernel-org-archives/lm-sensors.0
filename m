From: jbloom@acopia.com (Jeff Bloom)
Date: Thu, 02 Jun 2005 15:22:54 +0000
Subject: [lm-sensors] lmsensors 2.9.0 LM93 driver problems - PC87431
Message-Id: <02023CF4A21F4B479744D6203451DD7731F4BE@EMAIL3.acopianet.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks Mark.
I finally got the system going with help from Todd Davis.  There were
some patches (in kernel ver 2.4) around which support communication to a
PC87431 via smbus to the sensor chip.  So although I had an lm93 it is
not hanging off of an i2c but an smbus configuration...sheesh.
Using a ipmi_smb_intf driver did the trick.
The patches were found at the following:
http://sourceforge.net/project/showfiles.php?group_id6127&package_id=6
3819
or follow the Linux 2.4 Driver link at
http://sourceforge.net/projects/openipmi/

I hope this helps others if they have an Intel server board SE7320VP2 or
a system which contain a PC87431 mBMC on smbus.
Thanks for all who helped in solving this issue.
-JB


-----Original Message-----
From: Mark M. Hoffman [mailto:mhoffman@lightlink.com] 
Sent: Thursday, June 02, 2005 12:16 AM
To: Jeff Bloom
Cc: lm-sensors
Subject: Re: [lm-sensors] lmsensors 2.9.0 LM93 driver problems


Hi Jeff:

* Jeff Bloom <jbloom@acopia.com> [2005-05-26 01:26:04 -0400]:
> Thank you for your response.
> Here is the info you were asking for:
> SWITCH:/usr/local/bin# ./sensors -v
> sensors version 2.9.0 with libsensors version 2.9.0
> 
> WITCH:/usr/local/bin# ./i2cdetect 0
> WARNING! This program can confuse your I2C bus, cause data loss and 
> worse! I will probe file /dev/i2c-0. I will probe address range 
> 0x03-0x77. Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          XX XX XX XX XX XX XX XX XX XX XX XX XX 
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
> 30: XX XX 32 XX XX XX 36 XX XX XX XX XX XX XX XX XX 
> 40: XX XX 42 XX XX XX XX XX XX XX XX XX XX XX XX XX 
> 50: XX XX 52 XX XX XX 56 XX XX XX XX XX XX XX XX XX 
> 60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX 6e XX 
> 70: XX XX XX XX XX XX XX XX                         
> 
> So if I read the above output correctly no devices are found n 
> 0x2c-0x2e.

Correct.

> Since this is a new board being offered by Intel I'll have to do some 
> further investigation.  I'm new to the lmsensors but have driver 
> experience so It's likely I'll be fixing the driver.
> If it's segmented is it your expectation that it will be a change to
> i801 only or modification to lm93 as well?

It shouldn't require any modification to lm93.  There is no general
support for segmented busses in the I2C core.  However, an example of
how to handle it is drivers/i2c/busses/i2c-amd756-s4882.c in any recent
2.6.x.

> -----Original Message-----
> From:	Mark M. Hoffman [mailto:mhoffman@lightlink.com]
> Sent:	Wed 5/25/2005 11:08 PM
> To:	Jeff Bloom
> Cc:	lm-sensors@lm-sensors.org
> Subject:	Re: [lm-sensors] lmsensors 2.9.0 LM93 driver problems
> Hi Jeff:
> 
> Comments in-line...
> 
> * Jeff Bloom <jbloom@acopia.com> [2005-05-24 20:31:48 -0400]:
> > Sorry to bother you on this issue but I can't seem to get 
> > sensors-detect to scan the lm93 on a new Intel platform. I am 
> > running the following:
> >     - kernel version 2.4.26
> >     - Patched above kernel with 2.9.0 i2c-patch where i2c-dev is 
> > built into the kernel.
> >     - Compiled lmsensor-2.9.0 package.
> >     - Volcano Intel box (SE7320VP2) with an LM93 chipset from 
> > National Semiconductor.
> >  
> > I verified the chip does exist on the motherboard as well.
> >  
> > So I have used this same package on an HP box to bring up bmcsensors

> > and i2c-ipmi without issue.
> >  
> > The only devices found were the eeprom and i2c-i801.
> >  
> > Any idea what I need to try next?
> > I can upgrade to 2.9.1 lmsensors and the i2c patch but didn't see 
> > any reason yet why I should.
> 
> First of all, make sure that the userspace tools (like sensors-detect)

> are indeed 2.9.0 by running "sensors -v".  Sometimes the default 
> distro packages get in the way of an install from source.
> 
> > I appreciate any help you can provide.  Thanks.
> >  
> > -Jeff Bloom
> >  
> >  
> > Below is the sensors-detect output:(notice it doesn't even scan for 
> > the lm93 at all)
> 
> Well, it does a more generic scan first, which will indicate if any 
> chips at all live on certain addresses.  You can perform this type of 
> scan manually by doing this as root:
> 
> 	#/usr/local/bin/i2cdetect 0
> 
> It does something analogous to a ping of each I2C/SMBus address where 
> a client chip might live.  The LM93 can only live at three of those...

> 0x2c-0x2e.  So the reason you don't see sensors-detect scanning for 
> the LM93 specifically is because the earlier generic scan found 
> nothing at those three addresses.
> 
> It is possible that the SMBus on your mainboard is segmented - so 
> there must be some way to switch bus segments so that the i801 SMBus 
> controller can find and talk to the LM93.  If that's the case, you 
> would have to ask Intel for information about how to switch bus 
> segments, and then write (or have written) a special driver to handle 
> that.
> 
> PS: ACK that I got an email from you in private which had mostly the 
> same info.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

