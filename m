From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 17 Jan 2011 20:39:32 +0000
Subject: Re: [lm-sensors] driver for emc1023
Message-Id: <1295296772.9786.208.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D34960C.8070303@gmail.com>
In-Reply-To: <4D34960C.8070303@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2011-01-17 at 14:18 -0500, Anish Patel wrote:
> here is the driver for the emc1023 and the makefile patch.
> i've spent a couple hours now trying to figure out how to create a patch 
> for a new file, and can't find anything.
> if someone would care to point me in the right direction i'll resubmit, 
> but at this point i am tired of trying to figure this out.
> Doc/SubmittingDrivers and SubmittingPatches is no help on how to do this.
> 
Nowadays, pretty much everyone uses git.

Clone a new kernel tree from
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git.

Make your changes. Commit locally into your git repository. If
necessary, use "git rebase -i" to merge multiple commits into one when
you are ready to submit the driver.

Generate a patch file, for example for the most recent commit, with "git
format-patch -s HEAD~1".

As for the driver itself, please run it through scripts/checkpatch.pl
and fix all reported errors and warnings. You can use scripts/cleanfile
to fix some of the problems.

Couple of additional comments. This is not a complete review - I'll look
at the code in more detail after the coding style errors are fixed.

You don't need to enumerate different chip IDs. From a driver (and user)
perspective, it is irrelevant if the chip variant is -1, -2, -3, or -4.
So you are adding a lot of complexity for very little gain. It might
make sense, though, to support other chips of the same family (1023,
1043, 1053, 1063) if there is no difference in register access. For
that, it would make sense to have separate entries in i2c_device_id, but
you still won't need to keep ->kind around unless programming is
different for any of the chips supported. Such as:

static const struct i2c_device_id emc1023_id[] = {
        { "emc1023", 0 },
        { "emc1043", 0 },
        { "emc1053", 0 },
        { "emc1063", 0 },
        { }
};

Then identify the actual chip in emc1023_detect based on the Product ID
and assign above names as detected.

In this context, we'll have to sort out the product ID issues, since
0x0c and 0x0d point to emc1043, not to emc1023.

Please use sysfs_create_group()/sysfs_remove_group() to register and
remove sysfs hooks. 

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
