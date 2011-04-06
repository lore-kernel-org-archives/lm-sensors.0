From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Wed, 06 Apr 2011 06:54:17 +0000
Subject: Re: [lm-sensors]
Message-Id: <D6D887BA8C9DFF48B5233887EF04654109516775C0@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

Thanks for a detailed review and intuitive comments.

> > From: Durgadoss R <durgadoss.r@intel.com>
> >
> > Date: Thu, 3 Mar 2011 02:37:40 +0530
> > Subject: [PATCH:hwmon:v4:Resend]Merging_pkgtemp_with_coretemp
> >
> > This patch merges the pkgtemp driver with the coretemp driver.
> > This merged driver creates one hwmon device per physical CPU i.e
> > per Physical Package. Also, the sysfs interfaces per core are created
> > as each core comes online and removed when it goes offline.
> >
> > Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> >
> 
> After browsing through the code, I concluded that dynamic addition and removal
> of CPUs likely won't work.  So I did a quick test.
> 
> echo 0 >/sys/devices/system/cpu/cpu2/online
> sensors
> 
> Result was as suspected:
> 
> [   84.518158] IP: [<ffffffffa00332a1>] show_label+0x21/0x70 [coretemp]
> [   84.525604] PGD 42b9e0067 PUD 42cc0a067 PMD 0
> [   84.530958] Oops: 0000 [#1] SMP
> [   84.534870] last sysfs file: /sys/devices/platform/coretemp.0/temp4_label
> [   84.542743] CPU 4
> ...
> 
> Oh well. I am quite sure I mentioned it before - _please_ test your code.
> I am not your test group (and maybe you start to understand why it takes
> so long to review your code).
> 

I did test it on Corei5 and SNB. Anyway, next time when I submit this patch,
I shall attach the dmesg logs.
 
> > -       struct device *hwmon_dev;
> > -       struct mutex update_lock;
> > -       const char *name;
> > -       u32 id;
> > -       u16 core_id;
> > -       char valid;             /* zero until following fields are valid */
> > -       unsigned long last_updated;     /* in jiffies */
> > +struct temp_data {
> >         int temp;
> > -       int tjmax;
> >         int ttarget;
> > -       u8 alarm;
> > +       int tjmax;
> > +       u8 crit_alarm;
> 
> crit_alarm is only written to, thus unnecessary.
> 
> [ question, though, is why you keep reading it. Is it expected to change ? ]

When the temp1_input goes above temp1_crit, this crit_alarm is set to 1.
When the temp1_input falls below temp1_crit, this crit_alarm is reset to 0.
As you mentioned below, I don't need this variable. I can just read and display.

> 
> > +       u8 max_alarm;
> 
> max_alarm is not used anywhere, thus unnecessary.

We need this when we add the threshold(max and max_hyst) support also.
Hence I added.

> > +       if (tdata->is_pkg_data)
> > +               return sprintf(buf, "Physical id %d\n", pdata->phys_proc_id);
> > +
> > +       return sprintf(buf, "Core %d\n", tdata->cpu_core_id);
> 
> 	Both are really unsigned, so use %u.

Shall Change it to %u.

> > +static ssize_t show_crit_alarm(struct device *dev,
> > +                               struct device_attribute *devattr, char *buf)
> >  {
> > -       struct coretemp_data *data = coretemp_update_device(dev);
> > -       /* read the Out-of-spec log, never clear */
> > -       return sprintf(buf, "%d\n", data->alarm);
> > +       u32 eax, edx;
> > +       struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> > +       struct platform_data *pdata = dev_get_drvdata(dev);
> > +       struct temp_data *tdata = pdata->core_data[attr->index];
> > +
> > +       rdmsr_on_cpu(tdata->cpu_core_id, tdata->status_reg, &eax, &edx);
> > +       tdata->crit_alarm = (eax >> 5) & 1;
> > +
> 
> Either read it once, store it, and display the stored value, or read and
> display it
> without storing it. Storing it but never using the stored value does not make
> much sense.

I will just read and display. Shall remove the temp1_crit variable.


> > -static struct coretemp_data *coretemp_update_device(struct device *dev)
> > +static int update_curr_temp(struct temp_data *tdata, u32 eax, int tjmax)
> >  {
> > -       struct coretemp_data *data = dev_get_drvdata(dev);
> > +       int err = -EINVAL;
> >
> > -       mutex_lock(&data->update_lock);
> > +       mutex_lock(&tdata->update_lock);
> > +       /*
> > +        * Update the current temperature only if:
> > +        * 1. The time interval has elapsed _and_
> > +        * 2. The data is valid
> > +        */
> > +       if (time_after(jiffies, tdata->last_updated + HZ) &&
> > +                                               (eax & 0x80000000)) {
> > +               tdata->temp = tjmax - (((eax >> 16) & 0x7f) * 1000);
> > +               tdata->last_updated = jiffies;
> > +               err = 0;
> > +       }
> >
> > -       if (!data->valid || time_after(jiffies, data->last_updated + HZ)) {
> > -               u32 eax, edx;
> > +       mutex_unlock(&tdata->update_lock);
> > +       return err;
> > +}
> >
> > -               data->valid = 0;
> > -               rdmsr_on_cpu(data->id, MSR_IA32_THERM_STATUS, &eax, &edx);
> > -               data->alarm = (eax >> 5) & 1;
> > -               /* update only if data has been valid */
> > -               if (eax & 0x80000000) {
> > -                       data->temp = data->tjmax - (((eax >> 16)
> > -                                                       & 0x7f) * 1000);
> > -                       data->valid = 1;
> > -               } else {
> > -                       dev_dbg(dev, "Temperature data invalid (0x%x)\n",
> eax);
> > -               }
> > -               data->last_updated = jiffies;
> > -       }
> > +static ssize_t show_temp(struct device *dev,
> > +                               struct device_attribute *devattr, char *buf)
> > +{
> > +       u32 eax, edx;
> > +       struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> > +       struct platform_data *pdata = dev_get_drvdata(dev);
> > +       struct temp_data *tdata = pdata->core_data[attr->index];
> > +       int err;
> >
> > -       mutex_unlock(&data->update_lock);
> > -       return data;
> > +       rdmsr_on_cpu(tdata->cpu_core_id, tdata->status_reg, &eax, &edx);
> > +       err = update_curr_temp(tdata, eax, tdata->tjmax);
> 
> This is really odd. You _always_ read the temperature, but then only use it
> conditionally. What is the point of doing that ?

Shall Modify the flow of show_temp, such that I do the timer check before
doing/updating anything.


> > +static void update_ttarget(__u8 cpu_model, struct temp_data *tdata,
> > +                               struct device *dev)
> > +{
> > +       int err;
> > +       u32 eax, edx;
> > +
> > +       /*
> > +        * Read the still undocumented IA32_TEMPERATURE_TARGET. It exists
> > +        * on older CPUs but not in this register,
> > +        * Atoms don't have it either.
> > +        */
> > +       if ((cpu_model > 0xe) && (cpu_model != 0x1c)) {
> > +               err = rdmsr_safe_on_cpu(tdata->cpu_core_id,
> > +                               MSR_IA32_TEMPERATURE_TARGET, &eax, &edx);
> > +               if (err) {
> > +                       dev_warn(dev,
> > +                       "Unable to read IA32_TEMPERATURE_TARGET MSR\n");
> > +
> Extra blank line
> 
> > +               } else {
> > +                       tdata->ttarget = tdata->tjmax -
> > +                                       (((eax >> 8) & 0xff) * 1000);
> > +               }
> 
> { } are unnecessary.

In one of the previous patches, I had a single statement split into two lines,
Without Braces. And I got comment asking me to add braces to increase readability.
With that in mind, I added braces.
Shall remove if it is Ok to do so ;-)

> 
> If you can not read ttarget, you still create tempX_max and display 0.
> If ttarget is not supported, the attribute should not be created in the first
> place.
> The old code did this; any special reason for removing it ?

Earlier when I tried the "Adding Threshold Support to Coretemp.patch",
We discussed that temp1_max will have the Threshold1 value if ttarget is not supported.
When we have the Threshold patch all _max things will be fixed.

But if you say that will not work or not the right way to do, I can change
the code accordingly.

> > +static int create_core_data(struct platform_data *pdata,
> > +                               struct platform_device *pdev,
> > +                               unsigned int cpu, int pkg_flag)
> > +{
> > +       struct temp_data *tdata;
> > +       struct cpuinfo_x86 *c = &cpu_data(cpu);
> > +       u32 eax, edx;
> > +       int err;
> > +       int core_id = c->cpu_core_id;
> >
> You need to check here if core_count reached the number of entries in
> core_data[].
> Otherwise we'll get a nasty surprise with the first 16-core CPU (since that CPU
> will
> need 17 entries in core_data[], but there are only 16).

I missed it..Thanks for pointing it out..

> 
> Even better would be to come up with a dynamic scheme which does not depend on
> the number
> of cores.

Thought through this..But the way would be to use a ** and do dynamic mem allocation.
Again, My opinion is that it will make the code complex.
But, if you are Ok with this approach, I can implement this way.

> > +static struct platform_device *get_pdev(int phys_proc_id)
> > +{
> 
> Function names should all start with coretemp_.

Shall Change accordingly..

> > +       /* If this core is a HT one, do not create any interfaces */
> > +       indx = get_core_indx(pdata, c->cpu_core_id);
> > +       if (indx >= 0) {
> > +               dev_info(&pdev->dev, "A HT core (%u) is onlined\n", cpu);
> 
> Is this message really necessary ? It does not provide any real value, or does
> it ?

I will remove this in the next version of the patch..

> 
> > +               return;
> > +       }
> > +
> > +       err = create_core_data(pdata, pdev, cpu, pkg_flag);
> > +       if (err) {
> > +               dev_err(&pdev->dev, "Onlining Core %u on Pkg %d failed\n",
> 
> 	"Onlining" and "Offlining" are really odd terms. Can you find something
> better ?
> 	Adding / Removing, maybe ?

I also had this thought..Shall replace them with Adding / Removing

> 
> 	%d --> %u. Arguable if you want to use %d everywhere, but mixing it is a
> bit odd.

I would rather use %u consistently..

+static void remove_core(struct platform_data *pdata, struct device *dev,
> > +                       int indx)
> > +{
> > +       int i;
> > +       int max = pdata->core_count - 1;
> > +
> > +       /* Remove all sysfs attrs for this core */
> > +       remove_attrs(dev, pdata->core_data[indx]);
> > +
> > +       /* Shift the core_data elements */
> > +       for (i = indx; i < max; i++)
> > +               pdata->core_data[i] = pdata->core_data[i + 1];
> > +
> > +       /* Free the _last_ element */
> > +       kfree(pdata->core_data[max]);
> 
> 	Did you think this through ?
> 	You removed element [indx], yet you remove pdata->core_data[max]
> 	which you just moved to pdata->core_data[max - 1].
> 	Sounds like a recipe for a crash.

Got it..Shall fix this major bug..
I read this core_data as an array and forgot that this is an array
Of _pointers_. Thanks Guenter ;-)

> > +static void get_core_online(unsigned int cpu)
> > +{
> > +       struct cpuinfo_x86 *c = &cpu_data(cpu);
> > +       struct platform_device *pdev = get_pdev(c->phys_proc_id);
> > +
> > +       if (!pdev) {
> > +               /*
> > +                * We are bringing the _first_ core in this pkg
> > +                * online. So initialize per-pkg data structures and
> > +                * then bring this core online.
> > +                */
> > +               coretemp_device_add(cpu);
> 
> If the CPU has no thermal sensors, or if coretemp_device_add() fails,
> you keep going anyway. Kind of odd to check for the error in add_core()
> instead of not calling add_core() in the first place.

Shall add error checking and return if device_add(cpu) fails..

> 
> Also, even though coretemp_device_add() is now only called once per CPU
> package,
> it still includes code which is only useful if it was called once per core.

I did not want to touch that method..
I see that there is a check to skip HT entries.
Shall remove that in the next version of the patch.

> > +
> > +       pdata = platform_get_drvdata(pdev);
> > +
> > +       indx = get_core_indx(pdata, c->cpu_core_id);
> > +       if (indx < 0) {
> > +               dev_info(&pdev->dev, "Core %d does not exist\n",
> > +                       c->cpu_core_id);
> 
> I think you'll hit this for the 2nd core of HT CPUs. If so, it is not an error
> condition. Also see below.
> 
> > +               return;
> > +       }
> > +
> > +       if (pdata->core_data[indx]->cpu = cpu)
> > +               remove_core(pdata, &pdev->dev, indx);
> > +       else
> > +               dev_info(&pdev->dev, "A HT CPU (%u) is offlined\n", cpu);
> > +
> 	Somehow this looks fishy. Since you did not add an entry for the HT core
> 	in the first place, doesn't that mean that get_core_indx() will fail
> 	if you try to remove that non-existing entry ?
> 	If so, you would get an "Core %d does not exist" error whenever a HT
> 	CPU is removed. Not desirable.
> 
> 	The old code would add the 2nd HT core if the 1st one was taken offline.
> 	I don't see that happen here. Not sure if that was a good idea, so I
> don't
> 	really mind. But I don't think the code should complain if that 2nd never
> 	added HT core is taken offline.

Alright. Shall remove the message. Thanks for pointing it out.

> >  static int __init coretemp_init(void)
> >  {
> >         int i, err = -ENODEV;
> > @@ -559,7 +851,7 @@ static int __init coretemp_init(void)
> >                 goto exit;
> >
> >         for_each_online_cpu(i)
> > -               coretemp_device_add(i);
> > +               get_core_online(i);
> >
> >  #ifndef CONFIG_HOTPLUG_CPU
> >         if (list_empty(&pdev_list)) {
> > --
> > 1.7.4
> >
> 

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
