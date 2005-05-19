From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: w83l785ts.c
Message-Id: <1073637595.3ffe68db27a8e@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1073554584.3ffd2498612c6@imp.gcu.info>
In-Reply-To: <1073554584.3ffd2498612c6@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> i think it's 2 because the sysfs entries are in 2-00**

You're right.

> i am also running the module w83781d for the other sensors on my
> board.

Starting with lm_sensors 2.8.2, you can use the asb100 driver instead of
the w83781d. It wil support your chipset better.

> i disabled C.O.P unloaded the modules and  i 've got something for
> 0,1 and 2

Just to be sure I understand you: disabling the C.O.P is something you
do in the BIOS setup screen, right?

> i2cdetect 2 0x4e:
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: XX XX XX XX XX XX XX XX 08 XX XX XX XX XX XX XX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX 2d 2e 2f
> 30: XX XX XX XX XX XX XX 37 XX XX XX XX XX XX XX XX
> 40: XX XX XX XX XX XX XX XX 48 49 XX XX XX XX XX XX
> 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 60: XX 61 XX 63 XX XX XX XX XX XX XX XX XX XX XX XX
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 
> 
> after loading w83l785ts i've got
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: XX XX XX XX XX XX XX XX 08 XX XX XX XX XX XX XX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX 2d 2e 2f
> 30: XX XX XX XX XX XX XX 37 XX XX XX XX XX XX XX XX
> 40: XX XX XX XX XX XX XX XX 48 49 XX XX XX XX XX XX
> 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 60: XX 61 XX 63 XX XX XX XX XX XX XX XX XX XX XX XX
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX

Something wrong there, 2e should be marked as used ("UU").

> then i enabled the C.O.P feature and again the tests
> 
> both modules loaded:
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: XX XX XX XX XX XX XX XX 08 XX XX XX XX XX XX XX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX UU UU 2f
> 30: XX XX XX XX XX XX XX 37 XX XX XX XX XX XX XX XX
> 40: XX XX XX XX XX XX XX XX UU UU XX XX XX XX XX XX
> 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 60: XX 61 XX 63 XX XX XX XX XX XX XX XX XX XX XX XX
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX

That's better. Later dumps are OK too.

> i think its no coincidence that 2e changes and the sysfs files are in
> a directory called "2-002e"

Of course it is no coincidence ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
