From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: adm1021 + kernel 2.6.3 kills machine
Message-Id: <20040327153245.0d1152d9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1077918018.21481.21.camel@nomad.ad.eecg.saic.com>
In-Reply-To: <1077918018.21481.21.camel@nomad.ad.eecg.saic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> sensors-detect tells me I have and adm1021 sensor. When I try to load
> this module, my monitor turns off, and the hard drive light stays on
> until I shut down and unplug the machine from the wall for several
> seconds.

I have updated sensors-detect in CVS, could you please give it a try and
confirm that it will *not* pretend you have an adm1021-compatible chip
anymore?

Also, I'd be very interested by the output of i2cdump for this
mysterious chip.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
