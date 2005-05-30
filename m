From: grant_lkml@dodo.com.au (Grant Coady)
Date: Mon, 30 May 2005 01:59:53 +0000
Subject: [lm-sensors] SMSC LPC47M192 - "Device is disabled, will not use"
Message-Id: <ujlk91hvj36q33jju81p73uc60t1q1rqak@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <429A1930.6040409@gmail.com>
In-Reply-To: <429A1930.6040409@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 29 May 2005 19:03:10 -0400, Keenan Pepper <keenanpepper@gmail.com> wrote:
>
>Kernel 2.6.12-rc5-mm1, lm_sensors version 2.9.1.

Have you compiled all i2c sensor device drivers as modules to get a 
successful probe?  Seems only the EEPROM detected?  Does BIOS screen 
show 'hardware health' or similar summary indicating you have h/w 
monitoring available?

--Grant.
