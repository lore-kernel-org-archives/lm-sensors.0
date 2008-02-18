From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 18 Feb 2008 18:55:46 +0000
Subject: Re: [lm-sensors] [PATCH] Add driver for AD7414 i2c temperature
Message-Id: <20080218195546.35cfe61c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <A42C17A8FF150C4DB98BFD6497D1D00007F45D79@ussvlexmbpf1.spansion.com>
In-Reply-To: <A42C17A8FF150C4DB98BFD6497D1D00007F45D79@ussvlexmbpf1.spansion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 18 Feb 2008 13:15:14 -0500, Sean MacLennan wrote:
> Jean Delvare wrote:
> > Frank's driver is a "new-style" i2c driver. These drivers do not probe
> > the i2c adapters for supported chips automatically. Instead, platform
> > code should explicitly instantiate the I2C devices that are present on
> > the system. In the case of embedded designs, this is typically done by
> > calling i2c_register_board_info() in platform code.
>
> That works, thanks! So the patch works for me.

Great, thanks for testing. Would you also feel like reviewing the code?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
