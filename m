From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 16 Nov 2010 07:59:32 +0000
Subject: Re: [lm-sensors] [PATCH] Move ams driver to macintosh
Message-Id: <20101116085932.5621cc20@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101005121043.08771994@endymion.delvare>
	<1289882005.2147.1489.camel@pasglop>
In-Reply-To: <1289882005.2147.1489.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Hanselmann <linux-kernel@hansmi.ch>, LM Sensors <lm-sensors@lm-sensors.org>, Stelian Pop <stelian@popies.net>, linuxppc-dev@lists.ozlabs.org, Guenter Roeck <guenter.roeck@ericsson.com>

Hi Benjamin,

On Tue, 16 Nov 2010 15:33:25 +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2010-10-05 at 12:10 +0200, Jean Delvare wrote:
> > The ams driver isn't a hardware monitoring driver, so it shouldn't
> > live under driver/hwmon. drivers/macintosh seems much more
> > appropriate, as the driver is only useful on PowerBooks and iBooks.
> 
> Going through backlog... Do you want me to carry this in powerpc or
> you'll deal with it directly ?
> 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> > Cc: Stelian Pop <stelian@popies.net>
> > Cc: Michael Hanselmann <linux-kernel@hansmi.ch>
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

I'm glad you like this patch, as it has already been applied to Linus'
tree ;)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
