From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: sensors-detect
Message-Id: <20030720001638.2daa6fc5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030610192542.766e220d.khali@linux-fr.org>
In-Reply-To: <20030610192542.766e220d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I've been adding support to sensor-detect for some chips we don't have a
driver for yet (LM82, LM86, LM90) and I plan to add some more in the
next few days. I think it's generally a good idea to detect many chips
even if we don't have drivers for them - and even if we know we won't
ever write one for some reason. In the first case, this let us know when
a given driver should be written through user repports. In the second
case, it may prevent misdetection of the chip as one we support.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
