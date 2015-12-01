From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 01 Dec 2015 15:02:55 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] iio: ina2xx: add support for TI INA2xx Power Monitors
Message-Id: <565DB69F.9000406@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1448450896-24387-1-git-send-email-mtitinger@baylibre.com>
 <1448450896-24387-2-git-send-email-mtitinger@baylibre.com>
 <565B287B.6010008@kernel.org> <565B381F.7000208@roeck-us.net>
 <565D7014.4020806@baylibre.com>
In-Reply-To: <565D7014.4020806@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marc Titinger <mtitinger@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, jdelvare@suse.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On 12/01/2015 02:01 AM, Marc Titinger wrote:
> On 29/11/2015 18:38, Guenter Roeck wrote:
>> On 11/29/2015 08:31 AM, Jonathan Cameron wrote:
>>> On 25/11/15 11:28, Marc Titinger wrote:
>>>> in SOFTWARE buffer mode, a kthread will capture the active scan_elements
>>>> into a kfifo, then compute the remaining time until the next capture
>>>> tick
>>>> and do an active wait (udelay).
>>>>
>>>> This will produce a stream of up to fours channels plus a 64bits
>>>> timestamps (ns).
>>>>
>>>> Tested with ina226, on BeagleBoneBlack.
>>>>
>>>> Datasheet: http://www.ti.com/lit/gpn/ina226
>>>>
>>>> Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
>>> A few more bits from me, but basically looking good.
>>>
>>> We do however, need to make the hwmon guys aware this is going on.
>>> Please cc their list on the next version.
>>>
>>> Last thing we want is for this to turn up as a surprise!
>>>
>>
>> I have seen the original patch, so no surprise here. Just not sure
>> if we should remove the hwmon driver after the iio driver is accepted.
>> Even though the stated goal is different, it seems to me that having
>> two drivers really does not make sense. Any thoughts ?
>
> Hi Guenter,
>
> we for instance have two completely unrelated projects both using this chip, on one side we wish to measure power consumption on the host board and hwmon has the apis and tool ecosystem for it, while on the "ACME" system we needed IIO because it's buffer streaming scheme and remote features saves the day to create a lab instrument. But really both have their use, I'd recommend keeping the hwmon driver for now. I doubt those drivers will generate much maintenance work in the future either.
>

Marc,

You can use the iio-hwmon bridge to get the hwmon ABI from the iio driver.
There is no need to keep the hwmon driver as a separate entity for that.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
