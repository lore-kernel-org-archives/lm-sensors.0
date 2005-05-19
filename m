From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: i want to help
Message-Id: <Pine.LNX.3.96.1030626122616.7803A-100000@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.VMS.3.91-2 (vms).1030217122257.20709A-100000@cs.felk.cvut.cz>
In-Reply-To: <Pine.VMS.3.91-2 (vms).1030217122257.20709A-100000@cs.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Ok that name will be w83784.c 

Unforunatelly I dont have PWM pins connected to fans. (yet haha)
I will implement what I can.

Rudolf

On Thu, 26 Jun 2003, Mark M. Hoffman wrote:

> * Philip Pokorny <ppokorny@penguincomputing.com> [2003-06-25 19:33:25 -0700]:
> > Is it another variant of the 83781?
> 
> Looks that way... datasheets are here: 
> 
> http://www.winbond.com/e-winbondhtm/partner/b_2_d_4.htm
> 
> And I agree with earlier sentiments on the list that no more chip
> variants should be added to w83781d.  Rudolf, I suggest w83784.c
> because (according to the datasheet) the 785 is a cut down 784;
> that might be added later.
> 
> > :v)
> > 
> > Mark M. Hoffman wrote:
> > 
> > >Hi Rudolf:
> > >
> > >* Rudolf Marek <R.Marek@sh.cvut.cz> [2003-06-19 16:43:00 +0200]:
> > >
> > >
> > >>I have W83L785R on my MB and I'm willing to write a driver.
> > >>Is this "job" still free ?
> > >>
> > >
> > >I think so, according to this page:
> > >
> > >http://secure.netroedge.com/~lm78/newdrivers.html
> > >
> > >To get started, use this checklist:
> > >
> > >http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/developers/new_drivers
> > >
> > >When you're sure you definitely want to write the driver, let
> > >us know and we'll put your name on the status page.
> > >
> 
> Regards,
> 
> -- 
> Mark M. Hoffman
> mhoffman@lightlink.com
> 
> 
