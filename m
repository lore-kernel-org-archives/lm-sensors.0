From: lists@sk2.org (Stephen Kitt)
Date: Thu, 10 Nov 2005 13:51:53 +0000
Subject: [lm-sensors] reset=1 required for PWM control on Asus P4P800
Message-Id: <20051110135059.2e53e65a@heffalump.sk2.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051106224429.533f13b7@heffalump.sk2.org>
In-Reply-To: <20051106224429.533f13b7@heffalump.sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 8 Nov 2005 09:23:28 +0100, "Eric Pascal" <Eric.Pascal@itesoft.com>
wrote:
> 	I have been submitting a patch to enable Fan speed control on my
> P4P800, and if you disable Q-Fan in the BIOS it work perfectly, you just
> set the temperature you want, the tolerance and the step and it works
> perfectly, don't need to rely on any tool like Speedfan on Windows to set
> the speed of my fan. The patch is being tested and modified to comply with
> lm-sensors standard. But if you are interested I can send you the patch
> that works great.

That would be great, thanks.

I realise now that my first mail was somewhat hasty, and in fact my setup is
(was) so unusual that it probably doesn't justify keeping reset=1. I imagine
most people who set Q-Fan up in their BIOS would want its fan control to
remain after booting, and those people who want to use software-based fan
control would simply disable Q-Fan altogether! Furthermore if the controller
can be switched from one mode to another at run-time, resetting it would
become unnecessary (or rather, subsumed by the mode switching), wouldn't it?

Regards,

Stephen
