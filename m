From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 05 Oct 2005 10:42:57 +0000
Subject: [lm-sensors] [PATCH] hwmon: Cleanup w83627hf initialization
Message-Id: <nLu76Kd1.1128501171.2234810.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051004200848.5f4f0182.khali@linux-fr.org>
In-Reply-To: <20051004200848.5f4f0182.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Salah,

On 2005-10-05, Salah Coronya wrote:
> It works for me just fine, actually it works BETTER. before pwm1 and
> pwm2 were reversed (pwm1 controlled fan2; and pwm2 controller fan1), and
> the fan2 would always report 0 no matter what the fan speed was. Now the
> reading and controls are correct, or at least more plausible. (Unless it
> was another patch between 2.6.13 and 2.6.13-r3).

I assume you mean 2.6.14-rc3? Yes there was a patch which made the chip
reset on driver load optional (and off by default). This is much more
likely to cause the improvements you observe than my new patch. You
could try loading the w83627hf driver with reset=1 and see if everything
reverts to the old behavior. I admit I'm a bit surprised that PWM
outputs were swapped, as I don't think the W83627HF hardware monitoring
logical device can actually do that.

Also note that the second patch really only affects the W83627HF chip,
not W83637HF, W83627THF nor W83697HF. Not sure which one you have.

Anyway, if everything works OK for you with these two patches applied,
that's great :) Thanks for testing.

--
Jean Delvare
