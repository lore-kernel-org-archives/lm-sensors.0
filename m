From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 16 Feb 2014 16:39:54 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: twl4030-madc-hwmon: Add device tree support.
Message-Id: <5300E9DA.501@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392384058-14240-1-git-send-email-marek@goldelico.com>	<20140214133101.GA17796@e106331-lin.cambridge.arm.com> <CAAfyv36Eo578K1LAdFJdKKjs800Gz2_kfJqvEcdD_U1qRCKY6w@mail.gmail.com>
In-Reply-To: <CAAfyv36Eo578K1LAdFJdKKjs800Gz2_kfJqvEcdD_U1qRCKY6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Belisko Marek <marek.belisko@gmail.com>, Mark Rutland <mark.rutland@arm.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "rob@landley.net" <rob@landley.net>, "jdelvare@suse.de" <jdelvare@suse.de>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "hns@goldelico.com" <hns@goldelico.com>

On 02/14/2014 06:08 AM, Belisko Marek wrote:
> On Fri, Feb 14, 2014 at 2:31 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> On Fri, Feb 14, 2014 at 01:20:58PM +0000, Marek Belisko wrote:
>>> Signed-off-by: Marek Belisko <marek@goldelico.com>
>>> ---
>>>   Documentation/devicetree/bindings/hwmon/twl4030-madc-hwmon.txt |  9 +++++++++
>>>   drivers/hwmon/twl4030-madc-hwmon.c                             | 10 ++++++++++
>>>   2 files changed, 19 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/hwmon/twl4030-madc-hwmon.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/hwmon/twl4030-madc-hwmon.txt b/Documentation/devicetree/bindings/hwmon/twl4030-madc-hwmon.txt
>>> new file mode 100644
>>> index 0000000..e8016d1
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/hwmon/twl4030-madc-hwmon.txt
>>> @@ -0,0 +1,9 @@
>>> +TWL4030 MADC hwmon.
>>> +
>>> +Required properties:
>>> +- compatible: "ti,twl4030-madc-hwmon"
>>> +
>>> +Example:
>>> +madc-hwmon {
>>> +     compatible = "ti,twl4030-madc-hwmon";
>>> +};
>>
>> Huh?
>>
>> What is this a binding for? From a look at the driver in mainline this
>> just calls into functions from the twl4030 madc driver (which doesn't
>> seem to have a binding).
> I post bindings for twl4030-madc [1]. Without probing this driver
> other things will not work (twl4030-madc-battery e.g.).
> Is there better way to handle this situation?

Since you are converting twl4030-madc to be an iio driver,
can't you simply use the iio_hwmon bridge and declare this driver
obsolete ?

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
