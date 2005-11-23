From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 23 Nov 2005 14:45:55 +0000
Subject: [lm-sensors] [PATCH] I2C: Add MAX6900 I2C RTC support
Message-Id: <LbJ3yYrq.1132753531.0174530.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200511231317.41695.sr@denx.de>
In-Reply-To: <200511231317.41695.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Stefan,

On 2005-11-23, Stefan Roese wrote:
> This patch adds support for the Maxim/Dallas MAX6900 I2C RTC.

-ENOPATCH
Try again with the proper attachement type.

Back in March 2004, Anthony Petillo told us he was working on a MAX6900
driver for Linux 2.4. We never heard back as far as I remember (but I
have a bad memory). Does your own driver has anything to do with
Anthony's work?

Can you check whether sensors-detect finds your MAX6900 chip?

What hardware do you have a MAX6900 chip on?

--
Jean Delvare
