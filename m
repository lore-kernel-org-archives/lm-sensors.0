From: jonsmirl@yahoo.com (Jon Smirl)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: I2C DDC display
Message-Id: <20040228191744.46400.qmail@web14911.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040228001023.4653.qmail@web14901.mail.yahoo.com>
In-Reply-To: <20040228001023.4653.qmail@web14901.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

benh and I have been talking about moving all of the EDID processing and mode
computations up into user space. This is about 100K of code that is used in
frequently and really has no need to be in a device driver.  After the mode is
computed the appropriate register values are passed in to the video driver. None
of the user space code touches registers directly. The new klibc and initramfs
support allow the mode to be set from userspace very early in the boot process
via a hotplug event when the adapter is first detected.

It would be preferable if the user space code for retrieving EDID was the same
for all cards. One way to achive this is for the cards to implement I2C bus
drivers and then we have a univeral DDC chip implementation. For example right
now if you load benh's radeon driver the standard i2c eeprom chip module will
pick up the EDID. Waking up the DDC chip is a monitor issue so all video cards
will need to deal with it. That why I wanted to fix it in the chip driver
instead of implementing it in each video driver.

Finally, after we get a working version of an EDID driver, it would probably be
best to go back and rework the eeprom driver to load decoder functions instead
of having different drivers for each chip type. Right now there would be three
implementations: EDID, RAM, generic. 

The user space code will use the eeprom image and decode the edid itself, but I
need the wake-up DDC code in the kernel. The decoder functions will just be for
optional fun so that the user can directly view the EDID or RAM contents.


==Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Get better spam protection with Yahoo! Mail.
http://antispam.yahoo.com/tools
