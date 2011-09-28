From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 28 Sep 2011 15:22:33 +0000
Subject: Re: [lm-sensors] [PATCH] coretemp: don't use kernel assigned CPU
Message-Id: <20110928152233.GB3754@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4E7C7CF40200007800057865@nat28.tlf.novell.com>
In-Reply-To: <4E7C7CF40200007800057865@nat28.tlf.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Wed, Sep 28, 2011 at 05:57:11AM -0400, Jean Delvare wrote:
> Hi Jan, Guenter,
> 
> On Fri, 23 Sep 2011 10:37:58 -0700, Guenter Roeck wrote:
> > On Fri, 2011-09-23 at 06:35 -0400, Jan Beulich wrote:
> > > ... as that has the potential to conflict with (particularly soft) CPU
> > > hot removal and re-adding.
> > > 
> > > Signed-off-by: Jan Beulich <jbeulich@suse.com>
> > > 
> > > ---
> > >  drivers/hwmon/coretemp.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > --- 3.1-rc7-coretemp.orig/drivers/hwmon/coretemp.c
> > > +++ 3.1-rc7-coretemp/drivers/hwmon/coretemp.c
> > > @@ -724,7 +724,7 @@ static int __cpuinit coretemp_device_add
> > >  
> > >  	mutex_lock(&pdev_list_mutex);
> > >  
> > > -	pdev = platform_device_alloc(DRVNAME, cpu);
> > > +	pdev = platform_device_alloc(DRVNAME, TO_PHYS_ID(cpu));
> > 
> > This is incomplete, unfortunately. pdev->id is assumed to match the CPU
> > ID, not the physical ID, and the code executes TO_PHYS_ID() again on it.
> > I'll update the patch to fix that problem and apply it.
> > 
> > Guenter
> 
> This has been on my to-do list for a long time but I never got around
> to doing it. Thanks Jan for stepping in.
> 
> However it seems that the patch isn't OK, not even after Guenter's fix.
> chk_ucode_version() assumes that pdev->id is a CPU number, not a
> physical CPU ID, so currently the microcode checks are done on random
> CPUs. Probably the microcode check should be moved from
> coretemp_probe() to get_core_online(), which makes sense anyway, as
> there is little point in creating a platform device if it's not going
> to work.
> 
This driver is becoming my nemesis :(

> I have the following fix:
> 
> From: Jean Delvare <khali@linux-fr.org>
> Subject: hwmon: (coretemp) Fixup platform device ID change
> 
> With recent change "hwmon: (coretemp) don't use kernel assigned CPU
> number as platform device ID", the microcode check is now running on
> random CPU. Fix that by checking the microcode before creating the
> platform device rather than at probe time.
> 
> Also avoid calling TO_PHYS_ID(cpu) twice in the same function, it's
> expensive.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Jan Beulich <jbeulich@suse.com>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  drivers/hwmon/coretemp.c |   27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
> 
Thanks a lot for the fix. Applied.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
