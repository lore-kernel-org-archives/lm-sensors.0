From: mds@mds.gotdns.com (Mark Studebaker)
Date: Mon, 26 Sep 2005 22:55:34 +0000
Subject: [lm-sensors] SE95 driver
Message-Id: <43386007.8040503@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4647.192.168.0.190.1127544743.squirrel@www.jes.ee>
In-Reply-To: <4647.192.168.0.190.1127544743.squirrel@www.jes.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

OK I'll add the entries to our new drivers page.

? wrote:
> Hi everybody!
> 
> Seems like Philips SE95 i2c thermo sensor support is missing. Datasheet
> http://www.semiconductors.philips.com/acrobat/datasheets/SE95_2.pdf
> 
> Because I have some of those chips, I would take writing driver for it.
> Chip itself is very similar to LM75 but hs high accuracy and read-only
> register to identify chip.
> 
> Another chip I would like to cover is PCA9554(A). This is nearly identical
> to old 8574(A), resides on same addresses but has some advantages like
> automatic detection possibility and similar. So probably it takes just to
> slightly modify 8574.
> 
> I have more cool Philips chips I have but give me try on first two simple
> cases and them I can continue on others.
> 
>    T?nu
> 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors



