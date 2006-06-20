From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 20 Jun 2006 14:16:18 +0000
Subject: [lm-sensors] Dedicated mailing list for i2c
Message-Id: <20060620161618.b46d5a29.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060613142005.0d4e4763.khali@linux-fr.org>
In-Reply-To: <20060613142005.0d4e4763.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting myself again:
> > I think it is about time to have a dedicated list for i2c, instead of
> > having a single list for hardware monitoring (sensors) and i2c. There
> > are more and more non-sensors users for the i2c bus (for example
> > media/video adapters, RTC chips) and more different connectivities for
> > sensors (for example SPI) so having a single list makes less and less
> > sense.
> 
> The balance being in favor of a separate list for i2c by 3 to 0, let's
> do that.

This is done, we have a new list. People interested in i2c development
(core, bus drivers, chip drivers) are invited to subscribe:
http://lists.lm-sensors.org/mailman/listinfo/i2c

Then I will update the references in the Linux kernel trees, in our
subversion source repositories, and on our website. After that, all
discussions related to i2c should be directed to this new list instead
of the lm-sensors list.

Thanks,
-- 
Jean Delvare

