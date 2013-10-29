From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 29 Oct 2013 08:07:17 +0000
Subject: Re: [lm-sensors] Lenovo Yoga 13 with SMSC EMC2104 chip
Message-Id: <20131029090717.6fcd5f08@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAK0txenpNcwmNh4UqTaBzYE8Tu5uns+2EoVALK2+gn9DGJPEkw@mail.gmail.com>
In-Reply-To: <CAK0txenpNcwmNh4UqTaBzYE8Tu5uns+2EoVALK2+gn9DGJPEkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter, hi Igor,

On Sun, 27 Oct 2013 18:26:20 -0700, Guenter Roeck wrote:
> (...) It should be possible to add support for EMC2104
> to the EMC2103 driver, but someone would have to implement it.
> If you want to hack, you could add the emc2104 device id (0x1d)
> and the emmc2104 I2C address (0x2f) to the driver. That _should_
> give you access to some of the temperature sensors and to one
> of the fan controllers. No guarantee, though.

For that kind of test, you don't even need to change the code. You can
simply instantiate the device from user-space manually using method 4
described in
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/i2c/instantiating-devices

Whether it will work or cause your hardware to crash and burn, I can't
say. I would be very cautious with a fan controller chip.

Igor, could you please provide a register dump (using the i2c-dev
driver + i2cdump from the i2c-tools package) of your EMC2104 chip?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
