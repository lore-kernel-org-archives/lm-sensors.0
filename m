From: david.c.hubbard@gmail.com (David Hubbard)
Date: Wed, 08 Mar 2006 16:48:42 +0000
Subject: [lm-sensors] [PATCH] Add voltage support to W83627EHF
Message-Id: <4dfa50520603080848o26ea4c36gf7e0515b3d5cabe5@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4409700D.8010604@sh.cvut.cz>
In-Reply-To: <4409700D.8010604@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> This patch adds the voltage alarms support into W83627EHF.

I'm probably just not getting it, but in order for me to apply the
patches, I've had to work with them to get them all in the kernel.
There isn't a backward-compatible 'alarms' interface or any
'tempN_alarm' anymore, so did I miss a patch?

If I am using the same source as you, I can post a patch to go from
w83627ehf_add_fancrt.patch to full RPM cruise support, as we
discussed. I just need to make sure we're on the same source. So
w83627ehf_wget.sh is a script that downloads and patches the
2.6.16-rc5-mm kernel. I'm also attaching the two patches you just
posted and w83627ehf_add_fancrt.patch, so these should be all the
files needed (plus an internet connection for wget) to get the source
we're working with. Rudolf, let me know if the file I end up with
doesn't match your file.
$ md5sum w83627ehf.c
1c6cdafad1c4c4e84350f5171f8ad834  w83627ehf.c

I'm also attaching a regression test script for the w83627ehf driver.
This is what I used to test the driver on my machine. I found only two
issues:

First, pwmN_mode sets PWM or DC mode. In the datasheet, the bit is
0->PWM and 1->DC but the comment in the driver says 1->PWM and 0->DC.
That's how w83792d.c does it too. So right now, the hardware behavior
is backward, relative to what's "standard" between the drivers. I
think the solution is to invert the bit in store_pwm_mode(), so that
1->PWM (written as a 0) and 0->DC (written as a 1).

Second, this code has a bug: store_pwm_enable() ...
	if (data->pwm_enable[nr] != val) {
		if (!val)
			data->pwm[nr] = 0xff; /* BUG here */
		data->pwm_enable[nr] = val;
		reg = (reg & ~(11 << W83627EHF_PWM_ENALE_SHIFT[nr]));
		reg |= W83627EHF_PWM_MODE_USER_MAP[val] << W83627EHF_PWM_ENALE_SHIFT[nr];
		w83627ehf_write_value(client, W83627EHF_REG_PWM_ENABLE[nr],
					reg);
	}

The problem is that just setting the value in the struct
w83627ehf_data doesn't write it to the register, and the next time
w83627ehf_update_device() comes around, it overwrites it. Thus, the
pwm[nr] = 0xff has no effect. This is not how I understood the
"disabled" mode to work. Also, when pwm_enable = 0, calling
store_pwm() with a new value will still write it to the device, so the
pwm is not write-protected.

Thanks,
David
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83627ehf_wget.sh
Type: application/x-sh
Size: 2492 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060308/0b38774c/w83627ehf_wget-0001.sh
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 01-w83627ehf-add_volt.patch
Type: application/octet-stream
Size: 6623 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060308/0b38774c/01-w83627ehf-add_volt-0001.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 02-w83627ehf-add_volt_alarms.patch
Type: application/octet-stream
Size: 3077 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060308/0b38774c/02-w83627ehf-add_volt_alarms-0001.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83627ehf_add_fancrt.patch
Type: application/octet-stream
Size: 15586 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060308/0b38774c/w83627ehf_add_fancrt-0001.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83627ehf_regression.sh
Type: application/x-sh
Size: 13906 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060308/0b38774c/w83627ehf_regression-0001.sh
