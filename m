From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: Ported lm80 to Linux 2.6
Message-Id: <1076403383.40289cb779c27@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Tiago Sousa <mirage@kaotik.org>:

> Hi Jean, I'm not sure who to talk to, but since you wrote the i2c
> porting guide and ported lm83, here I am. If you prefer, please
> redirect me to the "proper channels" :)

The LM Sensors mailing-list is the correct address to send this kind of
news to.

> I'm inexperienced in kernel coding but your guide is very helpful
> and it wasn't hard to port the lm80, looking at the lm83.

Glad you liked it. If you have suggestions about it, please let me know
so that I can make it even more helpful.

> The sensors-detect detects this chip on my board, although it
> returns kind of bugus values, even in linux 2.4. Most of them never
> change, like the temp_input1 which is what I really care about, so I
> presume it's not a problem of sensors.conf or anything, but rather a
> hardware malfunction of some sort. The driver/sensor that works for
> me is via686a. But since lm80 is detected and it was missing in 2.6,
> I decided to try to port it.

Funny story. Usually people would report that the via686a (which is the
"native" sensor chips) driver reports bogus values, and need to use
another chipset the motherboard maker added. In fact it doesn't make
sense at all that the motherboard maker would have added an LM80 on the
board if they did not plan to actually use it. I think I remember that
the LM80 is a hard to detect chip, so I wouldn't be surprised at all if
what you have is *not* an LM80 but something else. If you want us to
take a look, please provide the output of "i2cdetect 1 0x2d" (where 1
is the bus number and 0x2d the address of the LM80; adapt values to
your case).

> But enough of history. The driver appears to work because it returns
> the same values as the driver from lm_sensors in Linux 2.4, but I
> can't be sure, since I don't really use the driver. I was hoping you
> could put this "in the loop" and test it, or pass it to someone who
> can. I believe most of the work is done, probably just needs some
> tweaking (I multiplied in_* and temp_input1 by 10, to match the
> values from linux 2.4, for example).

This is very nice to you. I don't have such a chip myself, but know of
one potential tester (Lennard Klein). If other people on this list do
have hardware for testing, please speak up.

The tweakings are required because base units (aka magnitudes) were
changed from 2.4 to 2.6. For the temperatures, we moved from tenths or
hundredths to thousandths of degrees, thus the need you had to multiply
by 10 to get correct readings.

> Attached is the complete lm80.c ported to Linux 2.6. It's based on
> lm80.c from lm_sensors 2.8.3. Please let me know if you want me to do
> any major changes.

Looks good at first sight, except a few alignment problems, but that's
unimportant. I can't speak for the code details now, I would have to
take a deeper look, unless someone else wants to.

I repost your file unchanged to the list so that everyone can take a
look.

> Hope this helps,

Indeed it does. Porting chip drivers requires time, although it is not
very complex, as you may have noticed. So any help we can get is
welcome, and I know that the lm80 driver was awaited by many folks.

Thanks a lot :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm80.c
Type: application/octet-stream
Size: 20666 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040210/298e91bf/lm80.obj
