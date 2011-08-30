From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 30 Aug 2011 18:50:38 +0000
Subject: Re: [lm-sensors] [RESEND] LM73 hwmon driver i2c auto-detection
Message-Id: <20110830205038.14ab074e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAOYRzauHk1j8ThGc8Cq32Jb21LS2iqtAnyD=H=9ZpVmk3RVw-Q@mail.gmail.com>
In-Reply-To: <CAOYRzauHk1j8ThGc8Cq32Jb21LS2iqtAnyD=H=9ZpVmk3RVw-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Robert,

Please don't top-post.

On Tue, 30 Aug 2011 14:20:58 -0400, Robert Casanova wrote:
> Actually that was one of my options but I couldn't find some i2c-dummy
> driver or something similar, but now that you pointed out I've found a
> compatible driver for that device and as Guenter said it does reserve the
> address not being available to the i2c subsystem for auto-detection.
> 
> If there was no compatible driver (or not yet) for a device in my same
> situation is there some sort of a generic driver to fill it up?

i2c-core includes a dummy driver which will bind to any I2C device with
name "dummy", so you can probably just declare an i2c device with name
"dummy" at 0x48 and it would do the trick.

But the best fix in your case would be to disable probing of the I2C
bus entirely, as apparently you don't need it. Just set
i2c_adapter.class to 0 (_not_ I2C_CLASS_HWMON) and you're done.

As a side note, the lm73 driver could certainly be improved to make
detection less problematic. I'll do that now, but I do not consider
this the proper fix to your problem.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
