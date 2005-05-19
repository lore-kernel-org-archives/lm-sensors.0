From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: it87 manual pwm patch form 2.6.7/8
Message-Id: <20040719214110.1e1decdf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040714144826.GA9936@nemo.sby.abo.fi>
In-Reply-To: <20040714144826.GA9936@nemo.sby.abo.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jonas,

> Here is a patch adding manual pwm support to the it87 driver. I hope I
> have addressed all the comments you gave to my initial version (btw,
> thanks for taking the time to make them, they were helpful).

You're welcome :)

> In addition to manual pwm, this patch contains some whitespace
> cleanups. It also removes the "reset" module option, which IMO is just
> broken to have there. Currently we lose a lot of BIOS suppleid
> settings when it is used, rendering the chip useless (unless the
> requiered settings just happen to match the chip defauls).  For a
> working reset, we should really save and reload every register.  If
> someone wants to reset it, use i2ctools.

I fully agree with your analysis.

> The patch is against 2.6.7 with the cleanup patch I submitted earlier
> applied (according to the kernel changelog this should be identical to
> the version in 2.6.8-rc1, but I haven't verified that).

Just tried and it fails to apply to 2.6.8-rc2 (Hunk #8 FAILED at 592).

> The autopwm patch will hopefully follow once this patch is approved
> (the autopwm part is not quite in a submittable state yet).

Thanks a lot for your effort to submit your patches in an incremental
way, it really helps.

You patch looks fine to me (I read it admittedly quickly, I cannot test
the code anyway), except for one thing I am wondering about:

> +	/* initialize to sane defaults */
> +	for (i = 0; i < 3; i++) {
> +		data->manual_pwm_ctl[i] = 0x7f;
>  	}

Why do you do that? I think you should read the default value from the
chip. We have had several complaints from users about drivers changing
the fan speed by just being loaded, so that's the kind of things we now
want to avoid. And I'm now even sure I understand in which condition you
would use that "sane" default. So it you do the right thing, please
explain (and comment in the code).

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
