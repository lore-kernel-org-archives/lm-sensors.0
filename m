From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 28 May 2005 14:24:19 +0000
Subject: [lm-sensors] [PATCH] I2C KConfig update - some EXPERIMENTAL
Message-Id: <20050528142428.6ef4e667.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050528112624.2865.qmail@desitka.sh.cvut.cz>
In-Reply-To: <20050528112624.2865.qmail@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> Following patch removes EXPERIMENTAL flag from some of I2C bus and
> chip drivers. It is removed when the driver is in kernel at least from
> 2.6.3 and I generally think there is no problem with it.
> 
> Also this patch adds SiS 745 to help option of sis96x and it
> also fixes nForce2 driver entry to reflect current state.

Looks good.

Thanks,
-- 
Jean Delvare
