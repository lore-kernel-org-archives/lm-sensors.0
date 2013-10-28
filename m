From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 28 Oct 2013 01:26:20 +0000
Subject: Re: [lm-sensors] Lenovo Yoga 13 with SMSC EMC2104 chip
Message-Id: <526DBD3C.1000403@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAK0txenpNcwmNh4UqTaBzYE8Tu5uns+2EoVALK2+gn9DGJPEkw@mail.gmail.com>
In-Reply-To: <CAK0txenpNcwmNh4UqTaBzYE8Tu5uns+2EoVALK2+gn9DGJPEkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 10/27/2013 03:45 PM, Igor Popik wrote:
> I was hoping that emc2103 driver will work for my Yoga 13 laptop with
> EMC2104 chip but I had no luck with sensors-detect nor loading the
> emc2103 driver manually (compiled with additional "debug" with no
> luck).
>
> isadump produces following output:
>
> sudo isadump -y -k 0x55 0x2e 0x2f
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 00 00 00 00 00 00 0f 00 00 00 00 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 85 19 08 01 00 00 00 00 00 00 00 00 01 00 00 00
> 30: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 04 04 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
> I'm sure that it is EMC2104 because I opened my laptop case and found
> that chip on mainboard. Any other things I could try?
>

Hi Igor,

Quite possible that you have an EMC2104 in your system.
However, that is an I2C chip, which you would not see with
isadump. The above seems to be an IT8519E, which is an
embedded controller from ITE.

Unfortunately, we neither support the IT8519E nor the EMC2104
at this time. It should be possible to add support for EMC2104
to the EMC2103 driver, but someone would have to implement it.
If you want to hack, you could add the emc2104 device id (0x1d)
and the emmc2104 I2C address (0x2f) to the driver. That _should_
give you access to some of the temperature sensors and to one
of the fan controllers. No guarantee, though.

Adding support for the ITE chip is all but impossible; the datasheet
is not available in public. Assuming it does provide any environmental
monitor functionality, your best chance would be an ACPI driver.
You could try loading the thinkpad_acpi driver to see if it works.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
