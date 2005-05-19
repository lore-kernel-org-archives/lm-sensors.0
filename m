From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:54 +0000
Subject: [TRIVIAL 2.6] drivers/i2c/busses/i2c-piix4.c: kill duplicate
Message-Id: <1082533461.4086265518a70@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040417230824.45f51061.khali@linux-fr.org>
In-Reply-To: <20040417230824.45f51061.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > > So far my experience has been (at least in 2.4) that usually
> > > header files don't include all required headers themselves,
> > > relying on *.c to include everything properly (maybe it's just
> > > on PPC though).
> > 
> > Such headers are broken and need fixing IMHO.
> 
> Maybe, are you going to fix them all _before_ changing i2c layer :)
> ?

I am certainly not.

> I agree it's a mess, but removing config.h you might break code which
> is fine right now. Is such clean up worth it?

I think it is, as long as we are working on the HEAD of Linux. However,
what I think is obviously not what matters, what Greg thinks is.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
