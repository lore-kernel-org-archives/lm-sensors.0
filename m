From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 27 Jun 2011 15:02:38 +0000
Subject: Re: [lm-sensors] sensor details for W83627HG-AW
Message-Id: <20110627170238.62fae6c1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <838315.8004.qm@web95806.mail.in.yahoo.com>
In-Reply-To: <838315.8004.qm@web95806.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Krunal,

On Fri, 24 Jun 2011 16:49:13 +0530 (IST), krunal patel wrote:
> after insmod hwmon-vid.ko and via-cputemp.ko output of sensors binary is
> (...)
> via_cputemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +3892138.1 C  
> cpu0_vid:    +0.684 V

Thanks for the report. cpu0_vid looks very good, so I'll push my
patches upstream. I can credit you as a tester if you want, but beware
that your e-mail address would then be published in the kernel
repository, which could result in more spam.

Temperature looks plain wrong though. Does the number change over time?

Can you please provide the output of:
# rdmsr -x 0x1169
both when idle and under load?

Looking at the code, I don't even see how the temperature value could
be a non-integer, so there must be an overflow somewhere.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
