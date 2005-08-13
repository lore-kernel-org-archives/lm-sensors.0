From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Sat, 13 Aug 2005 04:28:41 +0000
Subject: [lm-sensors] I2C block reads with i2c-viapro: testers wanted
Message-Id: <20050813022824.GA21485@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050809231328.0726537b.khali@linux-fr.org>
In-Reply-To: <20050809231328.0726537b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

CC's trimmed...

* Jean Delvare <khali@linux-fr.org> [2005-08-12 08:02:10 +0200]:
> > > My experimental patch follows. I have enabled the I2C block read
> > > function for all VIA south bridges, so that it can be tested on all
> > > chips. I'll restrict that after the test phase, of course.
> > 
> > I fired it up on one of the older chipsets...
> > 
> > # lspci
> > (...)
> > 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South] (rev 23)
> > (...)
> > 00:07.3 Host bridge: VIA Technologies, Inc. VT82C596 Power Management (rev 30)
> 
> Oh, you do have one of these old 596 chips. Interesting. Could you

Heh, you noticed.  I wasn't holding back any info, I just picked up another
couple older boards recently. ;)

> possibly take a look at the i2c-viapro driver and comment on that part:
> 
> 	if ((pci_read_config_word(pdev, id->driver_data, &vt596_smba)) ||
> 	    !(vt596_smba & 0x1)) {
> 		/* try 2nd address and config reg. for 596 */
> 		if (id->device = PCI_DEVICE_ID_VIA_82C596_3 &&
> 		    !pci_read_config_word(pdev, SMBBA2, &vt596_smba) &&
> 		    (vt596_smba & 0x1)) {
> 			smb_cf_hstcfg = 0x84;
> 
> It looks like a hack to me, and I was wondering if we could clean it up
> (possibly by using pci quirks). I've not studied the problem in details
> yet, but comments and help would be welcome, and the fact that you do
> have a chip for testing will help anyway :)

I'm not sure what you don't like about it.  I can't see what a PCI quirk
would have to do with it, either.

[...]

> Oh well, even if we were using interrupts instead of polling, the block
> transactions are still better as they are still twice as fast, would
> generate less interrupts, and are generally less CPU-intensive. That
> being said, I plan to implement interrupts in i2c-viapro at a later
> time. I have no idea how to do that, but I'll take a look at what you
> did in your i2c-i801 reimplementation, it should help. I simply seem to
> remember that you expected problems for block transactions in interrupt
> more, and don't know why exactly.

It's just that I had no good way to test it.  I thought I had a client
that would accept the (SMBus) block read commands, but it just wasn't
reliable (even with the old driver).  Worse, it would lock up the bus
so hard that I had to power cycle.

So, I gave up on that for lack of a better way to test it.

> Maybe we can use interrupts for short commands and polling for big
> transactions. I see no technical problem doing that - although this
> would make the driver larger and more complex.

Sure it's possible.  Maybe I should do that with i2c-i801.

> BTW, it would be great if you could finalize your i2c-i801
> reimplementation so that we can add it to Linux 2.6. I remember it gave
> me much better performance than the original one, and the code was
> looking much nicer as well.

Yeah, it would be nice if I had the time (and some better equipment).

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

