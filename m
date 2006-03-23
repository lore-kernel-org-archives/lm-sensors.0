From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 23 Mar 2006 22:08:09 +0000
Subject: [lm-sensors] [PATCH] Add voltage support to W83627EHF
Message-Id: <44231C49.9010301@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4409700D.8010604@sh.cvut.cz>
In-Reply-To: <4409700D.8010604@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

I finally got some time to look continue with this. Many thanks for looking into this stuff.

Please feel free to continue with this automatic fan stuff. It seems that you have time that I dont have
right now. Usually I come from work at 9pm and after 12 hours of other work is quite hard to continue here.

> I'm probably just not getting it, but in order for me to apply the
> patches, I've had to work with them to get them all in the kernel.
> There isn't a backward-compatible 'alarms' interface or any
> 'tempN_alarm' anymore, so did I miss a patch?

Well Jean did already some work today to support the alarms.
I'm attaching the driver with all patches applied except the automatic fan which is in separate patch.

Please fix it and prepare it for kernel inclusion/review. Of course you will get credit for this.
Let me know if you will do the EHF doc too. If not I can try to handle this while in train back to hometown.

> If I am using the same source as you, I can post a patch to go from
> w83627ehf_add_fancrt.patch to full RPM cruise support, as we
> discussed. I just need to make sure we're on the same source. So
> w83627ehf_wget.sh is a script that downloads and patches the
> 2.6.16-rc5-mm kernel. I'm also attaching the two patches you just
> posted and w83627ehf_add_fancrt.patch, so these should be all the
> files needed (plus an internet connection for wget) to get the source
> we're working with. Rudolf, let me know if the file I end up with
> doesn't match your file.
> $ md5sum w83627ehf.c
> 1c6cdafad1c4c4e84350f5171f8ad834  w83627ehf.c

Uff better to post a file for me, see the w83627ehf.c, which has all patches on the top and is in sync with 2.6.16 + all neccessary stuff.

> 
> I'm also attaching a regression test script for the w83627ehf driver.
> This is what I used to test the driver on my machine. I found only two
> issues:

WOW I think we need such test. Have you some methodology for the test construction please?

> First, pwmN_mode sets PWM or DC mode. In the datasheet, the bit is
> 0->PWM and 1->DC but the comment in the driver says 1->PWM and 0->DC.
> That's how w83792d.c does it too. So right now, the hardware behavior
> is backward, relative to what's "standard" between the drivers. I
> think the solution is to invert the bit in store_pwm_mode(), so that
> 1->PWM (written as a 0) and 0->DC (written as a 1).

Yes this is correct W83792D has it vice versa. Please fix that.

> Second, this code has a bug: store_pwm_enable() ...
> 	if (data->pwm_enable[nr] != val) {
> 		if (!val)
> 			data->pwm[nr] = 0xff; /* BUG here */
> 		data->pwm_enable[nr] = val;
> 		reg = (reg & ~(11 << W83627EHF_PWM_ENALE_SHIFT[nr]));
> 		reg |= W83627EHF_PWM_MODE_USER_MAP[val] << W83627EHF_PWM_ENALE_SHIFT[nr];
> 		w83627ehf_write_value(client, W83627EHF_REG_PWM_ENABLE[nr],
> 					reg);
> 	}
> 
> The problem is that just setting the value in the struct
> w83627ehf_data doesn't write it to the register, and the next time
> w83627ehf_update_device() comes around, it overwrites it. Thus, the
> pwm[nr] = 0xff has no effect. This is not how I understood the
> "disabled" mode to work. Also, when pwm_enable = 0, calling
> store_pwm() with a new value will still write it to the device, so the
> pwm is not write-protected.

Well yes this is my fault this was just a quick hack to the disable mode...

Jean, is there any specs how to disable the pwmX files when interface is disabled?

Regards
Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83627ehf.c
Type: application/octet
Size: 29389 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060323/3aaf5269/w83627ehf-0001.bin
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: add_fan_crt
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060323/3aaf5269/add_fan_crt-0001.pl
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: docs
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060323/3aaf5269/docs-0001.pl
