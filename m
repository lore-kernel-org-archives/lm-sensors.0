From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 12 Jan 2015 17:25:37 +0000
Subject: Re: [lm-sensors] randconfig build error with next-20150112, in drivers/hwmon/gpio-fan.c
Message-Id: <20150112172537.GA19868@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CA+r1Zhh4EXQ_0pYZfL4jB=F8unP7+jzp7LVL2RRL+urU3srj3A@mail.gmail.com>
In-Reply-To: <CA+r1Zhh4EXQ_0pYZfL4jB=F8unP7+jzp7LVL2RRL+urU3srj3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jim Davis <jim.epost@gmail.com>
Cc: linux-next <linux-next@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, jdelvare@suse.de, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, lm-sensors@lm-sensors.org, devicetree <devicetree@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Eduardo Valentin <edubezval@gmail.com>

On Mon, Jan 12, 2015 at 09:53:05AM -0700, Jim Davis wrote:
> Building with the attached random configuration file,
> 
> drivers/built-in.o: In function `gpio_fan_remove':
> gpio-fan.c:(.text+0x6efea): undefined reference to
> `thermal_cooling_device_unregister'
> drivers/built-in.o: In function `gpio_fan_probe':
> gpio-fan.c:(.text+0x6f376): undefined reference to
> `thermal_cooling_device_register'
> make: *** [vmlinux] Error 1

Hi Jim,

thanks for the note.

Hmm .. turns out those functions don't define dummies if CONFIG_THERMAL
is not configured. How annoying.

Nishant, please fix your gpio-fan patch. I am going to drop it for now.
Please keep in mind that there is a secondary dependency: The thermal
code can be built as module. In that case, the gpio-fan driver must
either also be built as module, or its thermal registration must be
disabled.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
