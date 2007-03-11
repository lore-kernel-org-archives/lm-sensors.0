From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Sun, 11 Mar 2007 20:54:13 +0000
Subject: [lm-sensors] libsensors patches
Message-Id: <20070311205413.GJ3251@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070311152104.bd092ff9.khali@linux-fr.org>
In-Reply-To: <20070311152104.bd092ff9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans, Axel:

* Hans de Goede <j.w.r.degoede at hhs.nl> [2007-03-11 20:53:43 +0100]:
> 
> 
> Axel Thimm wrote:
> > On Sun, Mar 11, 2007 at 08:23:25PM +0100, Hans de Goede wrote:
> >> Mark M. Hoffman wrote:
> >>> Hi Hans:
> >>>
> >> <discussion about 3.0 versus increments snipped>
> >>
> >>> I don't agree.  I think the sum of changes we are planning does warrant the
> >>> move to 3.0.  It will be easier than the alternative, e.g.:
> >>>
> >>> 	2.10.4 - drop support for 2.4.x proc file access
> >>> 	2.10.5 - new API function
> >>> 	2.10.6 - include command in config file
> >>>
> >> Okay, first of all this is me with my lmsensors-contributers hat firmly 
> >> off and my packager maintaining over a 100 packages in Fedora hat firmly on:
> >>
> >> Lets try to split 2 things here, doing a 3.0 release to indicate some 
> >> kinda milestone and breaking the ABI.
> > 
> > If /proc support gets dropped then it already breaks the ABI, since
> > the ABI is not only about talking to the shared lib, but also to other
> > interfaces as well.
> > 
> > If you still keep half the ABI in place by not touching API and soname
> > of the lib, dependent projects will not notice the loss of /proc
> > support until runtime.
> > 
> 
> Agreed, thinking about this some more I'm not so sure that dropping 2.4 
> support is a good idea as there is still plenty of 2.4 usage out there. 
> An alternative would be to maintain both a 2.10 branch for 2.4 + 2.6 
> users and a 3.0 branch for those who only use 2.6, but is the gain of a 
> somewhat smaller, cleaner 3.0 branch worth the pain of maintaining 2 

This was my intention all along, except, with the idea that 2.10.4 or .5 would
be the last of that line.  We barely have time to keep up with the 2.6 kernel;
IMHO we should have dropped 2.4 kernel support a year or two ago.

And if we're going to put sensors 2.10.x in a deep freeze, then I don't want
to have to make bugfixes in two places, like you say.  Thus, I wanted all of
these new features to wait for 3.0.

> branches. Also in this scenario I think we should keep them atleast API 
> compatible from the application pov, as some distros may want to ship 
> 2.10 then while others ship 3.0. This is exactly why I've suggested to 
> turn 2.4 support into an ifdef instead of ripping it out.

Non-sequitor?  I don't understand why distros *couldn't* choose as you say,
or just ship both.  OK, so a kernel 2.4 distro can't ship sensors 3.0.  But
that's just too bad.  They can't ship the most recent udev or modprobe either.

> > So it looks like breaking the ABI "on purpose" might be just OK. The
> > question is whether libsensors.so.3 and libsensors.so.4 would
> > peacefully coexist on a non-packaging level to allow for a smooth
> > transition.
> > 
> 
> IOW, no sensors.conf format changes for example?

Right, the config file change is the biggest problem here... *if* the new
functionality is actually used.  If no 'include' command appears in a config
file, then it will work for both major versions.  The intended use case for
the include feature is probably a long way off anyway.

I don't forsee any other problems.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


