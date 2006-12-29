From: david.c.hubbard@gmail.com (David Hubbard)
Date: Fri, 29 Dec 2006 03:09:39 +0000
Subject: [lm-sensors] W83627DHG, steps to use
Message-Id: <4dfa50520612281909n65b9c163w6d2be0e90efe53f2@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200612271943.00165@goldspace.net>
In-Reply-To: <200612271943.00165@goldspace.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andrew,

> AUX Temp doesn't change at all when both CPU are under heavy loading.
> The sensor value is 119C always (it is for ASUS P5B-VM motherboard).

Does this mean that SYSTIN also doesn't change? If so, only one of the
cores has been wired to the w83627dhg.

> >I'm going to pass on this one. Rudolf?
>
> I think script is correct. I have tried 'echo 0' > blablabla and got the same
> error. Given pwm2_enable has content "1". 'echo 1' doesn't lead to error.

The script is incorrect. The reason the driver returns an error for
'echo 0' is because the value 0 is invalid for this chip. The script
should handle the error correctly and not display an error.

Setting pwmX_enable to 0 is supposed to disable the pwm output for
that fan, resulting in the maximum fan speed. The w83627ehf and
w83627dhg do not have a way to disable the pwm output. Just write 255
to pwmX.

> P.S. Must I use multiple "To:" in accordance with msg header, or must I answer
>      to the mailing list only? (I use last variant now)

The reason for including specific people in To: is so we know that you
wanted us to read your message. We sometimes don't respond if you just
post to the list, even though we are subscribed to the list.

David

