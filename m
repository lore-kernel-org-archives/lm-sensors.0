From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:54 +0000
Subject: LM99 support
Message-Id: <20040424102419.1e884491.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1082749445.2933.5.camel@c211-30-214-50.rivrw3.nsw.optusnet.com.au>
In-Reply-To: <1082749445.2933.5.camel@c211-30-214-50.rivrw3.nsw.optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting myself:

> Note that "sensors" won't work out of the box since the "lm99" name
> isn't know there yet. I'll commit my changes tomorrow. However, you
> should be able to see the chip under /sys/bus/i2c/devices already.

OK, I've just commited my changes. You should be able to check them out:
http://secure.netroedge.com/~lm78/download.html#cvs

With this and the kernel patch I sent you yesterday, it should work. Let
me know!

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
