From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 26 Apr 2007 11:37:58 +0000
Subject: Re: [lm-sensors] kernel/hwmon todo
Message-Id: <20070426133758.018e4501@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070415161302.GB3158@jupiter.solarsys.private>
In-Reply-To: <20070415161302.GB3158@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Tue, 24 Apr 2007 17:59:56 -0700, David Hubbard wrote:
> Hi Jean, Mark,
> 
> > > * David Hubbard <david.c.hubbard@gmail.com> [2007-04-15 16:05:39 -0600]:
> > > > Also, I think you missed the patch I submitted to get rid of i2c-isa
> > > > in the w83627ehf driver. It needs a review, and then can be submitted
> > > > to the kernel.
> > >
> > > Sorry, I still can't find this one.  Link please?  Or just resubmit it.
> >
> > http://lists.lm-sensors.org/pipermail/lm-sensors/2007-March/019363.html
> >
> > I'd like to see this patch applied quickly so that it makes it into
> > 2.6.22. As Rudolf seems to be busy these days, I'll review it myself
> > later today.
> 
> What is the close date for patches to make it into 2.6.22? Jean points
> out some good areas for me to change and I'll need until Saturday to
> get them tested.

The close date was "the day Linus releases 2.6.21", which happens to be
today. So the w83627ehf driver conversion won't make it into 2.6.22.
This doesn't really matter anyway, as there are 5 other i2c-isa-based
drivers which are not converted yet, so I can't kill i2c-isa before
2.6.23.

So please rework the w83627ehf patch according to my comments as your
time permits, resubmit it, it'll go to -mm early and will get some
testing there before 2.6.23.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
