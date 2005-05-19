From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <20050312085429.43589adb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > 0x58 would be an I2C address, not an I/O address. Also, as I said in
> > an earlier post, this would certainly be 0x58 >> 1, i.e. 0x44.
> 
> 0x58 >> 1 = 44 = 0x2c, not 0x44

Aha my god what a morron I am :(

I *knew* there were something odd in my computation but couldn't find
out what. I better learn how to use "bc" properly now...

Thanks for correcting me. 0x2c indeed sounds much better as I believe it
*is* the address of the W83792D chip.

-- 
Jean Delvare
