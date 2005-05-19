From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: w83l785ts.c
Message-Id: <1073638258.3ffe6b721fb72@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1073554584.3ffd2498612c6@imp.gcu.info>
In-Reply-To: <1073554584.3ffd2498612c6@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> eeehm, in the mail before concerning the i2cdumps - i've made the
> mistake to use i2cdetect instead of i2cdump. only with i2cdetect i
> got values. with i2cdump i always got X, with and without C.O.P, with
> and without the modules.

I can't believe it. Didn't you by mistake run "i2cdump 0 0x4e" instead
of "i2cdump 2 0x4e"? Please make sure (using i2cdetect) that you are
accessing the right bus.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
