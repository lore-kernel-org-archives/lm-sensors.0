From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: update to ticket 855
Message-Id: <3CCD84F7.67806E39@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.33.0204011057360.4335-100000@hypatia.phys.uwm.edu>
In-Reply-To: <Pine.LNX.4.33.0204011057360.4335-100000@hypatia.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

If i2cdump reports 00 but the adm1025 driver reports 65535 that
would suggest that the adm1025 driver _is_ the problem.

Kevin Flasch wrote:
> 
> > On Fri, 19 Apr 2002, Mark D. Studebaker wrote:
> >
> > > One thing you can do is use 'prog/dump/i2cdump 0 0x2d'
> > > to dump the registers of the chip.
> > > Look for either FF at the alarm registers at 0x41 and 0x42,
> > > or maybe all FF's.
> > > This will eliminate the adm1025 driver as the problem.
> >
> > I'm monitoring this on a machine now. When I have results, I will email you
> > them.
> 
> Hi. I have some results. I don't want to run i2cdump on the entire cluster of
> machines I have because of the warning it outputs. I have run it on one
> machine and got a few reults suggesting that the adm1025 driver is not the
> problem. When alarms hits 65535, i2cdump reports
> 
> 40: 01 00 00 5b 5b 5b 5b 07 5b 80 5b 5b 5b 5b 5b 5b
> 
> which is what it normally reports. I'll keep monitoring this and get more
> results.
> 
>  ----------------------------------------
>    Kevin James Flasch
>    http://www.uwm.edu/~kflasch/kflasch.gpg
