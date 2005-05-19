From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: [PATCH] More i2c driver changes for 2.5.66
Message-Id: <20030403164556.GB4473@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1048295086481@kroah.com>
In-Reply-To: <1048295086481@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Apr 03, 2003 at 08:42:50AM -0500, Albert Cranford wrote:
> Linux kenel mail list removed on purpose.

Why?

> Whoa!  I just saw the patches submitted to linux kernel
> and not to sensors list.  Come on Greg this is not proper.

All of these patches, with the lone exception of the renaming i2c-proc.c
to i2c-sensor.c and the removal of the unused proc functions were posted
to both the sensors and linux kernel mailing lists in the past.  I and
others said that it would be good to rename the file, as it doesn't make
any sense anymore.

And I just posted a question asking if that lone function that is now in
i2c-sensors.c is even needed anymore.

Or do you mean that this series of patches specifically were not sent to
the sensors list?  They were, it looks like the sensors list dropped
them for somereason.  Look at the email header of the messages on lkml
for proof of that.

> Whats this config item CONFIG_SENSOR ?

It's CONFIG_I2C_SENSOR which replaces I2C_PROC.  It's used to determine
if we need to build i2c-sensor.o or not.

> This is the wrong way to register sensors to sysfs.

Why?  What did I do different that was wrong, or not previously posted
to this list?

> New sensors can never be tested before included in the kernel
> with this philosophy.

Yes they can, just like I tested, and others are currently testing.  I
am getting patches for this conversion :)

> Whats wrong with the opposite philosophy of creating
> a sysfs interface and in the sensor driver just make
> the sysfs call?

The callbacks do not match up at all from the "old" proc file interface
with the sysfs interface.  And we moved to one value per file.  Both of
those changes would have been very cludgy to fit into the current api,
so they were changed.  This was shown in the many patches on this list
before I sent my changes off to Linus.

I don't want to be seen as breaking things without a good reason.  These
are good changes.  They reduced the amount of kernel code, and have
moved the i2c chips into the sysfs heirachy, which will allow them to be
seen by userspace tools that get entire system information (people are
currently working on libsysfs to make userspace interaction with the
sysfs tree simpler, although find and cat and echo work good for me :)

thanks,

greg k-h
