From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 14 Aug 2013 18:29:38 +0000
Subject: Re: [lm-sensors] reading on-die temperature sensor of AMD A10 5700 processor
Message-Id: <20130814182938.GA29555@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
In-Reply-To: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Aug 14, 2013 at 01:20:57PM -0400, Dev, Kapil wrote:
> On Wed, Aug 14, 2013 at 1:30 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > On 08/13/2013 10:17 PM, Kapil Dev wrote:
> >
> >>
> >> On Aug 14, 2013, at 12:56 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >>  On 08/13/2013 08:09 PM, Dev, Kapil wrote:
> >>>
> >>>>
> >>>>
> >>>> On Tue, Aug 13, 2013 at 11:02 PM, Guenter Roeck <linux@roeck-us.net<mailto:
> >>>> linux@roeck-us.net>> wrote:
> >>>>
> >>>>     On 08/13/2013 07:41 PM, Dev, Kapil wrote:
> >>>>
> >>>>         Thanks again Guenter!
> >>>>
> >>>>
> >>>>
> >>>>
> >>>>         On Tue, Aug 13, 2013 at 5:51 PM, Guenter Roeck <
> >>>> linux@roeck-us.net <mailto:linux@roeck-us.net> <mailto:
> >>>> linux@roeck-us.net <mailto:linux@roeck-us.net>>> wrote:
> >>>>
> >>>>              On Tue, Aug 13, 2013 at 05:11:31PM -0400, Dev, Kapil wrote:
> >>>>               > Thanks for the response Guenter!
> >>>>               >
> >>>>               > I put the system on load and I noticed their value
> >>>> hardly changes. To my
> >>>>               > surprise, I ran a benchmark for 3 minutes and none of
> >>>> temp*  values changed
> >>>>               > during execution. The highest reported temperature is
> >>>> always 48C.
> >>>>               >
> >>>>               > I was expecting that the internal temperature would
> >>>> have "sensor = thermal
> >>>>               > diode" or "sensor = core" as a keyword. I thought
> >>>> "sensor=thermistor" means
> >>>>               > the corresponding sensor is on the motherboard and not
> >>>> the internal
> >>>>               > die-sensor.
> >>>>               >
> >>>>              Sure, but who knows if they put a sensor below the CPU for
> >>>> some reason ...
> >>>>
> >>>>              I am not familiar with the A10 CPUs. Are those similar to
> >>>> K10 ?
> >>>>              If so, maybe the k10temp driver works or could be extended
> >>>> to support it.
> >>>>              Can you give it a try ?
> >>>>
> >>>>              If it does not work out of the box, can you send me the
> >>>> output of "lspci -nn" ?
> >>>>
> >>>>
> >>>>         Kapil: I believe K10 corresponds to A8 seried, and A10 has
> >>>> Bulldozer architecture (http://www.cpu-world.com/__**
> >>>> CPUs/Bulldozer/TYPE-A10-__**Series.html<http://www.cpu-world.com/__CPUs/Bulldozer/TYPE-A10-__Series.html><
> >>>> http://www.cpu-world.com/**CPUs/Bulldozer/TYPE-A10-**Series.html<http://www.cpu-world.com/CPUs/Bulldozer/TYPE-A10-Series.html>>).
> >>>> I am not sure how different they are though. I tried K10, but it did not
> >>>> work out of the box. I am looking into k10temp.c driver now. Also,I am
> >>>> attaching the output of "lspci -nn" command herewith; you might have to
> >>>> open it using wordpad for proper formatting..
> >>>>
> >>>>
> >>>>     Your lspci output includes
> >>>>
> >>>>     00:18.3 Host bridge [0600]: Advanced Micro Devices [AMD] Device
> >>>> [1022:1403]
> >>>>
> >>>>     which is supported by the latest k10temp driver. Support was added
> >>>> early last year.
> >>>>     What is your kernel version, and can you switch to a more recent
> >>>> version ?
> >>>>
> >>>>
> >>>> Kapil: I have 2.6.39-020639-generic kernel. Is it too old kernel for
> >>>> k10temp driver to work? Which stable kernel should I upgrade to?
> >>>>
> >>>>
> >>> You need 3.4 or later.
> >>>
> >>
> >> Kapil: I was trying to avoid updating the kernel because my current
> >> kernel is setup for running different type of benchmarks etc. Seems like I
> >> can't avoid updating the kernel; I will do it..
> >>
> >>  Alternative would be to back-port the k10temp driver from a later
> > kernel. Then you can keep running the old one.
> >
> >
> Kapil: Not sure how to do that. I am already taking the k10temp driver from
> here: http://khali.linux-fr.org/devel/lm-sensors/drivers/k10temp/ and
> compiling and using it.
> 
That version should already have support for your chip unless I am missing
something. If you already use it, a newer kernel version will not help.

Do you get any kernel log message when you try to load it ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
