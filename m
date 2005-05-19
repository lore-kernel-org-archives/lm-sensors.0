From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: Winbound W83627EHF sensor
Message-Id: <2qTK2M7d.1115821761.9183260.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050510203454.27683f7b.medaglia@gmail.com>
In-Reply-To: <20050510203454.27683f7b.medaglia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Cadu,

> > 3* Code, if you can write Linux kernel code (C). If you go that way, we
> > will of course try to help you when you face problems and have questions.
>
> I'd like to help with code. I've wrote a webcam driver to Linux, so I
> have some experience. I'd like to know where to start! :)

Pick the datasheet here:
http://archives.andrew.net.au/lm-sensors/pdfe5IBpZipZu.pdf

Reminder for your future work: do NOT trust that datasheet like holy
words. I have found errors already, and there may be more.

Then start from my version of the driver (be sure to start from the
latest version!) and add the missing functions (voltage inputs, VID/VRM,
PWM outputs). My w83627ehf code is based on the w83627hf driver in the
first place, so you can probaly find inspiration there. See how this
other driver handles the missing features, copy to the w83627ehf driver
and edit to match the datasheet. Then recompile and test your new driver.

Note that "sensors" won't show anything until libsensors knows about
the new features. I invite you to first make sure that the driver works
OK by manually reading and writing values in /sys/bus/i2c/devices/*.
Once you have tested this, you can edit the code of libsensors and the
sensors program (both in the lm_sensors package) to handle the new
features.

That's it for the big plan. Now if you have more precise questions, do
not hesitate. Oh, and please answer to the mailing-list rather than me
directly, so that others can voice in.

Thanks,
--
Jean Delvare
