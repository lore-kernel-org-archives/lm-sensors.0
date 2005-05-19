From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: adm9240 chip on a intel se440bx-2
Message-Id: <20040811220203.463b1569.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001c4620c$f27351f0$3635430a@glauke>
In-Reply-To: <000001c4620c$f27351f0$3635430a@glauke>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sorry for the delay too.

> Sorry for the late reply, I have been awfully busy. Anyway, adm9240.c
> is up at http://solar.xs4all.nl/share/ with most of the fixes.

It's not there. Is it supposed to be the one in /sensors/? Doesn't seem
ready to me. At least alignment is not compliant with kernel rules, and
the driver seems to init limits while we dropped that in all driver for
quite some times now.

I may have some spare time these days for code review. Please point me
to the latest version of your work, so that I can comment on it.

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
