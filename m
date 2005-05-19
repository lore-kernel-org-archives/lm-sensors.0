From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: [PATCH 2.6] I2C: remove <linux/delay.h> from via686a
Message-Id: <20050510202815.1f18dce2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <947m71hvl7rt3efdmmi6ekbc3r9pakplmu@4ax.com>
In-Reply-To: <947m71hvl7rt3efdmmi6ekbc3r9pakplmu@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> In my cross-reference checking of sysfs names, the via686a needs 
> special case treatment as it the only driver expands S_IWUSR to 
> 00200 with gcc -E.  (00200 is the correct value for S_IWUSR).
> 
> This is caused by the driver including <linux/delay.h>, it compiles 
> fine without that header but I am unable to test drive the change. 

Although your reason for removing that include is bad, it is actually
correct to remove it, because we don't need it. I've removed it from the
lm_sensors CVS driver as well.

Thanks,
-- 
Jean Delvare
