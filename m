From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 31 Jul 2007 13:06:54 +0000
Subject: Re: [lm-sensors] [PATCH] v3 of a adt7470 driver
Message-Id: <20070731130654.GA3747@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070711183825.GP3435@tree.beaverton.ibm.com>
In-Reply-To: <20070711183825.GP3435@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Darrick:

* Darrick J. Wong <djwong@us.ibm.com> [2007-07-30 11:11:39 -0700]:
> On Mon, Jul 30, 2007 at 12:11:22AM -0400, Mark M. Hoffman wrote:
> > > +	/* Register sysfs hooks */
> > > +	for (i = 0; i < ARRAY_SIZE(adt7470_attr); i++) {
> > > +		err = device_create_file(&client->dev,
> > > +					 &adt7470_attr[i].dev_attr);
> > > +		if (err)
> > > +			goto exit_remove;
> > > +	}
> > > +
> > 
> > Please just use sysfs_create_group() here, as seen in many other hwmon drivers.
> 
> I _removed_ the giant static array of struct attribute and the
> sysfs_create_group call at Mr. deGoede's suggestion:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020316.html
> 
> I'd rather not spend time on busy work re-adding all of that...

My bad.  I see you sent a patch for it anyway, so I'll leave it up to you.

> (I'll implement the rest of your suggestions and send out another
> patch.)

Could you please just respin a single patch to add the driver with all
cleanups, against v2.6.23-rc1?  What you've given me at this point is...

1) adt7470 v3 against v2.6.22

	(you must have done a merge up to v2.6.23-rc1 here)
		
2) cleanups against #1 + v2.6.23-rc1

3) etc.

I shouldn't have to reproduce that merge here.

I'm sorry if you feel like I'm being a PITA here... but it's not my primary
goal as a volunteer to optimize the use of your (employer's) time.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
