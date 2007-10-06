From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 06 Oct 2007 21:47:30 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-fschmd-new-driver.patch
Message-Id: <20071006234730.2847a4f5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46F3D714.1030104@hhs.nl>
In-Reply-To: <46F3D714.1030104@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 06 Oct 2007 21:40:55 +0200, Hans de Goede wrote:
> Thanks! I agree with most comments and will address them with a new version 
> asap. I have questions about a few of them, see below.
> Further more I've been thinking about replacing:
> 
> 		/* Poseidon doesn't have TEMP_LIMIT registers */
> 		if (kind = fscpos && (i % 4) = 1)
> 			continue;
> 
> with (pseudo code for now):
> 		/* Poseidon doesn't have TEMP_LIMIT registers */
> 		if (kind = fscpos &&
> 			sscanf(fschmd_temp_attr[i].dev_attr.attr.name,
> 				"temp%d_ma%c", &dummy, &dummy) = 2)
> 			continue;
> 
> In this context:
> 	for (i = 0; i < (FSCHMD_NO_TEMP_SENSORS[data->kind] * 4); i++) {
> 		/* Poseidon doesn't have TEMP_LIMIT registers */
> 		if (kind = fscpos && (i % 4) = 1)
> 			continue;
> 		
> 		err = device_create_file(&new_client->dev,
> 					&fschmd_temp_attr[i].dev_attr);
> 		if (err)
> 			goto exit_remove_files;
> 	}
> 
> With the idea that the replacement code is better readable, and is (somewhat) 
> resistent against adding attributes to the array. I'm not sure though, is this 
> a change for the better or does it make things worse?

Worse. sscanf is very slow compared to a modulo, and your pseudo-code
above isn't that robust either. For example your sscanf would match an
hypothetical temp1_max_hyst. And it's everything but elegant anyway.

I agree that your original code isn't very robust, but if you want to
make it better, I'd rather suggest one of the following approaches:

* Move the conditional attributes to a dedicated array and instantiate
  them separately.

* Test for kind = fscpos && fschmd_temp_attr[i].dev_attr.show =
  show_temp_max.

> >> + *  Scylla, Heracles and Heimdall chips
> >> + *
> >> + *  Based on the original 2.4 fscscy, 2.6 fscpos, 2.6 fscher and 2.6
> >> + *  (candidate) fschmd drivers:
> >> + *  Copyright (C) 2006 Thilo Cestonaro <thilo.cestonaro.external@fujitsu-siemens.com>
> > 
> > Line longer than 80 columns.
> 
> Suggestions for breaking it up, without things becoming ugly? I think since 
> this is just a comment its best left as is.

I agree that it's not easy to break. That's probably the longest e-mail
address I've seen ;) Belonging to a human being, at least.

> >> +/*
> >> + * Sysfs attr show / store functions
> >> + */
> >> +
> >> +static ssize_t show_in_value(struct device *dev,
> >> +	struct device_attribute *devattr, char *buf)
> >> +{
> >> +	const int max_reading[3] = { 14200, 6600, 3300 };
> > 
> > Could be static.
> 
> With what advantage? Its const so it goes to the code segment, so no stack 
> usage, or am I missing something here?

You're right, just ignore me.

> >> +	struct fschmd_data *data;
> >> +	u8 revision;
> >> +	const char *names[5] = { "Scylla", "Poseidon", "Hermes", "Heracles",
> >> +			"Heimdall" };
> > 
> > Could be static.
> 
> Or constify the pointers with the same result as above? Which one is prefered?

Either way is fine with me.

> >> +	strlcpy(new_client->name, FSCHMD_NAME, I2C_NAME_SIZE);
> > 
> > No! The _client_ name goes there, not the driver name. You want the
> > Poseidon to appear as "fscpos", etc.
> 
> AFAIK this determines what gets put in the name sysfs attribute, do I have this 
> correct? I'm asking because in that case putting in fscpos, fscher or fscscy is 
> not an option as libsensors and sensors 2.x have certain expectations about the 
> old driver, they expect various non Documentation/hwmon/sysfs-interface 
> compliant attributes to be there. If I'm mistaken and this is not what gets put 
> in the name sysfs attr, then I'll modify it, otherwise we need another 
> solution, maybe something not pretty like fscpos-new, fscher-new, etc.

You are right, the client name is used for the name attribute, and we
want this attribute to reflect the actual chip type. Using "fschmd" for
all FSC chips would be very confusing. And unnecessary. If libsensors
2.x has problems with your driver, we'll fix libsensors 2.x. I see no
major incompatibility between the old drivers and the new driver, you
even preserved the fan channel order, so it should be doable. The only
difference I can think of is the alarms, we can just ignore them when
they are missing.

So, no "-new" suffix please, just use fscpos, fscher etc. and we'll
deal with it.

> >> +MODULE_AUTHOR("Hans de Goede <j.w.r.degoede@hhs.nl>");
> >> +MODULE_DESCRIPTION("FSC Poseidon, Hermes, Scylla, Heracles and Heimdall driver");
> >> +MODULE_LICENSE("GPL");
> > 
> > MODULE_DESCRIPTION Line longer that 80 characters.
> 
> I don't know how stringent the guidelines are when it comes to the 80 chars 
> limit, but to me breaking the MODULE_DESCRIPTION line up doesn't improve the 
> readability.

The guidelines are rather strict:

"The limit on the length of lines is 80 columns and this is a hard limit."

(Which doesn't mean that it is always enforced though...)

You can split strings in C, so this one is easy:

MODULE_DESCRIPTION("FSC Poseidon, Hermes, Scylla, Heracles and "
		   "Heimdall driver");

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
