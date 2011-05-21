From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 21 May 2011 08:35:00 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (coretemp) Fix checkpatch errors
Message-Id: <20110521103500.75b11a87@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305902880-11414-3-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1305902880-11414-3-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Oh, BTW, the coretemp driver includes the following:

> static int adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
> {
> (...)
> 	if (usemsr_ee) {
> 
> 		err = rdmsr_safe_on_cpu(id, 0xee, &eax, &edx);

You may want to add the removal of the unneeded blank line to your
cleanup patch.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
