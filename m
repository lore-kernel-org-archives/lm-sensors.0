From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <20030612133303.06706b6a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

(quoting myself)

> OK, the next step will be to prepare a specially modified
> sensors-detect script with a lot of debugging info for your particular
> chipset. Then, I'll ask you to run it both with and without the UTF8
> locale, and we'll see where the hell the bug is lurking.

Get it there:
http://www.ensicaen.ismra.fr/~delvare/sensors-detect-k1

Jim, please try with both non-UTF and UTF locales, and see if the
outputs differ.

PS: Yes, I know, I used the barbarian way of debugging. But I'm quite
confident it will work ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
