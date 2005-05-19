From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: adm1026 driver port for kernel 2.6.X - [REVISED DRIVER]
Message-Id: <NN38qQl1.1099468908.1237810.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20041102221745.GB18020@penguincomputing.com>
References: <20041102164642.GA16378@penguincomputing.com>
In-Reply-To: <20041102164642.GA16378@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jthiessen@penguincomputing.com, sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>


Hi Justin,

> > Granted it's not part of the standard yet, but you would have three
> > files temp[1-3]_crit_enable if we stick to our chip-indenpendent
> > interface logic. Either make 1 read-write and [2-3] read-only, or make
> > all read-write and each one changes the three values.
>
> Any reason not to simply provide 3 sysfs files pointing at the same
> variable/register bit?  Maintaining separate variables for a single,
> uncomplicated value seems rather overkill.

That's pretty much what I was proposing, actually ;) I never meant three
different variables. The discussion was about having all files
read-write or not. I usually have only the first file read-write and
others read-only mirrors thereof, but sometimes people don't like that
arbitrary symmetry breakage and go for read-write mirrors. You choose.

> (...)
> I would agree that it is a bit confusing that there are essentially 2
> temperature-motivated mechanisms for forcing fan speeds to full (automatic
> PWM fan control, and critical temperature monitoring), but I think that the
> utility of providing a critical temperature fail-safe is worth the
> minor amount of confusion.

Agreed.

> No problem.  Sorry that it's taking so much revision to get the kinks
> worked out.  This will undoubtedly become less trouble as I get more
> familiar with i2c/lm_sensors/kernel issues.

Well, the adm1026 driver is a complex driver which never received testing
and reviewing so far, because it is so rarely found on motherboards.
It's perfectly normal that it takes a couple revisions and discussion
to get it in good shape. Thanks for the good work so far.

--
Jean Delvare
