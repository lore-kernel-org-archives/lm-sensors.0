From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: w83l785ts.c
Message-Id: <20040108213419.393dd50a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1073554584.3ffd2498612c6@imp.gcu.info>
In-Reply-To: <1073554584.3ffd2498612c6@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Yeah it works :))
> Thanky you for your help, really cool =)

You're welcome.

> I'm getting a temperature of 46?C, which is what i expected about. I'm
> also running the ASUS C.O.P feature, which also uses this chip for
> determining the temperature (so i've read somewhere), i hope there
> will be no problems, let's see.

I fear that problem could arise. Could you do a test for me? Unload the
w83l785ts driver, and run "i2ddump 0 0x4e" (assuming your i2c bus has
number 0). Some users have reported "XX" which basically means read
errors. I suspect that this is related to the C.O.P. feature. I'd like
you to do the test with and without this feature enabled, to see if it
makes any difference.

> for know it works fine, i can't believe :)
> regards, fago

Could you please provide a complete patch against a 2.6.x kernel? This
should ideally include changes made to i2c-id.h, chips/Kconfig,
chips/Makefile and of course the driver itself. I could then clean up
whatever needs to be, ensure it applies against our current stack of
patches, and send it to Greg.

Thanks!

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
