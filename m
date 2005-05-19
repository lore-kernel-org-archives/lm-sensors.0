From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: [trivial patch] i2c/it87: add newline to printk
Message-Id: <mKaUJLZX.1106651660.3405820.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050125110538.GA4459@nd47.coderock.org>
In-Reply-To: <20050125110538.GA4459@nd47.coderock.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Domen,

> This printk should have newline, otherwise next string is appended to it.

True, however this happens to be already fixed by another patch (already
in Greg's tree and present in 2.6.11-rc2-mm1).

http://lkml.org/lkml/2005/1/15/75

Thanks,
--
Jean Delvare
