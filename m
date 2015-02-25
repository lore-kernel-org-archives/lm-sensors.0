From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 25 Feb 2015 04:18:07 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (jc42) Add support for additional IDT temperature sensors
Message-Id: <54ED4CFF.8080601@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1423769172-13519-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1423769172-13519-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/24/2015 02:19 PM, Jean Delvare wrote:
> On Tue, 24 Feb 2015 10:14:04 -0800, Guenter Roeck wrote:
>> On Mon, Feb 23, 2015 at 08:52:47PM +0100, Jean Delvare wrote:
>>> On Thu, 12 Feb 2015 11:26:12 -0800, Guenter Roeck wrote:
>>>> TS3000GB0 has a new device ID (0x2913). Since IDT's datasheets suggest
>>>> that the upper 8 bit of the device ID reflect the chip ID and the lower
>>>> 8 bit reflect the version number, modify the code to accept all chips
>>>> with ID 0x29xx.
>>>
>>> You did that for all other IDT chips as well. While this is in
>>> accordance with the datasheets, this might lead to some false
>>> positives, as the driver probes 8 popular I2C addressed and the
>>> detection code doesn't check for that many bits anymore.
>>>
>>> That being said I don't have a strong feeling about it. We can leave it
>>> this way for now and revisit it later if false positives are actually
>>> reported.
>>
>> We could check some other registers instead; the limit registers
>> have five unused bits. Would it make sense to check those ?
>
> That makes sense, however every register being read adds up to the
> probe time, so we have to be reasonable. Which is why I am generally
> fine with leaving the code as is until actual false positives are
> reported. But then again I am fine either way so if you prefer to check
> the limit registers now, just do that.
>

I think I'll leave it as is for now.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
