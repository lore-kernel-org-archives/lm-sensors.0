From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 19 Feb 2014 02:55:00 +0000
Subject: Re: [lm-sensors] W83627DHG-P sensor shows a single voltage monitor for +5V and +12V on in4?
Message-Id: <53041D04.7000601@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
In-Reply-To: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/18/2014 06:27 PM, ianp wrote:
>> On Wednesday, February 19, 2014 10:00 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>
Please don't drop the mailing liost from your replies.

>> That is not the same address, it is the same raw value.
>> The voltage registers are at address 0x20 .. 0x26 in above table.
>>
>
> Hmmm, I must have been looking at it the wrong way then. So if it's the raw value that is the same for both monitors, can I trust that the +5V and +12V values are accurate?
>
Ultimately you can only trust it to the point you trust the board vendor.
The chip reports what it gets on its input pins, but the board vendor
determines what is connected to those pins.

> Lastly, how can you separately show +5V and +12V in lm-sensors if both share a sinlge monitor on in4?
>

They don't. hwmonitor in Windows gives you the correct mapping for your board.

     Voltage 0    1.11 Volts [0x8B] (CPU VCORE)
     Voltage 1    0.69 Volts [0x56] (VIN1)
     Voltage 2    3.30 Volts [0xCE] (+3.3V)
     Voltage 3    4.97 Volts [0xCF] (+5V)
     Voltage 4    11.54 Volts [0xCF] (+12V)
     Voltage 5    1.69 Volts [0xD3] (VIN5)
     Voltage 6    1.90 Volts [0xED] (VIN6)

where Voltage X maps to inX.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
