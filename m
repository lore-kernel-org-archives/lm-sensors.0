From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 29 Jan 2013 20:00:55 +0000
Subject: Re: [lm-sensors] MAX1363 IIO driver questions
Message-Id: <20130129200055.GA18207@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121124052707.GA17392@roeck-us.net>
 <50B09EDC.4020200@kernel.org>
 <20130116054918.GA7056@roeck-us.net>
 <50F667C9.6000106@jic23.retrosnub.co.uk>
 <20130117204549.GB22045@roeck-us.net>
 <8649d873-66ef-4b0f-a22d-8480e5aa1ead@email.android.com>
 <20130118220922.GB12459@roeck-us.net>
 <5103BD2F.30405@kernel.org>
In-Reply-To: <5103BD2F.30405@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>, linux-iio@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org

On Sat, Jan 26, 2013 at 11:25:35AM +0000, Jonathan Cameron wrote:
> On 01/18/2013 10:09 PM, Guenter Roeck wrote:
> > On Thu, Jan 17, 2013 at 09:03:58PM +0000, Jonathan Cameron wrote:
> >>
> >> Good point. New use case for us so suggestions on how to do the association cleanly would be most welcome. Is there anything similar out there? We could add a per iio device sysfs interface to add additional mappings but it is a little uggly...
> >>
> > 
> > Best idea I can come up with is to disconnect iio_hwmon from the requirement to
> > instantiate it explicitly. There might be two sysfs entries - one to
> > attach it to a specific iio device, and one to attach it to individual channels
> > of an iio device. Similar like the new_device interface on i2c adapters, and
> > along the line of
> > 
> > echo max1139 something > /sys/module/iio_hwmon/something_else
> 
> We'll have to have something more specific or the common case of more than
> one instance of an adc will cause trouble.  Obviously this doesn't matter
> doing by adding the map from the IIO side.
> 
> > 
> > and/or
> > 
> > echo max1139 something channel > /sys/module/iio_hwmon/something_else
> > 
> > ie sysfs attributes associated with iio_hwmon, not with the iio device itself.
> > 
> This will play havock with the way the internal mappings work.  Originally
> we had it mapped from both sides by name (e.g. the map wasn't in any way
> handled by either driver) but that got an awful lot of flack and really
> wasn't considered acceptable.  The current version of treating it much like
> regulators etc is much cleaner.
> 

I think I am giving up on testing the code on a non-embedded system;
I would need/use manual instantiation only for testing, and it seems too
difficult to implement and not really worth it. I'll focus on getting it
to work with OF.

The current approach, with iio_hwmon requesting its assigned mappings through 
io_channel_get_all(), does not work well for me for a number of reasons.

First, it is difficult to associate device references in OF with actual device
names. I don't know if you have tried, but while a reference to &iio_hwmon can
uniquely identify the device name for an OF entry such as

	iio_hwmon: iio_hwmon@0 {
		compatible = "iio-hwmon";
	};

it is difficult to predict how the actual iio_hwmon device name looks like.
Amongst others, it depends if there are additional attributes such as "reg = <>",
on the value of "@x" (if specified) and other attributes I have not really tracked
down yet. In other words, when I tried to create a device named "iio_hwmon.0",
I managed to get all kinds of device names except for "iio_hwmon.0".

Also, the iio_hwmon driver does not know which consumers are assigned to it.
If it is instantiated before the ADC driver (which happens all the time for me,
as iio_hwmon does not have to wait for the i2c bus adapter), its call to
iio_channel_get_all() returns nothing. Even if it does return some mappings,
there is no guarantee that the mappings are complete (eg if an instance of
iio_hwmon is mapped to ADC channels from multiple chips).

Other subsystems solve that problem by having the consumer request the resources
it needs. The leds-gpio driver is an excellent example: It knows from its OF data
which gpio pins it needs and requests those. If the pins are not available,
it gets an -EPROBE_DEFER error from the gpio subsystem, and simply defers
its probe until the missing pins are available.

The question for me is really if it would be possible to implement the same
approach for the iio subsystem. I would then specify something like

	max1139: max1139@35 {
        	compatible = "maxim,max1139";
		reg = <0x35>;
	};

...
	iio_hwmon {
		compatible = "iio-hwmon";

		in0 {
			label = "vin";
			iio-map = { &max1139 0 }; /* adc channel 0 */
		};
		in1 {
			label = "vout";
			iio-map = { &max1139 1 }; /* adc channel 1 */
		};
		...
	};

which would then map into in0/in1 hwmon attributes (with optional "vin" and
"vout" labels if specified).

Problem here is that io_channel_get() currently does not use the provider name
as argument to find the resource. Instead, it uses consumer_dev_name and/or
consumer_channel. I am not sure how to solve that problem. It would be much more
helpful if the provider would not be tied to the consumer from provider side,
but from consumer side, and the mapping would be based on provider device and
index (or something else such as ADC channel name if that is preferred).

Would this kind of solution be acceptable for the iio maintainers ? Is it
even possible, given that the provider has to currently provide the mapping
to its intended consumers using iio_map_array_register() ?

I have a number of additional questions regarding the max1363 driver (eg how to
initialize the chip from of data, and if the regulator always _has_ to be vcc),
but those are really minor problems we can address later. Right now I'll have to
find a solution for the above problems.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
