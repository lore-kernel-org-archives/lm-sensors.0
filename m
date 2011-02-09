From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 09 Feb 2011 16:33:47 +0000
Subject: Re: [lm-sensors] [PATCH v3] sensors-detect: Add capability to
Message-Id: <20110209173347.6af5974b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110209162041.GA19070@ericsson.com>
In-Reply-To: <20110209162041.GA19070@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 9 Feb 2011 08:20:41 -0800, Guenter Roeck wrote:
> This patch adds detection of SMSC EMC1002, EMC1033, EMC1046, EMC1047,
> EMC1072, EMC1073, EMC1074, EMC1402, and EMC1424 to sensors-detect.

Looks alright this time. Feel free to add the non-probed addresses as
comments though, so that they can be added later if we ever decide to
probe them.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
