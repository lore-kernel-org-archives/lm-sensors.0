From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: adm9240 chip on a intel se440bx-2
Message-Id: <20040708225713.751d9a16.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001c4620c$f27351f0$3635430a@glauke>
In-Reply-To: <000001c4620c$f27351f0$3635430a@glauke>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> There are one or two errors in the build, which surfaced when I
> upgraded to gcc-3.3, I'll fix them tonight and resubmit the adm9240.c
> file. Magnitude problems are fixed, most issues you mentioned some
> time ago too.

OK. As a reminder, please make sure that:

1* Magnitudes for temperatures and voltages are 3. It's the standard and
that's how I tweaked the library in CVS.
2* Chip drivers should *NOT* set limits at init time unless default
limits for the chip are known to be broken (which is rare but happens).

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
