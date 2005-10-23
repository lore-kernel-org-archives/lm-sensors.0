From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 23 Oct 2005 22:40:55 +0000
Subject: [lm-sensors] [Ticket #2078] sensor values are sometimes wrong
Message-Id: <435BF546.70004@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051021083606.GB19748@westend.com>
In-Reply-To: <20051021083606.GB19748@westend.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Christian,
> 
> My problem is that sensors sometimes reports confusing values i.e.
> - it prints ALERT although the corresponding values are fine, the ALERT
>   then vanished in the next read
> - sensor values give suddenly 0 or arbitrary values
> - configured limits are 0 for one or two reads and then go back to the
>   defined value

This sounds like there might be something else accessing the chip. Did you check log if there are no i2c bus related problems?
We may also implement some checks to asb100 read routine to be sure that the reads actualy succeed instead of failing silencely.

Regards
Rudolf

