From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 28 Jun 2012 16:30:17 +0000
Subject: Re: [lm-sensors] Reducing fan speed for w83627ehf
Message-Id: <20120628183017.4946234b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAP3RjSfZQevwuBONgEbA0XaE_aiUik6sDdYY6ZJA+bWmZW1MQw@mail.gmail.com>
In-Reply-To: <CAP3RjSfZQevwuBONgEbA0XaE_aiUik6sDdYY6ZJA+bWmZW1MQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 28 Jun 2012 12:21:40 -0400, Arun Raghavan wrote:
> On Thu, Jun 28, 2012 at 2:31 AM, Jean Delvare <khali@linux-fr.org> wrote:
> > 1000 RPM is a relatively common value for the minimum speed of CPU
> > fans, so I'm not surprised by your observations. If this is too much
> > for you, you have to either lower the input voltage to the fan, or use
> > a different model altogether.
>
> Thanks, that makes sense. Can I control the input voltage through
> software/some sysfs attribute or do I have to do it from the supply?

You have to hack it physically, typically by adding a serial resistor.
Some vendors ship such adapters with their fans. I got mine from Noctua
but these are 3-pin, not 4-pin ones so it wouldn't help you. Zalman
also has 3-pin model [1] but apparently no 4-pin model :(

[1] http://www.zalman.com/ENG/product/Product_Read.asp?idx"3

If there's a way to reduce the voltage by software, it would be totally
board specific (using a custom DAC device) and not supported.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
