From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: W83L785R Support
Message-Id: <20040221173955.543b057c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200402201842.48537.coflynn@newae.com>
In-Reply-To: <200402201842.48537.coflynn@newae.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Does RivaTV work with 2.6? I get:

Version 0.8.3 doesn't seem to. CVS, however, could, since there are a
lot of comments "support for 2.6.x kernels added" dated November 14th,
2003, in the CVS logs.

I think they should release...

> PS: sensors-detect never did anything before besides detect the one
> sensor on my motherboard (which works great!), and i2cdetect didn't
> show the bus, it just did:
> (...)

I2cdetect is a misnomer. It doesn't detect busses, it lists the one that
have been registered (i.e. have a driver loaded for them).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
