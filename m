From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 24 Sep 2012 12:08:40 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: Versatile Express hwmon driver
Message-Id: <20120924140840.70ddbbd7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1348246591-2409-1-git-send-email-mail@pawelmoll.com>
 <20120921181844.GA20763@roeck-us.net>
 <1348488182.2530.13.camel@hornet>
In-Reply-To: <1348488182.2530.13.camel@hornet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, 24 Sep 2012 13:03:02 +0100, Pawel Moll wrote:
> On Fri, 2012-09-21 at 19:18 +0100, Guenter Roeck wrote:
> > On Fri, Sep 21, 2012 at 05:56:31PM +0100, Pawel Moll wrote:
> > > +
> > > +	err = sysfs_create_group(&pdev->dev.kobj, match->data);
> > > +	if (err)
> > > +		goto error;
> > 
> > You'll need a second label for that. Since the group was not created, you can
> > not delete it.
> 
> Actually I think I can... The sysfs_remove_group() effectively is a
> wrapper for sysfs_hash_and_remove() which acts like "rm -f" - does
> nothing if the file doesn't exist. Even drivers/hwmon/lm83.c (which, by
> pure coincidence, I was looking at when re-working this driver) does
> that in exit_remove_files...

You are right, and many hwmon drivers do exactly that, to limit the
number of labels. This is code which isn't executed when all is fine,
so we don't care about performance. Plus, in many cases the file
removals are unconditional in the remove function anyway.

> Anyway, it's nothing to argue about, so I'll change it and send
> (hopefully ;-) final version in a jiffy.

You can keep the code as is too, if you prefer.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
