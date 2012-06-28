From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 28 Jun 2012 06:31:07 +0000
Subject: Re: [lm-sensors] Reducing fan speed for w83627ehf
Message-Id: <20120628083107.0d14c51a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAP3RjSfZQevwuBONgEbA0XaE_aiUik6sDdYY6ZJA+bWmZW1MQw@mail.gmail.com>
In-Reply-To: <CAP3RjSfZQevwuBONgEbA0XaE_aiUik6sDdYY6ZJA+bWmZW1MQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 27 Jun 2012 18:18:09 -0400, Arun Raghavan wrote:
> Writing 0 to pwm2 also keeps it at 1054 RPM. I'm setting pwm2_enable to 1,
> isn't that supposed to make it manual? Also, I do see a variation between
> 1054 RPM and 2109 RPM (and some steps in between), when I change pwm2. I
> can't get it to spin lower than 1054 RPM though.

4-wire fans (which are the most popular on CPU cooling blocks these
days) have an indirect interpretation of the PWM value, which means
that the fan maker is free to set the minimum speed (PWM = 0) to any
arbitrary limit they want. In best cases the value is clearly
documented in the product description sheet or accompanying technical
documentation.

1000 RPM is a relatively common value for the minimum speed of CPU
fans, so I'm not surprised by your observations. If this is too much
for you, you have to either lower the input voltage to the fan, or use
a different model altogether.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
