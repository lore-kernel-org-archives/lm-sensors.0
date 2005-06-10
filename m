From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 10 Jun 2005 20:43:40 +0000
Subject: [lm-sensors] How can I skip i2c detection?
Message-Id: <20050610204311.6c60fed1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <F06EB2894F3F0D45AD9BEA7246DE9C90854F15@WCSEXCMBS1.ad.wabtec.com>
In-Reply-To: <F06EB2894F3F0D45AD9BEA7246DE9C90854F15@WCSEXCMBS1.ad.wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

> ~ # i2cdump 0 0x4c
> (...)
> 30: 7f 7f 7f 7f 7f 24 24 24 7f 7f 7f 7f 7f 7f 7f 7f

Hm, this is becoming even weirder. Same ID as the LM83 (which doesn't
match the datasheet...), and additionally register 0x35 reads 0x24,
which means D1 and D3 open on the LM83, while this register is
supposedly 0 on the LM82. This also corroborates the 127 degrees C you
report for temp2 and temp4, which is the documented LM83's behavior when
no diode is connected, while the LM82 datasheet suggests 0 for these
registers.

So I start wondering... are you *absolutely certain* that what you have
is an LM82 and NOT an LM83?

-- 
Jean Delvare
