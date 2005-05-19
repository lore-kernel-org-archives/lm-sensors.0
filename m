From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: [RFC][2.5] list_for_each_safe not so safe (was Re: OOPS w83781d
Message-Id: <20030616184149.GC25585@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3ED8067E.1050503@paradyne.com> <20030601143808.GA30177@earth.solarsys.private> <20030602172040.GC4992@kroah.com> <20030605023922.GA8943@earth.solarsys.private> <20030605194734.GA6238@kroah.com> <1055136870.5280.196.camel@workshop.saharacpt.lan> <20030610054107.GA22719@earth.solarsys.private> <1055401021.5280.3143.camel@workshop.saharacpt.lan> <20030613023651.GA1401@earth.solarsys.private> <1055571995.12868.5.camel@nosferatu.lan>
In-Reply-To: <1055571995.12868.5.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schlemmer <azarah@gentoo.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Sensors <sensors@stimpy.netroedge.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>

On Sat, Jun 14, 2003 at 08:26:35AM +0200, Martin Schlemmer wrote:
> On Fri, 2003-06-13 at 04:36, Mark M. Hoffman wrote:
> > > > > Anyhow, Only change I have made to the w83781d driver, is one line
> > > > > (just tell it to that if the chip id is 0x72, its also of type
> > > > > w83726HF), but now (2.5.70-bk1[123]) it segfaults for me on rmmod, where
> > > > > it did not with 2.5.68 kernels when I still had the other board.  I will
> > > > > attach a oops tomorrow or such when I get home.
> > > > 
> 
> > My first patch was naive; the patch below solves the problem by
> > letting w83781d_detach_client remove the three clients (1 * primary
> > + 2 * subclients) independently.  It's a noisy patch because I had
> > to change the way the subclients were kmalloc'ed - sorry.  The meat
> > is around line 1422.  This patch works for me... comments?
> > 
> > Regards,
> > 
> > --- 
> > Mark M. Hoffman
> > mhoffman@lightlink.com
> 
> Greg, this patch from Mark fixes it, please include in your stuff
> to send to Linus.

Applied, thanks.

greg k-h
