From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: ADM1030 Driver
Message-Id: <20040419220402.21fa5645.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040319224106.79f6cec3.cedric.pradalier@inrialpes.fr>
In-Reply-To: <20040319224106.79f6cec3.cedric.pradalier@inrialpes.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > > Bit 0 of conf register 2 enables the pwm output, I think that if
> > > the bit iscleared, the fan will never rotate. Even if in automatic
> > > mode. But it is not verified yet...
> > 
> > Please try and tell me.
> 
> Clearing that bit disables PWM output, so the fan doesn't run at all!

Then you don't want to allow the user to do it. At all.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
