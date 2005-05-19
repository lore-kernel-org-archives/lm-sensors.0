From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: 2.6.5 problems
Message-Id: <20020923092239.K20006@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D8B5669.F64CE483@paradyne.com>
In-Reply-To: <3D8B5669.F64CE483@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I'm OK with a 2.6.6 release.  There have been a lot of important
changes in 2.6.5, so it's reasonable to have a followup release with
fixes and refinements.

Just let me know when we want to do that.


Phil

On Sun, Sep 22, 2002 at 04:34:10PM -0400, Mark D. Studebaker wrote:
> you 2 are welcome to do 2.6.6 without me if you want.
> 
> Albert Cranford wrote:
> > 
> > OK I checked in a tested i2c.h in 2.2/2.4/2.5.
> > I understand your busy schedule so its OK if we
> > postpone 2.6.6.  I'll watch the trouble ticket for
> > these two problems/fixes.
> > Albert
> > +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,1)
> > +#ifndef __exit
> > +#define __exit
> > +#endif
> > +#endif
> > 
> > "Mark D. Studebaker" wrote:
> > >
> > > A quick 2.6.6 is OK with me.
> > > Phil what about you?
> > > 2.6.6 will require i2c-2.6.6 so that will require a big note on the
> > > download page.
> > > I'll be very busy this week and then out of town for a week and a half,
> > > so I won't be able to contribute much at all for the next 3 weeks.
> > > mds
> > >
> > > Albert Cranford wrote:
> > > >
> > > > Hi Mark,
> > > > I assume you are saying linux-2.4 and dmi_scan.  We
> > > > also have an issue with __exit.  An easy fix is to
> > > > define __exit in i2c.h.
> > > >
> > > > I would opt to incorporate both corrections and release
> > > > 2.6.6 after a quick system check across linux-2.2/2.4/2.5.
> > > >
> > > > After this is completed, I would have time to incorporate
> > > > i2c-compat.h in CVS for 2.6.7, preserving linux-2.2
> > > > compatibility.  It seems there are lots of users
> > > > with linux-2.2 still.
> > > > Albert
> > > > "Mark D. Studebaker" wrote:
> > > > >
> > > > > I fixed both the ticket 1002 problems and some others involving
> > > > > mkpatched kernels.
> > > > > Now I know what export-objs does (Documentation/kbuild/makefiles.txt is
> > > > > an excellent reference).
> > > > >
> > > > > I put a note on the download page that i2c only worked for 2.4 kernels.
> > > > > Let's see if we get a lot of complaints - if not we can remove the 2.2
> > > > > compatibility
> > > > > stuff from i2c and sensors in the next release? And I put a note on the
> > > > > home page.
> > > > >
> > > > > I don't think that the problems are serious enough to do a fast 2.6.6
> > > > > release.
> > > > > I'm going to go ahead and update freshmeat.
> > > > >
> > > > > ** Note that the MC1066 update to adm1021 requires SENSORS_INSMOD_8 from
> > > > > i2c-proc.h.
> > > > > In other words, unless we work around it somehow (I don't see how) - the
> > > > > 2.6.6 lm_sensors release
> > > > > will REQUIRE i2c-2.6.6.
> > > > > Let's think about this some more, it will increase our support issues a
> > > > > lot.
> > > > > But we've been keeping our dependency on i2c-2.6.1 for quite a while,
> > > > > maybe it was time anyway.
> > > > > Albert, if you can include the i2c-proc.h diff along with the i2c patch
> > > > > and get
> > > > > it into kernel 2.4 that would help.
> > > > >
> > > > > mds
> > > > >
> > > > > Mark Studebaker wrote:
> > > > > >
> > > > > > dmi_scan.c doesn't compile in-kernel (ticket 1002)
> > > > > > for at least one person, dmi_scan.c doesn't compile as a module, but it works for me (tkt 1002)
> > > > > > i2c-elv.c doesn't compile for 2.2 kernels because of __exit (ticket 1005)
> > > > > >
> > > > > > I'd like to look at these more this weekend and put fixes on the home page
> > > > > > before we do the freshmeat thing.
> > > >
> > > > --
> > > > Albert Cranford Deerfield Beach FL USA
> > > > ac9410@bellsouth.net
> > 
> > --
> > Albert Cranford Deerfield Beach FL USA
> > ac9410@bellsouth.net

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
