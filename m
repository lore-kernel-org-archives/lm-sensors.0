From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: PWM on a W83697HF
Message-Id: <20040323205010.03cb4afd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1079973316.405f15c4abd09@imp.gcu.info>
In-Reply-To: <1079973316.405f15c4abd09@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting myself :

> No problem. We don't do anything but read/write registers 0x01 and
> 0x03 in our drivers, and this is supposed to work, so there's nothing
> more I can tell you, sorry. There is no bit that is supposed to be set
> to enable it AFAIK.

I'm plain wrong here. 0x01 and 0x03 are for the W83627HF, *not* the
W83697HF. Try registers 0x5A and 0x5B instead (with bank=0, important).
It could work :)

Sorry for the bad information.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
