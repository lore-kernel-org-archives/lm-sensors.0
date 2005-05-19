From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: [PATCH 2.6.0-test3]bugfix for initialization bug in adm1021
Message-Id: <20030815112613.39bc5700.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1060731495.11264.8.camel@vmhack>
In-Reply-To: <1060731495.11264.8.camel@vmhack>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > While initializing the adm1021 device, the driver is performing a
> > conversion from fixed point to Celcius on values that were declaired
> > as Celcius.  On my Dell Precision 220 this results in a shutdown
> > after a couple of minutes running.
> > 
> > This is a very simple patch against the 2.6.0-test3 tree that just
> > removes the conversion.
> 
> Applied, thanks.

I just checked and this does not apply to our CVS tree. The bug was
introduced by the sysfs conversion (because millidegrees are in use
there, while these are degrees in CVS).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
