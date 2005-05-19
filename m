From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: i2c-proc and kernel 2.6.0-test11 HOWTO
Message-Id: <20031216203503.2de6cd48.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1071508087.2621.13.camel@ta3>
In-Reply-To: <1071508087.2621.13.camel@ta3>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I have not lm80.c! 
> Is this problem? 
> How can I continues?
> Is possible use sensors for my mainboard and chipset with linux
> 2.6.0-test11?

That driver (as well as a few others, most notably the lm87) have not
been ported from our CVS (2.4-compatible) repository yet, partly because
everybody lacks time, partly because code in 2.6.0-test11 is more or
less frozen until 2.6.0 final is released.

Without this driver you won't be able to use sensors under 2.6.

If you want to help porting that driver, let us know and I'll tell you
how to do so.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
