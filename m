From: Tabi Timur-B04825 <B04825@freescale.com>
Date: Tue, 15 Nov 2011 03:00:17 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (pmbus) Fix two issues
Message-Id: <4EC1D5C0.6090609@freescale.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1321249266-17071-1-git-send-email-Yuantian.Tang@freescale.com>
In-Reply-To: <1321249266-17071-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Tang Yuantian-B29983 wrote:
> [Yuantian:] unfortunately no, Even I add I2C_FUNC_SMBUS_READ_BLOCK_DATA support,
> The return value is not correct.

Yuantian,

Are you saying that without your patch, the zl6100 won't work on the 
P1022DS?

-- 
Timur Tabi
Linux kernel developer at Freescale

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
