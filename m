From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Fri, 12 Aug 2005 03:08:18 +0000
Subject: [lm-sensors] I2C block reads with i2c-viapro: testers wanted
Message-Id: <20050812010759.GA11361@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050809231328.0726537b.khali@linux-fr.org>
In-Reply-To: <20050809231328.0726537b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2005-08-09 23:13:28 +0200]:
> I am implementing I2C block reads in the i2c-viapro driver, and am
> looking for testers. I was able to test on my own VT8237R chip, it works
> OK, now I'd need to know how it works on older VIA south bridges, namely
> the VT8235 and the VT82C686B. South bridges before that (VT82C686A,
> VT8233A and older) are supposed not to work according to the datasheets,
> but a confirmation would be welcome, who knows, it might simply not be
> documented.
> 
> My experimental patch follows. I have enabled the I2C block read
> function for all VIA south bridges, so that it can be tested on all
> chips. I'll restrict that after the test phase, of course.

I fired it up on one of the older chipsets...

# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South] (rev 23)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 10)
00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 11)
00:07.3 Host bridge: VIA Technologies, Inc. VT82C596 Power Management (rev 30)

# lspci -n
00:00.0 Class 0600: 1106:0691 (rev c4)
00:01.0 Class 0604: 1106:8598
00:07.0 Class 0601: 1106:0596 (rev 23)
00:07.1 Class 0101: 1106:0571 (rev 10)
00:07.2 Class 0c03: 1106:3038 (rev 11)
00:07.3 Class 0600: 1106:3050 (rev 30)

As you suspected, it didn't work.

# i2cdump -y 0 0x50 i
Error: Block read failed, return code 0

> On my system, the dump is down from over 2 seconds without the patch to
> below 0.2 second with the patch, which proves how efficient I2C block
> reads are and explains why I want to implement this function.

I also found something interesting, by accident.  With a stock FC4 kernel,
the i2cdump clocked at 1.02s total.  With 2.6.13-rc6, it took 5.11s!  The
only relevant difference that I can see is that the FC4 kernel uses HZ of
1000 while my 2.6.13-rc6 kernel uses 100.  Because the i2c-viapro is a
polling driver, it becomes slower as HZ decreases.

I.e. the improvement you are seeing with byte vs. block xfers is quite
exaggerated because we poll the device relatively infrequently.  *All*
the xfers are slower than they could be w/ a non-polling driver.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

