From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: Possible incorrectness in w83627hf.c
Message-Id: <40382FF8.7010401@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040212194619.40fc8495.khali@linux-fr.org>
In-Reply-To: <20040212194619.40fc8495.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
> MDS,
> 
> Here is an excerpt from w83627hf.c:
> 
> if (type != w83697hf) {
> 	/* enable PWM2 control (can't hurt since PWM reg
>            should have been reset to 0xff) */
> 	w83627hf_write_value(client, W83781D_REG_PWMCLK12, 0x19);
> }
> 
> According to the data sheets, this register (0x5C) does only have a
> meaning for the W83627HF. So I'd suggest changing the condition to "type
> = w83627hf" so that we don't access that register on the W83627THF (and
> possibly others such as the W83637HF, which I plan to add support for).
> 
> And, as we come to speak about this, I don't frankly see the point in
> writing anything to this register. You seem to try and write the default
> value anyway (and possibly change the value of reserved bits BTW, which
> is no good). Can't we simply get rid of that write?

What should really happen is adding code to w83627hf_pwm()
that turns the PWM on and off when the user writes the second value in the pwm file.

I note that there's still way too much initialization code in the driver.
At the very least init should be set to 0, no?
Either I didn't rip out enough code or some of it snuck
back in later.

> 
> BTW, if someone could tell me what these "PWM clock frequencies" are
> meant for... The data sheet don't seem to explain it at all.
> 

The PWM pulses have a certain duty cycle (that's what you set with
the pwm entry in /proc to control the fan speed)
and a certain frequency.
The frequency generally doesn't matter but some fans may
work better, or be less noisy, with a higher or lower frequency.
We don't support frequency changing in any driver.

> Thanks.
> 
> PS: Looks like this driver would benefit a massive refresh. The
> references to w83781d everywhere make things hard to understand
> sometimes.
> 

feel free :)
