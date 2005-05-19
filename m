From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <8gZDCk6R.1112959259.5608740.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Rudolf,

> Those are from I2C_QUICK when detecting presence of chips (for example
> addresses 0x52, 0x53, ... and 0x2d, 0x2e...)
> (possible locations of eeproms and other chips) This messages are only
> informative, although I do not remember how they are treated in rest of
> drivers?
>
> Khali should it be dev_warn of dev_dbg ?

If these are actually expected and normal for I2C_QUICK (which I can't
confirm with a datasheet...), then it would be better to not display
anything for I2C_QUICK, and keep it a warning for all the other cases.

Thanks,
--
Jean Delvare
