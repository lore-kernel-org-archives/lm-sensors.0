From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: I2C crash - ADM1021
Message-Id: <20031015191457.2dcc5f34.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1063901946.2937.27.camel@localhost>
In-Reply-To: <1063901946.2937.27.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > for that now. Chips like the PCF8591 could also be simply removed
> > from sensors-detect (after all, we *can't* detect them so what's the
> > point?). That second option is an easy one and would probably make
> > the users happier in average.
> 
> I agree!

OK, done that.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
