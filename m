From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: Additional info for ticket #1148
Message-Id: <20030612101332.52a8a590.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1054890869.11041.3.camel@nazgul>
In-Reply-To: <1054890869.11041.3.camel@nazgul>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > You really should stick to one given version of i2c AND lm_sensors
> > or you're guaranteed to fall into death traps rather quickly. I
> > don't know how you managed to reach the point you're at, but you're
> > supposed to install the i2c version that matches the lm_sensors
> > version you intend to use, *before* installing lm_sensors. Also,
> > don't you forget to issue a "depmod -a" between the installations of
> > i2c and lm_sensors.
> 
> Yeah, I upgraded both to 2.7.0 the other day -Dan

And did it solve the problem you had (which I'd be happy to hear you
recap, by the way)?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
