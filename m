From: Wei Ni <wni@nvidia.com>
Date: Wed, 20 Feb 2013 10:36:00 +0000
Subject: Re: [lm-sensors] [RFC PATCH 5/9] Thermal: Support using dt node to get sensor
Message-Id: <5124A710.1050205@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com> <1361187031-3679-6-git-send-email-wni@nvidia.com> <512406F0.4080708@wwwdotorg.org>
In-Reply-To: <512406F0.4080708-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthew Longnecker <MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>

On 02/20/2013 07:12 AM, Stephen Warren wrote:
> On 02/18/2013 04:30 AM, Wei Ni wrote:
>> Add functions to support using dt node with args to get sensor.
> 
> You need to write a device tree binding document to explain this.
> 
>> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> 
>> +struct thermal_sensor *get_sensor_by_node(struct node_args *np_args)
>> +{
>> +	struct thermal_sensor *pos;
> 
> "pos" isn't a great variable name. Why not use "sensor", or just the
> "ts" variable you have right below?

Oh, yes, it can just use "ts" simply. I didn't consider it, thanks.

> 
>> +	struct thermal_sensor *ts = NULL;
>> +	struct node_args *args;
>> +
>> +	mutex_lock(&sensor_list_lock);
>> +	for_each_thermal_sensor(pos) {
>> +		args = &pos->np_args;
>> +		if (args->np) {
>> +			if ((args->np = np_args->np) &&
>> +			   (args->index = np_args->index)) {
>> +				ts = pos;
>> +				break;
> 
> Replace those 2 lines with "goto out;".
> 
>> +			}
>> +		}
>> +	}
> 
> here, add:
> 
> 	ts = NULL;
> out:
> 
> That way, you can use "ts" as the loop iteration variable.
> 
> This whole patch rather assumes that all DT nodes can identify their
> exposed thermal sensors using an index in a single DT cell. That's not
> very flexible. All other DT bindings work like this:
> 
> Provider of a service indicates how many DT cells are in the object
> (GPIO, IRQ, thermal sensors) specifier:
> 
> sensor1: lm90@1c {
> 	...
> 	#thermal-sensor-cells = <1>;
> };
> 
> Each consumer of a service imports it by referencing it:
> 
> thermal-zone {
> 	...
> 	sensors = <&sensor1 0>;
> };
> 
> The driver for LM90 provides an "of_xlate" function which receives a
> struct of_phandle_args and outputs/returns whatever Linux-internal
> identification/representation of the object is required. For example, see:
> 
>> include/linux/pwm.h:161:	struct pwm_device *	(*of_xlate)(struct pwm_chip *pc,
> 
> This allows each providing object's DT binding to define its own value
> of #thermal-sensor-cells, as suited for its own requirements, and allows
> each driver to implement the mapping from DT to internal ID in whatever
> way is necessary.
> 
> Now, many bindings/drivers might just end up using a common simple
> implementation. That's why functions such as of_pwm_simple_xlate() or
> of_gpio_simple_xlate() exist.

It looks like the "of_xlate" can handle the sensor identification.
I'm not familiar with this function, I will look into it and try to use.
Thanks for your comments.

Wei.

> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
