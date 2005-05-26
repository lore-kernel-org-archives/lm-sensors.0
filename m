From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 26 May 2005 05:09:04 +0000
Subject: [lm-sensors] lmsensors 2.9.0 LM93 driver problems
Message-Id: <20050526030817.GA18994@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <02023CF4A21F4B479744D6203451DD7731F23B@EMAIL3.acopianet.com>
In-Reply-To: <02023CF4A21F4B479744D6203451DD7731F23B@EMAIL3.acopianet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jeff:

Comments in-line...

* Jeff Bloom <jbloom@acopia.com> [2005-05-24 20:31:48 -0400]:
> Sorry to bother you on this issue but I can't seem to get sensors-detect
> to scan the lm93 on a new Intel platform.
> I am running the following:
>     - kernel version 2.4.26
>     - Patched above kernel with 2.9.0 i2c-patch where i2c-dev is built
> into the kernel.
>     - Compiled lmsensor-2.9.0 package.
>     - Volcano Intel box (SE7320VP2) with an LM93 chipset from National
> Semiconductor.
>  
> I verified the chip does exist on the motherboard as well.
>  
> So I have used this same package on an HP box to bring up bmcsensors and
> i2c-ipmi without issue.
>  
> The only devices found were the eeprom and i2c-i801.
>  
> Any idea what I need to try next?
> I can upgrade to 2.9.1 lmsensors and the i2c patch but didn't see any
> reason yet why I should.

First of all, make sure that the userspace tools (like sensors-detect) are
indeed 2.9.0 by running "sensors -v".  Sometimes the default distro packages
get in the way of an install from source.

> I appreciate any help you can provide.  Thanks.
>  
> -Jeff Bloom
>  
>  
> Below is the sensors-detect output:(notice it doesn't even scan for the
> lm93 at all)

Well, it does a more generic scan first, which will indicate if any chips
at all live on certain addresses.  You can perform this type of scan manually
by doing this as root:

	#/usr/local/bin/i2cdetect 0

It does something analogous to a ping of each I2C/SMBus address where a client
chip might live.  The LM93 can only live at three of those... 0x2c-0x2e.  So
the reason you don't see sensors-detect scanning for the LM93 specifically is
because the earlier generic scan found nothing at those three addresses.

It is possible that the SMBus on your mainboard is segmented - so there must
be some way to switch bus segments so that the i801 SMBus controller can find
and talk to the LM93.  If that's the case, you would have to ask Intel for
information about how to switch bus segments, and then write (or have written)
a special driver to handle that.

PS: ACK that I got an email from you in private which had mostly the same info.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

