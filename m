From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 22 Feb 2006 20:05:34 +0000
Subject: [lm-sensors] Broadcom HT1000 support request
Message-Id: <20060222210534.3788219d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3174569B9743D511922F00A0C94314230E8709F3@TYANWEB>
In-Reply-To: <3174569B9743D511922F00A0C94314230E8709F3@TYANWEB>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Raphael,

> On you website, I found lm-sensors didn't have any plan to support HT1000.
> But as I know, it's very easy to support it.
> 
> HT1000 still use the PIIX4 SMBus controller, and current i2c-piix4.c file
> can support it by adding new chip Device ID 0x0205.
> 
> The vendor id is still formal Serverworks ID(0x1166).

You're right, and in fact Martin Devera just provided a patch
implementing this. Our website was lagging behind a bit, I just updated
it. Thanks for pointing out. I'll push that patch to Greg KH at the end
of the week so it should show in -mm soon.

I also just updated the sensors-detect script (in CVS), it should now
detect this SMBus. Raphael, Martin, please test and report if it
doesn't work as expected.

Thanks,
-- 
Jean Delvare

