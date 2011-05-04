From: Steve Sakoman <sakoman@gmail.com>
Date: Wed, 04 May 2011 04:11:55 +0000
Subject: Re: [lm-sensors] [PATCH 0/2 v5] twl4030-madc driver
Message-Id: <BANLkTik2B_w5Rn+Q-erPhQs6VbfrNz2mcA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1298986926-31180-1-git-send-email-j-keerthy@ti.com>
	<20110302101512.GC16181@sortiz-mobl>
	<BANLkTimc6uz353DDb9Ent6s6WjfY7f-xuA@mail.gmail.com>
	<BANLkTi=zt1j_s1uDfjL=SRG6_LS1pa3xAg@mail.gmail.com>
In-Reply-To: <BANLkTi=zt1j_s1uDfjL=SRG6_LS1pa3xAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: lm-sensors@lm-sensors.org, guenter.roeck@ericsson.com, mikko.k.ylinen@nokia.com, amit.kucheria@canonical.com, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

On Tue, May 3, 2011 at 12:49 PM, J, KEERTHY <j-keerthy@ti.com> wrote:
> Hello Steve,
>
> Can you try adding this patch?

Thanks!

I tried the patch and it did indeed fix the issue.  We should try to
get this in mainline since the hwmon driver won't work without it.

Steve

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
