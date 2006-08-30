From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 30 Aug 2006 07:10:44 +0000
Subject: [lm-sensors] [RFC PATCH 2.6.18-rc4-mm1] hwmon: unchecked return
Message-Id: <20060830091044.4fdd82f8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060814020407.GA3327@jupiter.solarsys.private>
In-Reply-To: <20060814020407.GA3327@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

> > Also, when sending patches to the list, please set the attachement type
> > to text/plain rather than application/octet-stream. It will make it way
> > easier for people to read it.
> 
> I'm looking into it. One possibility is to change the extension of the
> files (e.g. add ".txt" to every file) -- however, then anyone who
> reads emails from me will think, "what is this guy doing adding .txt
> to everything?"

I'm sure most readers of this list have heard about binary vs. text
attachement issues before, and will understand why you are doing that.

> Gmail allows POP access, which I don't currently use,
> and I'm looking for SMTP access--if that is possible, then I'll fix it
> that way.

Maybe you could contact the gmail admins and ask them to add .patch
and .diff to the list of known file extensions? It shouldn't be too
hard.

> I also considered sending a patch in the body of the
> message, but gmail will wrap the text and break the patch. What I'm
> doing for now is attaching it twice, first with .txt and then without.
> It's just an extra 7k in the email.

No, please don't do that. It's even more confusing, and "just an extra
7k in the email" is not exactly acceptable on a mailing list.

> As a side note, I implemented the sysfs_create_group() and
> sysfs_remove_group() method. Here are a few comparisons:
> 
> Using device_create_file() / device_remove_file() in for loops:
> -rw-r--r-- 1 root root  6227 Aug 27 20:01
> w83627ehf_unchecked_device_create_file1.patch
> -rw-r--r-- 1 root root 39125 Aug 27 20:02 module1.ko
> 
> Using sysfs_create_group() and sysfs_remove_group():
> -rw-r--r-- 1 root root 13109 Aug 27 19:40
> w83627ehf_unchecked_device_create_file2.patch
> -rw-r--r-- 1 root root 40617 Aug 27 19:42 module2.ko
> 
> I can send the sysfs_create_group patch if anyone is interested. But
> since the device_create_file() is a smaller patch, I'll stay with that
> one.

The difference is that most of the added size is data in the
sysfs_remove_group() case, and code in the device_remove_file()-in-loop
case. I think the chances to have a bug in data is lower in general, so
sometimes it's better to have a slightly larger binary if it means less
code.

Note that using sysfs_create_group() was never thought to be a good
idea in general for the hardware monitoring drivers. What Mark M.
Hoffman had been advocating for complex cases was device_create_file()
in loops for file creation and sysfs_remove_group() for file removal.
You maye have something even smaller and more simple code if you try
that.

That being said, I don't actually care. As long as your patch does the
job properly, I'm OK. And the patch you just sent does appear to be
mostly OK, I only have cosmetic comments:

> +static void remove_unregister(struct w83627ehf_data *data, struct device *dev)

It would make sense to prefix it with w83627ehf_ as most other "main"
functions of that driver.

> +{
> +	/* some entries in the following arrays may not have been used in
> +	 * device_create_file(), but device_remove_file() will ignore them */
> +	int i;

Add a blank line here?

> +	for (i = 0; i < ARRAY_SIZE(sda_temp); i++)
> +		device_remove_file(dev, &sda_temp[i].dev_attr);
> +	for (i = 0; i < 5; i++) {
> +		if (i < 4) { /* w83627ehf only has 4 pwm */
> +			device_remove_file(dev, &sda_tolerance[i].dev_attr);
> +			device_remove_file(dev, &sda_target_temp[i].dev_attr);
> +			device_remove_file(dev, &sda_pwm_enable[i].dev_attr);
> +			device_remove_file(dev, &sda_pwm_mode[i].dev_attr);
> +			device_remove_file(dev, &sda_pwm[i].dev_attr);
> +		}
> +		device_remove_file(dev, &sda_fan_min[i].dev_attr);
> +		device_remove_file(dev, &sda_fan_div[i].dev_attr);
> +		device_remove_file(dev, &sda_fan_alarm[i].dev_attr);
> +		device_remove_file(dev, &sda_fan_input[i].dev_attr);
> +	}

It makes little sense to include the pwm loop inside the fan loop IMHO.
On the file creation side, this strange construct was done to test for
fan presence only once, but here the removal is unconditional, so
having seperate loops would work just as well, saving you one test and
one level of indentation.

> +	for (i = 0; i < 10; i++) {
> +		device_remove_file(dev, &sda_in_max[i].dev_attr);
> +		device_remove_file(dev, &sda_in_min[i].dev_attr);
> +		device_remove_file(dev, &sda_in_alarm[i].dev_attr);
> +		device_remove_file(dev, &sda_in_input[i].dev_attr);
> +	}
> +	for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays_fan4); i++)
> +		device_remove_file(dev, &sda_sf3_arrays_fan4[i].dev_attr);
> +	for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays); i++)
> +		device_remove_file(dev, &sda_sf3_arrays[i].dev_attr);
> +	hwmon_device_unregister(data->class_dev);

Grouping hwmon_device_unregister with the file deletions is a bit
awkward. It is something different, using a different parameter. I
would leave it outside.

We also discussed earlier on this list about the file creation vs.
hwmon class registration order, and agreed that the hwmon class should
be registered _after_ all the files are created, to avoid a race
condition where libsensors would (in the future) discover the interface
files before they are all created. Maybe you could do that change in
your patch as well as it affects the same code area. This would address
my previous point as well.

> +}

You seem to be deleting the files in the reverse order of creation?
There's no need to do that, and I find it slightly confusing.

Rest is just fine.

Thanks,
-- 
Jean Delvare

