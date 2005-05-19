From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: bmcsensors port to 2.6
Message-Id: <25381867050315213679f2f0db@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <FA095C015271B64E99B197937712FD02510AFF@freedom.grz.icomedias.com>
In-Reply-To: <FA095C015271B64E99B197937712FD02510AFF@freedom.grz.icomedias.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

As a side note, I'm working on integrating the ipmi 0.9 patch into the
2.6 bmcsensors driver, the original ipmi 0.9 patch was not as
significant as its size would lead one to believe (as you so noted),
and I'm trying to rework it so it is more maintainable and has less
code repetition. It looks like the resulting patch should back port
easily enough to the 2.4 version. BTW have you found any
documentation/specs on the ipmi 0.9 -> 1.0 differences? I can't seem
to find any freely available docs/specs on ipmi 0.9 online.

Thanks,
Yani

On Tue, 15 Mar 2005 17:36:59 -0500, Mark Studebaker <mds@mds.gotdns.com> wrote:
> I suggest you submit it to us now (email the patch with an explanation and a signed-off-by line)
> and work on the dymaic improvements as a phase 2, after the patch is hopefully accepted.
> 
> Yani Ioannou wrote:
> > Just to follow up on Martin's message, the problem was discussed in
> > more detail in this mailing list before (see
> > http://archives.andrew.net.au/lm-sensors/msg26067.html), however
> > nothing has addressed this problem since.
> >
> > If I was to create a patch that allowed a more functional device sysfs
> > callback, how likely would it ever be accepted into the mainstream
> > kernel?
> >
> > To highlight the problem, having a maximum of 150 sensors in the
> > bmcsensors drivers results in a kernel module 110kb in size, compared
> > to a size of ~50kb for the driver with a limit of 50 drivers (due to
> > the extra callback functions and pointers). Aside from the kludge that
> > is the non-dynamic callbacks the driver uses currently it causes a
> > real and unacceptable (in my opinion) inefficiency.
> >
> > If there really is going to be no way around this then I would suggest
> > merging the bmcsensors driver into the mainstream kernel, I believe it
> > is stable enough.
> >
> > Yani
> >
> > On Fri, 11 Mar 2005 15:21:17 +0100, Bene Martin
> > <martin.bene@icomedias.com> wrote:
> >
> >>Hi,
> >>
> >>the bmcsensors port for kernel 2.6 by Yani Ioannou (available on
> >>sourceforge, http://bmcsensors-26.sourceforge.net/) looks quite
> >>functional now.
> >>
> >>As also noted by Yani, one thing is really ugly right now: at compile
> >>time, bmcsesnors has no idea how many sensors a board provides; this
> >>seems to range from ~20 Sesnors for simple boards up to > 60 for a dell
> >>1750.
> >>
> >>The sysfs interface requires a seperate callback function for read, min,
> >>max, label, write min and write max; currently the driver assumes 100
> >>sensors max and just declares callback functions for all of them; while
> >>this works ist neither nice code nor especially efficient since most of
> >>those functions generaly aren't required.
> >>
> >>Anyone got an idea how to better handle an unknown number of sensors in
> >>the driver?
> >>
> >>Thanks, Martin
> >>
> >>
> >
> >
> 
>
