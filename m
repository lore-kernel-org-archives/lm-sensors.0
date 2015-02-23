From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 23 Feb 2015 14:43:16 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (gpio-fan) allow to use alarm support alone from DT
Message-Id: <54EB3C84.30503@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1424696334-14767-1-git-send-email-simon.guinot@sequanux.org>
 <54EB33D4.1000804@roeck-us.net> <20150223143416.GT1509@kw.sim.vm.gnt>
In-Reply-To: <20150223143416.GT1509@kw.sim.vm.gnt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 02/23/2015 06:34 AM, Simon Guinot wrote:
> On Mon, Feb 23, 2015 at 06:06:12AM -0800, Guenter Roeck wrote:
>> On 02/23/2015 04:58 AM, Simon Guinot wrote:
>>> On some boards, such as the LaCie 2Big Network v2 or 2Big NAS (based on
>>> Marvell Kirkwood SoCs), an I2C fan controller is used but the alarm
>>> signal is wired to a separate GPIO. Unfortunately, the gpio-fan driver
>>> can't be used to handle GPIO alarm alone from DT: an error is returned
>>> if the "gpios" DT property is missing.
>>>
>>> This patch allows to use the gpio-fan driver even if the "alarm-gpios"
>>> DT property is defined alone.
>>>
>>
>> That is the wrong solution. The gpio alarm signal should be handled
>> by the fan controller driver.
>
> Hi Guenter,
>
> Sure it should, but unfortunately it is not the case. I have several
> boards using this mechanism (ie: a separate fan alarm GPIO). I think the
> idea was to reduce the board cost...
>
Well, yes, the driver for the fan controller chip needs to be updated
to support interrupts.

> Then this means I need a way to support this alarm signal and I can't
> find a better one than using gpio-fan. Note that this was possible with
> the original gpio-fan implementation (before the DT binding addition).
>

That doesn't help.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
