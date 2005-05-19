From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: ATI i2c bus driver
Message-Id: <20040213205236.4383839a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040102115144.219b5579.khali@linux-fr.org>
In-Reply-To: <20040102115144.219b5579.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Change getscl/sda to test the _GPIO_EN_x bit. If set (pull low),
> return zero, else if unset (hi-Z) read and return _GPIO_Y_x.

Didn't work.

But it happens that Benjamin Herrenschmidt has a working i2c bus driver
for Radeon boards in Linux 2.6, as part of its new radeonfb driver. The
i2c part is much similar to what I had tried, but there is much more
initialization stuff in the video part. This is probably what was
missing to me.

There is no point in writing a separate i2c driver now, so I'm canceling
my driver completely.

Thanks for the help anyway.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
