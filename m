From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <20050406193105.30b5caf5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> How could this EVER worked????!!!!
> 
> outb_p(inb_p(SMB_HST_CNTL2) | (size << 3), SMB_HST_CNTL2);
> MASK is missing !!!!

Hey, nice catch Rudolf :)

When this is all sorted out, please don't forget to post a patch for
Linux 2.6!

Thanks,
-- 
Jean Delvare
