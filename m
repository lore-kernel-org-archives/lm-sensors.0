From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: Bug #1807: sensors with kernel 2.4, but not with kernel 2.6
Message-Id: <ylPxyB2A.1099906264.5671110.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1099499003.11618.13.camel@antares.hausnetz>
In-Reply-To: <1099499003.11618.13.camel@antares.hausnetz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi again Mark,

>After working on a patch for a bit... now I hate it.  Why does i2c_detect()
>need to work that way?
>
>Back to where I started: anyone mind if I rewrite i2c_detect()?  A grep
>said that drivers/i2c/chips/*.c are the only callers.

Fine with me as long as it is done in a consistent way, and the
documentation is updated accordingly (both writing- and porting-clients).

As a side note, such a change is not suitable for 2.4/CVS, so fixing the
drivers you listed in your other post there is still on the to-do list.

As yet another side note, I have noticed that i2c_detect checks all
addresses from 0 to 0x7f for business before processing them. This
sounds bad in terms of efficiency. The test should be done before
actually attempting to detect chips at any given address.

Thanks,
Jean
