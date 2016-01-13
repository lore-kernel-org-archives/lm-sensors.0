From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 13 Jan 2016 13:57:28 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: Add LTC2990 sensor driver
Message-Id: <569657C8.6070607@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <568FD131.4080308@roeck-us.net>
 <1452067627-24939-1-git-send-email-mike.looijmans@topic.nl>
 <1452683150-27747-1-git-send-email-mike.looijmans@topic.nl>
 <5696500E.4090905@roeck-us.net> <56965661.2010307@topic.nl>
In-Reply-To: <56965661.2010307@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Looijmans <mike.looijmans@topic.nl>, lm-sensors@lm-sensors.org
Cc: jdelvare@suse.com, linux-kernel@vger.kernel.org

On 01/13/2016 05:51 AM, Mike Looijmans wrote:
> On 13-01-16 14:24, Guenter Roeck wrote:
>> On 01/13/2016 03:05 AM, Mike Looijmans wrote:
>>> This adds support for the Linear Technology LTC2990  I2C System Monitor.
>>> The LTC2990 supports a combination of voltage, current and temperature
>>> monitoring. This driver currently only supports reading two currents
>>> by measuring two differential voltages across series resistors, in
>>> addition to the Vcc supply voltage and internal temperature.
>>>
>>> This is sufficient to support the Topic Miami SOM which uses this chip
>>> to monitor the currents flowing into the FPGA and the CPU parts.
>>>
>>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>
>> Mike,
>>
>> That looks much better. Can you send me the output of i2cdump for the chip ?
>> That would help me writing module test code for it.
>
> I'm kinda interested into how that would work.
>
https://github.com/groeck/module-tests

> I'll have to remove the driver first to get i2cdump to work on the chip. I cannot force a device removal from user space while running, can I?
> And i suppose you want a dump of a chip in running status? (On boot, all are registers are simply set to zero)
>

Just use i2cdump -f while the driver is active.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
