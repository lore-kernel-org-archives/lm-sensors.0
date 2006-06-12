From: david.c.hubbard@gmail.com (David Hubbard)
Date: Mon, 12 Jun 2006 23:12:24 +0000
Subject: [lm-sensors] [PATCH] W83627EHF driver update
Message-Id: <4dfa50520606121612t608b9e41w1ccdfc68ed65c4a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4485CB7A.9050209@sh.cvut.cz>
In-Reply-To: <4485CB7A.9050209@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, Rudolf,

> > +
> > +/* maps the user modes to chip modes */
>
> I don't see how this comment is related to the following data.
>
> > +static const u8 W83627EHF_PWM_MODE_SHIFT[] = { 0, 1, 0, 6 };
> > +static const u8 W83627EHF_PWM_ENABLE_SHIFT[] = { 2, 4, 1, 4 };

The PWM modes are located at different bit positions in the registers.
the PWM_MODE_SHIFT values give the bit positions. Remember that the
pwmN_mode sets PWM or DC.

The PWM_ENABLE_SHIFT values give the bit positions from the PWM enable
settings. After the emulated mode 0 (disabled) is accounted for, then
they go into the register.

So I guess we should replace the comment with a better explanation. I
think that comment is a remnant from some code that was deleted.

> > +/* FAN Duty Cycle, be used to control */
> > +static const u8 W83627EHF_REG_PWM[] = { 0x01, 0x03, 0x11, 0x61 };
> > +static const u8 W83627EHF_REG_TARGET_TEMP[] = { 0x05, 0x06, 0x13, 0x63 };
>
> The name is not very well chosen, these registers can hold both a target
> temperature or a target fan speed depending on the control mode (even
> if we don't support the latter at the moment.) What about just
> W83627EHF_REG_TARGET?

This is a good suggestion. In the near future, the registers will hold
one or the other value, and the driver will support both modes. Rudolf
and I talked about storing both values in the driver, with separate
sysfs files so libsensors could read either value, the one on the chip
or the one that will replace the value on the chip if the mode
switched. Advantages to doing it this way: we can set a reasonable
default for the value that's not on the chip, so when the mdoe
switches, the value in the register is not left unchanged (and
probably not reasonable); also, from userspace, it looks like there
are two registers, even though in hardware there's only one.

Disadvantages: well, emulation is bad, isn't it? But here I would
argue for emulating separate registers in the driver because the
register sharing in the hardware is impossible to map directly to a
sysfs file. If we're going to have two sysfs files with different
meanings, then can we just emulate separate registers?

> I just realized that you are emulating pwm_enable = 0. I guess the chip
> doesn't support it? Then you don't want to implement it in the driver.
> This emulation makes your code much more complex with no gain at all.
> Drivers must implement what the chip support, they must NOT emulate
> features.
>
> I'm stopping my review here. Please fix:
> * use of w83627ehf_update_device
> * use of SENSORS_LIMIT
> * locking
> * conditional register writes
> all around the place, then test the patch again, and then I'll review
> it again.

So it looks like there are some comments to fix, a few minor things,
plus what you've listed here. Rudolf, I'll be able to spend some time
on this over the weekend. That's a way off, if you feel like working
on it before then.

Thanks for the review, Jean.

David

