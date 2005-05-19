From: nuppla@gmx.at (fago)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: w83l785ts.c
Message-Id: <1073604301.1061.8.camel@ws1>
List-Id: <lm-sensors.vger.kernel.org>
References: <1073554584.3ffd2498612c6@imp.gcu.info>
In-Reply-To: <1073554584.3ffd2498612c6@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Do, den 08.01.2004 schrieb Jean Delvare um 21:34:
> > Yeah it works :))
> > Thanky you for your help, really cool =)
> 
> You're welcome.
> 
> > I'm getting a temperature of 46?C, which is what i expected about. I'm
> > also running the ASUS C.O.P feature, which also uses this chip for
> > determining the temperature (so i've read somewhere), i hope there
> > will be no problems, let's see.
> 
> I fear that problem could arise. Could you do a test for me? Unload the
> w83l785ts driver, and run "i2ddump 0 0x4e" (assuming your i2c bus has
> number 0). Some users have reported "XX" which basically means read
> errors. I suspect that this is related to the C.O.P. feature. I'd like
> you to do the test with and without this feature enabled, to see if it
> makes any difference.

eeehm, in the mail before concerning the i2cdumps - i've made the
mistake to use i2cdetect instead of i2cdump. only with i2cdetect i got
values. with i2cdump i always got X, with and without C.O.P, with and
without the modules.
sry, fago
