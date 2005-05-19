From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: 2.6.4: strange (?) include path order
Message-Id: <20020807210422.0ffadc91.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020807205413.A23077@rhlx01.fht-esslingen.de>
In-Reply-To: <20020807205413.A23077@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> This is because I have an old i2c.h header in /usr/local/include.
> 
> Why do you specify /usr/local/include before /usr/src/linux/include ??
> In this case it was fatal.
> 
> I guess you can safely assume that /usr/src/linux is the most recent
> tree.

No, we of course can't. The most recent tree is... ours ;)

Did you install i2c-2.6.4 before lm_sensors-2.6.4? My guess is, you
didn't.

-- 
Jean "Khali" Delvare
http://www.ensicaen.ismra.fr/~delvare/
