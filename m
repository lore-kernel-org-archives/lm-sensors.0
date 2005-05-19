From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: unrecognized thermal sensor
Message-Id: <20040318195735.5f29f185.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030124083409.J85775-100000@euler.salk.edu>
In-Reply-To: <20030124083409.J85775-100000@euler.salk.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Better late than never... ;)

> I've done some reading in the lm_sensors documentation and found that
> the LM90 is listed as compatible with the ADM1031, for which a driver
> is currently under development.  How close is it to being usable?

The LM90 is compatible with the ADM1032, not ADM1031.

We do have a working driver for the LM90 since September 2003. It has
also been ported to Linux 2.6.

It's probably too late, but if it's not, then you could give it a try.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
