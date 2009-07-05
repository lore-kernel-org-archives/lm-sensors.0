From: Christopher Hogan <chris.c.hogan@gmail.com>
Date: Sun, 05 Jul 2009 17:02:31 +0000
Subject: Re: [lm-sensors] w83627hf Device needs an ACPI driver
Message-Id: <6977f2fc0907051002u5c8c2280u46b001c10a45a2a1@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <6977f2fc0907050840g7b70bdb8jf8a9a85f2be730a4@mail.gmail.com>
In-Reply-To: <6977f2fc0907050840g7b70bdb8jf8a9a85f2be730a4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> What motherboard is this? For ASUS there's asus_atk0110.

I'm not really sure. It's an older Acer desktop. Sensors-detect told
me which module (w83627hf) to load.

> Disabling ACPI on a modern system is not an option. You can override
> that check with acpi_enforce_resources=lax (kernel option), but - as
> the message says - both ACPI subsystem and the native hwmon driver
> might try to touch the chip at the same time.

Thanks, I'll have to give that a try. If the machine starts rebooting,
or I can can't get a reading from the sensor, I might play with the
polling options. Mostly, I want to keep an eye on the voltages and fan
RPMs so that I know, in advance, if something is failing. AS I said,
it's an older machine.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
