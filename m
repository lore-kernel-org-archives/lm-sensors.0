From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 06 Feb 2010 14:53:25 +0000
Subject: Re: [lm-sensors] [PATCH V2] hwmon: add driver for ADT7411 voltage &
Message-Id: <20100206155325.60929289@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1265142758-10457-1-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1265142758-10457-1-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 6 Feb 2010 15:38:08 +0100, Wolfram Sang wrote:
> 
> > You can have reading vdd from sysfs also update the cache, but then you
> > should also read data->ref_is_vdd at the same time. If the user is
> > going to always read all the values at once then this is the most
> > efficient approach.
> 
> Yup. Just if not, then we will have another useless read (reading adc_ref_vdd
> when we always want to know vdd) as on embedded boards, sysfs is often used
> directly. Also, I can't factor out the caching-routine, as show_input() needs
> vdd only if adc_ref_vdd is set. Adding a force_flag for always reading vdd to a
> factored out function seems a bit too complex for that case to me. I think I'll
> leave it at the current state: show_input() does the caching, show_vdd() always
> reads from the chip. We might end up reading vdd twice within a second. Well,
> it shouldn't hurt that much.

Sure, fine with me.

> (...)
> Have a nice weekend!

Thank you, same to you!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
