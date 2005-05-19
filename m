From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: xeontemp
Message-Id: <20031202074706.7aded81e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Only caveat is I wrote the xeontemp module and can't test it,
> and I've received zero reports about it, good or bad.

No wonder, it's not in sensors-detect and the adm1021 documentation
doesn't mention it. So there's no way users can even suspect its
existence.

This is the reason why I always add support for new chips to
sensors-detect first, even before having a working driver.

Don, is your system a dual-Xeon one?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
