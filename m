From: mrenzmann@otaku42.de (mrenzmann@otaku42.de)
Date: Wed, 21 Dec 2005 21:45:53 +0000
Subject: [lm-sensors] RFC: Backport of lm77.c to kernel 2.4.x
Message-Id: <1715.84.58.133.46.1135201553.squirrel@webmail.otaku42.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all.

As mentioned before I've been working on backporting lm77.c to 2.4.x. I
still have some minor adjustments on my to-do list for it, but it's
already working for me.

Since this is my first i2c-related work and I already did some... well,
let's call it "suboptimal" things during the last days in this regard, I'd
like to ask for a review of the result. Any feedback and suggestion is
welcome, but answers might take some days (I'll be offline until next
Tuesday, Dec 27th).

The driver is available via Subversion at
http://projects.otaku42.de/svn/lm77/trunk but you can also view the source
with your browser at http://projects.otaku42.de/viewcvs/lm77/trunk/ .

If you want to compile the driver, copy lm77.[ch] to the kernel/chips
subdirectory of your local lm_sensors-2.9.2 copy. Then edit
kernel/chips/Module.mk and add the line:

KERNELCHIPSTARGETS += $(MODULE_DIR)/lm77.o

right after

KERNELCHIPSTARGETS += $(MODULE_DIR)/smbus-arp.o

Now (re)compile as usual.

Thanks in advance, and merry christmas!

Bye, Mike


