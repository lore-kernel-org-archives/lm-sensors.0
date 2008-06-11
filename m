From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Wed, 11 Jun 2008 17:58:27 +0000
Subject: Re: [lm-sensors] [PATCH] Unhide the SMBus on the Compaq Deskpro EN
Message-Id: <20080611195827.11e51c39.krzysztof.h1@poczta.fm>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080608134702.401b9fb5.krzysztof.h1@wp.pl>
	<200806101202.20257.jbarnes@virtuousgeek.org>
	<20080611165324.6c080efb@hyperion.delvare>
	<200806110916.38694.jbarnes@virtuousgeek.org>
In-Reply-To: <200806110916.38694.jbarnes@virtuousgeek.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Jean Delvare <khali@linux-fr.org>, Krzysztof Helt <krzysztof.h1@wp.pl>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, lm-sensors@lm-sensors.org, rh1985@wp.pl

On Wed, 11 Jun 2008 09:16:38 -0700
Jesse Barnes <jbarnes@virtuousgeek.org> wrote:

> On Wednesday, June 11, 2008 7:53 am Jean Delvare wrote:
> > BTW, Krzysztof, what about adding (read-only) support for the critical
> > limits to your thmc50 driver? It would be helpful in a situation like
> > this.
> >

I'll try to add this and support for adm1028/thmc51 chips.

> > Another thing to check is whether the value of register 0x19 (analog
> > output) changes automatically when the fan speeds up.
> >
> > Until these tests are done, I consider this patch possibly unsafe and
> > not ready to go to Linus (although probably OK for -next).
> 
> Ok, thanks for the heads up Jean, I'll keep this one out of the queue I send 
> to Linus until we get confirmation about its safety.
> 

I should be able to confirm in about a week. Two guys are currently using
the patch with thmc50 sensor driver. 

Regards,
Krzysztof


----------------------------------------------------------------------
Podbij Dziki Zachod!Gra strategiczna online
Sprawdz >>> http://link.interia.pl/f1dff


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
