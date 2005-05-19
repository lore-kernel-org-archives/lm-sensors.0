From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: TI TMP101 driver
Message-Id: <20050219183810.56c2f394.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050218154856.GA14189@home.fluff.org>
In-Reply-To: <20050218154856.GA14189@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

> I'm going to fix the lm75 driver to only rewrite the CMP/INT bit,
> and only if it's set to INT, OK?
> This will be kinder to compatible chips.

I'd even say: just make sure that bit 0 (shutdown) is clear, and leave
all the rest untouched. I just finished my lm92 driver for Linux 2.6 and
that's what I did. We shall not change any bit we do not *need* to
change.

Thanks,
-- 
Jean Delvare
