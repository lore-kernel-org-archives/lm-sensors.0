From: nuppla@gmx.at (fago)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: w83l785ts.c
Message-Id: <1073599668.1020.22.camel@ws1>
List-Id: <lm-sensors.vger.kernel.org>
References: <1073554584.3ffd2498612c6@imp.gcu.info>
In-Reply-To: <1073554584.3ffd2498612c6@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Do, den 08.01.2004 schrieb Jean Delvare um 21:34:

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

i'm not familiar with lm-sensors tools, because i never used it before.
i use the lm-sensors package from SID, which is 2.8.1. 

so i don't know my bus number. i2cdetect don't lists it, but i can run
it with 0,1 and 2

i think it's 2 because the sysfs entries are in 2-00**
i am also running the module w83781d for the other sensors on my board. 


i disabled C.O.P unloaded the modules and  i 've got something for 0,1
and 2

i2cdetect 2 0x4e:

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: XX XX XX XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX 2d 2e 2f
30: XX XX XX XX XX XX XX 37 XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX 48 49 XX XX XX XX XX XX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX 61 XX 63 XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX


after loading w83l785ts i've got

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: XX XX XX XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX 2d 2e 2f
30: XX XX XX XX XX XX XX 37 XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX 48 49 XX XX XX XX XX XX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX 61 XX 63 XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX

and with both modules loaded i 've got

0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: XX XX XX XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX UU 2e 2f
30: XX XX XX XX XX XX XX 37 XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX UU UU XX XX XX XX XX XX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX 61 XX 63 XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX

(i don't know if this matters ;)
then i enabled the C.O.P feature and again the tests

both modules loaded:

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: XX XX XX XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX UU UU 2f
30: XX XX XX XX XX XX XX 37 XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX UU UU XX XX XX XX XX XX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX 61 XX 63 XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX


both unloaded:


     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: XX XX XX XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX 2d 2e 2f
30: XX XX XX XX XX XX XX 37 XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX 48 49 XX XX XX XX XX XX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX 61 XX 63 XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX

w83781d loaded:
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: XX XX XX XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX UU 2e 2f
30: XX XX XX XX XX XX XX 37 XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX UU UU XX XX XX XX XX XX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX 61 XX 63 XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX

and w83l785ts loaded:

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: XX XX XX XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX 2d UU 2f
30: XX XX XX XX XX XX XX 37 XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX 48 49 XX XX XX XX XX XX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX 61 XX 63 XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX

i think its no coincidence that 2e changes and the sysfs files are in a
directory called "2-002e"



> > for know it works fine, i can't believe :)
> > regards, fago
> 
> Could you please provide a complete patch against a 2.6.x kernel? This
> should ideally include changes made to i2c-id.h, chips/Kconfig,
> chips/Makefile and of course the driver itself. I could then clean up
> whatever needs to be, ensure it applies against our current stack of
> patches, and send it to Greg.

ok, i'll do it :)
