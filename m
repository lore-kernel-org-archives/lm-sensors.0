From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: Ticket 1833
Message-Id: <20041206202334.3b397c66.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0412020915370.25485@boxer.fnal.gov>
In-Reply-To: <Pine.LNX.4.58.0412020915370.25485@boxer.fnal.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Steven,

(Many, many thanks to the FNAL for nedit! I simply couldn't live without
it. You might not have suspected it so far but you have actually been
sponsoring the lm_sensors project for a while ;))

> According to winbond web site there are a couple of new chips 
> they recently released:
> 
> http://www.winbond.com.tw/E-WINBONDHTM/team/news.asp#03
> 
> Either W83627EHF or W83792D.  
> Any chance the chip is one of them?

The W83627EHF is most probably a variant of the W83627HF or THF, so it
would be a Super-I/O chip. Since you already have an HF chip it wouldn't
make much sense. Unless of course the HF is a misdetection and is
actually an EHF. Without a datasheet we cannot say.

We could probably take a guess if you would provide dumps for all three
chips:
isadump 0x295 0x296 (assuming that the Super-I/O chip is at 0x290)
i2cdump 0 0x2c
i2cdump 0 0x2f

One of the I2C chips is obviously an "alias" of the Super-I/O chip, this
should help find out which actually is.

The W83792D sounds much more credible to me. Again without a datasheet
we cannot confirm. However, Winbond themselves are working on a driver,
and said they would release a datasheet soon. Let's just wait until they
are done.

Stay tuned! :)

-- 
Jean Delvare
http://khali.linux-fr.org/
