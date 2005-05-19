From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: 2.6.4: strange (?) include path order
Message-Id: <20020807214317.7b0b2ba9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020807205413.A23077@rhlx01.fht-esslingen.de>
In-Reply-To: <20020807205413.A23077@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Did you install i2c-2.6.4 before lm_sensors-2.6.4? My guess is, you
> > didn't.
> Of course I didn't:
> I'm using 2.4.18 builtin i2c support modules.
> If you don't plan to/can't fix this, then maybe you might want to
> mention this in the FAQ...

I don't see how we could fix this. If we have /usr/src/linux/include
before /usr/local/include, people installing the latest i2c release
won't see it used and will probably get somehow frustrated. What's more,
I think it is always better to use the version of i2c we release with
lm_sensors. Of course, older versions (and thus kernel version) may
work, but it may not work as well.
Now, is it worth an entry in the FAQ? Not even sure. I think (I indeed
*hope*) that someone encountering the problem you faced would try
updating i2c before reading the FAQ (and so, wouldn't read the FAQ since
it would work). Anyone got a different opinion?

> Currently having a look at the perl script detection code...
> Hmm, weird stuff. Not sure yet what can be done about that.

I don't get you. What do you mean?

-- 
Jean "Khali" Delvare
http://www.ensicaen.ismra.fr/~delvare/
