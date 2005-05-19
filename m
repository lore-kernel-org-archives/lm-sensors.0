From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:54 +0000
Subject: LM99 support
Message-Id: <20040423234121.11deba18.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1082749445.2933.5.camel@c211-30-214-50.rivrw3.nsw.optusnet.com.au>
In-Reply-To: <1082749445.2933.5.camel@c211-30-214-50.rivrw3.nsw.optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Is the command 'patch <linux-2.6.3-i2c-lm99.diff' in the chips
> directory?? Do the Failed messages matter?

The right command is "patch -p1 < linux-2.6.3-i2c-lm99.diff" run from
the *linux* directory. Then make modules && make modules_install &&
depmod -ae.

Note that "sensors" won't work out of the box since the "lm99" name
isn't know there yet. I'll commit my changes tomorrow. However, you
should be able to see the chip under /sys/bus/i2c/devices already.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
