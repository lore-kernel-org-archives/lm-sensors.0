From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: as99127f pwm registers
Message-Id: <20030723084306.433f4d30.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030722093411.25d749c5.khali@linux-fr.org>
In-Reply-To: <20030722093411.25d749c5.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> While working on an independent Asus BACH driver this evening, I ran
> across this old message, where Alex mentions "type 1 vs. type 2" 
> w.r.t. as99127f:
> 
> http://archives.andrew.net.au/lm-sensors/msg02070.html

Interesting, thanks for pointing this out.

> This is still ambiguous (e.g. so how do you differentiate as99127f
> from w83782d?)

Take a look at w83781d_detect in sensors-detect. The detection code is
really different, although the chip ID (I think) is 0x30 for both. The
detection for the AS99127F is somewhat different from what is decribed
by Alex. And it looks we do not support "type 2". I really think we
should unite our forces against the lack of datasheet to make detection
and support the best we can.

> and maybe Alex has newer info now.

I hope so. Alex?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
