From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 23 May 2011 19:28:55 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Fix compile error if
Message-Id: <1306178935.2163.386.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1306177601-8812-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1306177601-8812-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2011-05-23 at 14:58 -0400, Linus Torvalds wrote:
> Patch looks ok in the sense that it clearly fixes a compile problem,
> but can you explain why offlining a core should online the HT
> siblings? It makes no sense, since that CPU_DOWN_PREPARE will be sent
> to each core, so now they online and offline each other mindlessly.
> 
get_core_online() and put_core_offline() are coretemp internal static
functions. The semantics is  "create hwmon attributes for this core" and
"remove hwmon attributes for this core". Those functions are called as
reaction to CPU_DOWN_PREPARE and CPU_ONLINE events, but they don't cause
any such events.

> Also, why does that loop do a "break"? What's wrong with having
> multiple HT siblings? What's special about one?
> 

We want to show a single temperature entry for all HT siblings of a
core, not the temperature of each HT sibling. If one of the siblings is
taken offline, we still want to report the core temperature unless all
siblings have been taken offline. But at the same time we still only
want to show one entry for the core, so once one such core is found, we
are done.

True, in many cases all HT siblings will be taken offline at the same
time, but that does not have to be the case.

> IOW, looking at it, that whole put_core_offline() logic just looks
> damn confused to me. Could you explain it, please? Both to me, and
> perhaps with a patch explaining the logic with a comment. Because
> right now it just looks insane.

Hopefully the above makes sense. I'll try to add some text describing
the logic in more detail.

Please also see commit e40cc4bdfd4b89813f072f72bd9c7055814d3f0f, which
actually introduced the HT specific logic.

Thanks,
Guenter

>                          Linus
> 
> On Mon, May 23, 2011 at 12:06 PM, Guenter Roeck
> <guenter.roeck@ericsson.com> wrote:
> > cpu_sibling_mask() is not defined unless CONFIG_SMP is defined, so it must not
> > be used directly in the code without ifdef protection.
> > To solve the problem and avoid ifdefs in the code, define for_each_sibling()
> > and use it instead.
> >
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > Cc: Fenghua Yu <fenghua.yu@intel.com>
> > Cc: Durgadoss R <durgadoss.r@intel.com>
> > ---
> >  drivers/hwmon/coretemp.c |    4 +++-
> >  1 files changed, 3 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> > index 5c7cd60..a00245e 100644
> > --- a/drivers/hwmon/coretemp.c
> > +++ b/drivers/hwmon/coretemp.c
> > @@ -51,10 +51,12 @@
> >  #define TO_PHYS_ID(cpu)                cpu_data(cpu).phys_proc_id
> >  #define TO_CORE_ID(cpu)                cpu_data(cpu).cpu_core_id
> >  #define TO_ATTR_NO(cpu)                (TO_CORE_ID(cpu) + BASE_SYSFS_ATTR_NO)
> > +#define for_each_sibling(i, cpu)       for_each_cpu(i, cpu_sibling_mask(cpu))
> >  #else
> >  #define TO_PHYS_ID(cpu)                (cpu)
> >  #define TO_CORE_ID(cpu)                (cpu)
> >  #define TO_ATTR_NO(cpu)                (cpu)
> > +#define for_each_sibling(i, cpu)       for (i = 0; false; )
> >  #endif
> >
> >  /*
> > @@ -762,7 +764,7 @@ static void __cpuinit put_core_offline(unsigned int cpu)
> >                coretemp_remove_core(pdata, &pdev->dev, indx);
> >
> >        /* Online the HT version of this core, if any */
> > -       for_each_cpu(i, cpu_sibling_mask(cpu)) {
> > +       for_each_sibling(i, cpu) {
> >                if (i != cpu) {
> >                        get_core_online(i);
> >                        break;
> > --
> > 1.7.3.1
> >
> >



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
