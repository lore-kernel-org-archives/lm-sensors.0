From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: [RFC PATCH] Re: [OOPS] w83781d during rmmod (2.5.69-bk17)
Message-Id: <20030605194734.GA6238@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030524183748.GA3097@earth.solarsys.private> <3ED8067E.1050503@paradyne.com> <20030601143808.GA30177@earth.solarsys.private> <20030602172040.GC4992@kroah.com> <20030605023922.GA8943@earth.solarsys.private>
In-Reply-To: <20030605023922.GA8943@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, Sensors <sensors@stimpy.netroedge.com>, Martin Schlemmer <azarah@gentoo.org>

On Wed, Jun 04, 2003 at 10:39:22PM -0400, Mark M. Hoffman wrote:
> * Greg KH <greg@kroah.com> [2003-06-02 10:20:40 -0700]:
> > On Sun, Jun 01, 2003 at 10:38:08AM -0400, Mark M. Hoffman wrote:
> > > 
> > > This patch against 2.5.70 works for me vs. an SMBus adapter.  It needs
> > > re-testing against an ISA adapter since my particular chip is SMBus only.
> > 
> > I've applied this and will send it off to Linus in a bit.
> 
> Thanks!
> 
> This patch fixes the various return values in the w83781d_detect()
> error paths.  It also cleans up some formatting here and there.
> It should be applied on top of the previous one.
> 
> It works for me; same caveat as above w.r.t. ISA.

Applied, thanks.

greg k-h
