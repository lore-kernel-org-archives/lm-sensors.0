From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Date: Mon, 08 Jun 2015 06:01:57 +0000
Subject: Re: [lm-sensors] Dealing with optional i2c devices in a devicetree
Message-Id: <55752FD4.6050700@alliedtelesis.co.nz>
List-Id: <lm-sensors.vger.kernel.org>
References: <55713BB1.80004@alliedtelesis.co.nz>
 <55714FFB.3000608@roeck-us.net>
In-Reply-To: <55714FFB.3000608-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "jdelvare-l3A5Bk7waGM@public.gmane.org" <jdelvare-l3A5Bk7waGM@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "shardy-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <shardy-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "guillaume.roguez-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org" <guillaume.roguez-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>

Thanks to those who replied.

On 06/05/2015 07:30 PM, Guenter Roeck wrote:
> Hi Chris,
>
> On 06/04/2015 11:03 PM, Chris Packham wrote:
>> Hi,
>>
>> I'm working on a new board and one feature it as is a plug-in module
>> with an ADS7830 voltage monitor on it. This will be used during
>> manufacturing to sanity check that various voltage rails are within
>> expected ranges.
>>
>> I have a dts entry for the device as below (with some omissions for the
>> sake of clarity)
>>
>>     soc {
>>         internal-regs {
>>             i2c@11000 {
>>                 ads7830@48 {
>>                     compatible = "ads7830";
>>                     reg = <0x48>;
>>                 };
>>             };
>>         };
>>     };
>>
>> The problem is that when the manufacturing card is not installed the
>> device still shows up in /sys/class/hwmon/hwmon0/ and
>> /sys/bus/i2c/devices/0-0048/ despite it not actually being present. If I
>> was using an old style initialization I could use
>> i2c_new_probed_device() which I think would stop the drivers probe()
>> function from being called
>>
>> Looking at the ads7828_probe() function it doesn't actually do anything
>> with the i2c device before calling hwmon_device_register(). Some hwmon
>> drivers like lm73_probe() do attempt to read from the device and bail if
>> the read fails. I can probably fix my problem by doing something similar
>> in the ads7828_probe(), but there are other drivers that have a similar
>> probe function.
>>
> But that would be artificial in this case, and it could not be used to
> really
> detect the chip but would only prove that there is a chip at the
> selected i2c
> address. This is not really useful.
>
>> Is there a better way of getting the devicetree machinery to avoid the
>> call to the driver probe function in the first place?
>>
>
> The easiest solution would probably be to drop the entry from the
> devicetree file and instantiate the driver manually via sysfs when
> needed. Another option would be to load a different devicetree file
> if the chip is plugged in.
>
> You might also be able to use a devicetree overlay, but that would
> probably add too much complexity if the chip is only used in
> manufacturing.

Sounds like my best bet is to mark the nodes as disabled in the dts and 
have my bootloader update them on the way through.
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
