From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 09 Feb 2007 16:22:06 +0000
Subject: [lm-sensors] i have a problem with ds1337,arm linux 2.6.20
Message-Id: <20070209172206.aebc3b07.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1171010707.9705.6.camel@titan.picopeta.com>
In-Reply-To: <1171010707.9705.6.camel@titan.picopeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Pavan,

On Fri, 09 Feb 2007 14:15:07 +0530, Pavan wrote:
> the part that enables the RTC after first power up in
> ds1337_init_client() fails to write a status bit in the chip, so we fall
> into the same reset code (that writes zeros in the RTC regs) after each
> reboot.
> (...)

Wrong mailing list, this has nothing to do with sensors. Please try the
linux-rtc mailing list or the i2c mailing list (check MAINTAINERS.)

-- 
Jean Delvare

