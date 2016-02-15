From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 15 Feb 2016 05:14:06 +0000
Subject: Re: [lm-sensors] [PATCH v2] ARM: dts: vfxxx: Add iio_hwmon node for ADC temperature channel
Message-Id: <56C15E9E.3070802@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <cd32f1664a04b38b8a025414d039bd015cb9a5ff.1455278754.git.maitysanchayan@gmail.com>
 <20160214083349.GR6756@tiger>
 <20160215044214.GA5545@Sanchayan-Arch.toradex.int>
In-Reply-To: <20160215044214.GA5545@Sanchayan-Arch.toradex.int>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: maitysanchayan@gmail.com, Shawn Guo <shawnguo@kernel.org>
Cc: stefan@agner.ch, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jdelvare@suse.com, lm-sensors@lm-sensors.org

On 02/14/2016 08:42 PM, maitysanchayan@gmail.com wrote:
> Hello Shawn,
>
> On 16-02-14 16:33:49, Shawn Guo wrote:
>> On Fri, Feb 12, 2016 at 05:53:00PM +0530, Sanchayan Maity wrote:
>>> Add iio_hwmon node to expose the temperature channel on Vybrid as
>>> hardware monitor device using the iio_hwmon driver.
>>>
>>> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
>>> ---
>>>
>>> Hello,
>>>
>>> The first version of the patch was send quite a while ago.
>>> https://lkml.org/lkml/2015/9/16/932
>>>
>>> Shawn you had requested that hyphen rather than underscore should
>>> be used in node name. I looked into that.
>>>
>>> The iio_hwmon driver calls hwmon_device register_with_groups inside
>>> hwmon.c and this
>>> http://lxr.free-electrons.com/source/drivers/hwmon/hwmon.c#L103
>>>
>>> does not allow hyphen in hwmon name attribute. I was not aware of
>>> this but while trying to test the change, the device probe failed
>>> with EINVAL. I think we should stick to the existing use of the
>>> bindings or we need to change the hwmon code as well along with the
>>> existing device tree files and binding documentation.
>>
>> I disagree.
>>
>> If hyphen is invalid to be part of hwmon name attribute, the following
>> code in iio_hwmon_probe() is plain wrong, because hyphen is very valid
>> to be part of node names in device tree.
>>
>>          if (dev->of_node && dev->of_node->name)
>>                  name = dev->of_node->name;
>
> @Shawn
> I agree with what you state here, however as you can see the hwmon_device_
> register_with_groups does check for hypen with strpbrk and returns EINVAL.
> Changing to hyphen instead of currently present underscore in iio_hwmon
> node name causes probe failure.
>
> If the node name needs to have hyphen, then the check for hyphen as an invalid
> character in hwmon name attribute needs to be changed. I am CC'ing the hwmon
> subsystem maintainers Jean Delvare ands Guenter Roeck as well as hwmon list to
> check.
>
> @Jean & Guenter
> Can you please comment if the change to hwmon_device_register_with_groups
> to accept hyphen as a valid character in hwmon name attribute will be acceptable?

User space would not like the '-' and get confused.

We'll have to change the above code and replace '-' with '_' in the name if/when
it is seen. Sorry, I didn't realize the problem when I wrote that code.

Guenter

> Sorry if this is sudden andfor bringing you late into the discussion Jean and
> Guenter.
>
> Thanks & Regards,
> Sanchayan.
>
>>
>> Shawn
>>
>>>
>>> Changes since v1:
>>> 1. Expose ADC1 temperature channel as well
>>> 2. Move the entry outside of the aips1 bus node
>>>
>>> Best Regards,
>>> Sanchayan Maity.
>>> ---
>>>   arch/arm/boot/dts/vfxxx.dtsi | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
>>> index a5f07e3..8ed8e47 100644
>>> --- a/arch/arm/boot/dts/vfxxx.dtsi
>>> +++ b/arch/arm/boot/dts/vfxxx.dtsi
>>> @@ -673,5 +673,10 @@
>>>   				status = "disabled";
>>>   			};
>>>   		};
>>> +
>>> +		iio_hwmon {
>>> +			compatible = "iio-hwmon";
>>> +			io-channels = <&adc0 16>, <&adc1 16>;
>>> +		};
>>>   	};
>>>   };
>>> --
>>> 2.7.1
>>>
>>>
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
