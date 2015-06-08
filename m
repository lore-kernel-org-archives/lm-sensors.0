From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Date: Mon, 08 Jun 2015 06:01:42 +0000
Subject: Re: [lm-sensors] Dealing with optional i2c devices in a devicetree
Message-Id: <55752FC5.3040004@alliedtelesis.co.nz>
List-Id: <lm-sensors.vger.kernel.org>
References: <55713BB1.80004@alliedtelesis.co.nz> <2658431.5aULpGi9jh@wuerfel>
In-Reply-To: <2658431.5aULpGi9jh@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "jdelvare-l3A5Bk7waGM@public.gmane.org" <jdelvare-l3A5Bk7waGM@public.gmane.org>, "linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org" <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "shardy-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <shardy-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "guillaume.roguez-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org" <guillaume.roguez-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>



On 06/05/2015 07:26 PM, Arnd Bergmann wrote:
> On Friday 05 June 2015 06:03:30 Chris Packham wrote:
>>
>> Is there a better way of getting the devicetree machinery to avoid the
>> call to the driver probe function in the first place?
>>
>>
>
> The newly added DT overlay support should do what you need, but it might
> not be the easiest solution.
>
> To start out with the device not getting probed at first, add a
> 'status="disabled"' property, which will prevent the i2c_device from
> getting added. At runtime you then need a way to change that from
> "disabled" to "ok" and retrigger the probe. I haven't done that myself,
> so it might need some i2c core changes to work correctly.
>

So I pursued this idea a little.

I set the node to status = "disabled" in the dts. Then I added some code 
to probe for the i2c device using
i2c_probe_func_quick_read() and updated the device tree to remove the 
status property based on the result of the probe.

Then I was able to call of_platform_populate(node->parent, ...). This 
got me as far as the platform device being created but none of the i2c 
or hwmon code kicked in. I may have missed something, perhaps the 
platform bus needs to be re-probed now that there is a new device.

I think I'll look at updating the device tree passed by the bootloader 
which should be easier to do at this point.

For future (and current) mailing list readers this is the gist of my 
detect function.

static void board_detect(struct device *dev)
{
	struct i2c_adapter *adap = i2c_get_adapter(0);

	/* Ugly hack. The ads7830 device is a SMBUS device at 0x48.
	 * SMBUS is not i2c but the quick read should be OK-ish.
	 */
	if (i2c_probe_func_quick_read(adap, 0x48)) {
		int ret;
		struct device_node *node;

		dev_info(dev, "board detected");
		for_each_compatible_node(node, NULL, "ads7830") {
			struct property *prop;
			const struct of_device_id match_table[] = {
				{ .compatible = "ads7830", },
				{} /* Empty terminated list */
			};

			prop = of_find_property(node, "status", NULL);
			if (prop)
				of_remove_property(node, prop);

			ret = of_platform_populate(node->parent,
						   match_table,
						   NULL, NULL);
			if (ret)
				dev_err(dev, "populate failed\n");
		}
	}

	i2c_put_adapter(adap);
	return;
}
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
