From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 13 Mar 2007 08:47:58 +0000
Subject: [lm-sensors] [PATH] coretemp driver - take2
Message-Id: <20070313094758.9d02b20c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45AAA204.5030905@assembler.cz>
In-Reply-To: <45AAA204.5030905@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Rudolf,

On Mon, 12 Mar 2007 23:54:37 +0100, Rudolf Marek wrote:
> > It seems that changed recently:
> >   http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dcommit;h=B077ffb3b767c3efb44d00b998385a9cb127255c
> >=20
> > This introduces exported functions rdmsr_on_cpu() and wrmsr_on_cpu()
> > (check in arch/i386/lib/msr-on-cpu.c) which I think is what you need?
>=20
> Yep thanks. But it use the RDMSR/WRMSR without exception handling :/
>=20
> Maybe we can convert add functions later?

What's the problem exactly? If the functions in
arch/i386/lib/msr-on-cpu.c need to be improved, I'd prefer that you do
that now rather than duplicating the code and postponing the cleanup to
later. Others might need the same improvement so your work will benefit
to them, plus I fear that the cleanup never actually happens if we
merge the coretemp driver first.

> > One thing I'm not happy with is the fact that you create one separate
> > platform device for every temperature sensor, it makes the sensors
> > output a bit confusing. But I guess it's not possible to support CPU
> > hotplug otherwise, so, so be it.
>=20
> And it is quite complicated to get what CPUs are toghether and what are d=
ifferent.

Well /proc/cpuinfo appears to know so it should be possible. From
arch/i386/kernel/cpu/proc.c:

	if (c->x86_max_cores * smp_num_siblings > 1) {
		seq_printf(m, "physical id\t: %d\n", c->phys_proc_id);
		seq_printf(m, "siblings\t: %d\n", cpus_weight(cpu_core_map[n]));
		seq_printf(m, "core id\t\t: %d\n", c->cpu_core_id);
		seq_printf(m, "cpu cores\t: %d\n", c->booted_cores);
	}

So it doesn't look so complicated. However, it can be argued whether
this is worth the effort. Additionally...

> > I'm not even sure if platform devices are the way to go... After all
> > the CPU cores are already represented in the driver tree:
> >   /sys/devices/system/cpu/cpu0
> >   /sys/devices/system/cpu/cpu1
> > I guess that in theory we should add our stuff there, either in a
> > subdirectory as cpufreq does, or as a child class device. I'm not too
> > sure how it'll fit with our hwmon class and libsensors though, so I'm
> > fine postponing this cleanup to later.

... if we ever manage to move the temperature interface files at the
right location in the device tree, then we _will_ have one
subdirectory, virtual device or whatever, per CPU core, there will be
no way around it. So it might be easier to keep the current
one-device-per-core design, despite the odd sensors output it results
in.

> >> +static struct coretemp_data *coretemp_update_device(struct device *de=
v)
> >> +{
> >> +	struct coretemp_data *data =3D dev_get_drvdata(dev);
> >> +
> >> +	mutex_lock(&data->update_lock);
> >> +
> >> +	if (!data->valid || time_after(jiffies, data->last_updated + HZ)) {
> >> +		u32 eax, edx;
> >> +
> >> +		data->valid =3D 0;
> >> +		msr_read(data->id, MSR_IA32_THERM_STATUS, &eax, &edx);
> >> +		data->therm_status =3D eax;
> >> +
> >> +		/* update only if data has been valid */
> >> +		if (eax & 0x80000000) {
> >> +			data->temp =3D data->tjmax - (((data->therm_status >> 16)
> >> +							& 0x7f) * 1000);
> >> +			data->valid =3D 1;
> >> +		}
> >=20
> > When could the data not be valid? I think it's a problem that we may
> > return an old cached value to user-space and don't even let the user
> > know.
>=20
> I don't know... The data might be valid only when data valid is set to 1,=
 Intel=20
> documentation is quiet as castle in Carpathian Mountains. Know how? retur=
n=20
> EAGAIN? Maybe we can fix that in next iteration once we know that userspa=
ce can=20
> handle that.

I was wondering if it would make sense to attempt a few retries
immediately, as we do in the w83l785ts driver. But of course it depends
on what this "invalid" bit means and whether we can hope it to be
cleared on next try or if it takes some time to wear off. Without
documentation we can't tell.

Maybe it would be a good idea to add a debug log message when this
happens, so we have a chance to gather some data on how frequently it
happens in the real world?

I don't think we have to wait for the next iteration of the driver to
return an error. I prefer that we return an error rather than a
temperature value which is not true. If libsensors and/or sensors need
to be updated to handle that case, let's do that.

As a side note, your data structure decisions are a bit inconsistent.
On the one hand, you store the raw value of eax in data->therm_status,
but on the other hand you compute the temperature value directly in the
update function. I think you should decide for one way and stick to it.
Either you only read the raw data in update and do the processing on
the sysfs callback functions (as all the other hwmon drivers do), or
you process everything in the update function, but mixing both styles
is confusing and inefficient.

> >> +			/* supported CPU not found, but report the unknown
> >> +			   family 6 CPU */
> >> +			if ((c->x86 =3D 0x6) && (c->x86_model > 0xf))
> >> +				printk(KERN_WARNING DRVNAME ": Unknown CPU, please"
> >> + 			   " report to the lm-sensors at lm-sensors.org\n");
> >=20
> > Errr, no, please don't do that. When Intel releases a new CPU, we don't
> > want millions of users to report on our mailing list. When such a CPU is
> > available, we'll know soon enough, I think.
>=20
> I left: Unknown CPU model...(and model #)

OK. This should probably be KERN_NOTICE or KERN_INFO rather than
KERN_WARNING, too.

> I will post fixed version tomorrow, I think I making more mistakes during=
 late=20
> night :/ And you and David suffer. Do you want new thread with take3?

Yes, new thread please.

--=20
Jean Delvare

