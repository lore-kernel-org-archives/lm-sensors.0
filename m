From: Luca Tettamanti <kronos.it@gmail.com>
Date: Mon, 24 Jan 2011 21:45:36 +0000
Subject: Re: [lm-sensors] insane readings on Asus A7M266 motherboard
Message-Id: <AANLkTikinBWq9ZVjBiBU4RbkkVQQ+sx08pRo7DTg8Kh2@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <761574.42437.qm@web36601.mail.mud.yahoo.com>
In-Reply-To: <761574.42437.qm@web36601.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jan 24, 2011 at 10:41 PM, Audio Phile <da_audiophile@yahoo.com> wrote:
>> --- On Mon, 1/24/11, Jean Delvare <khali@linux-fr.org> wrote:
>>
>> The VIA Pro SMBus isn't probed, meaning that the driver failed to bind
>> to the device. You should see some error message in the kernel logs
>> when i2c-viapro is loaded.
>>
>> One possible cause is an ACPI resource conflict [1]. I am a little
>> surprised as I didn't expect this kind of problem on such an old board.
>> If this is the case, booting with acpi_enforce_resources=lax should
>> solve your problem.
>
> Thank you!  This absolutely solved my problem!

Ok, now I'm curious :) Probably it's the ACPI thermal zone.
Can you send me a copy of /sys/firmware/acpi/tables/DSDT?

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
