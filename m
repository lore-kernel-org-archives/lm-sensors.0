From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: Issues with lm_sensors on Intel SE7501cw2
Message-Id: <20031025203419.3efdd60e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <9D8C1A43309BAD4A9B46071DAF911D9E3E237D@exch01.paracel.com>
In-Reply-To: <9D8C1A43309BAD4A9B46071DAF911D9E3E237D@exch01.paracel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> OK, here it is,
> 
> # prog/dump/isadump 0x295 0x296
>   WARNING! Running this program can cause system crashes, data loss
>   and worse! I will probe address register 0x0295 and data register
>   0x0296. You have five seconds to reconsider and press CTRL-C!
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 20: 5a 6f cd b7 cb cb 99 22 ff ff 35 58 50 58 50 d8
> 30: c4 c3 b0 d9 b2 31 15 3b 31 3c 7f 6d ba e1 00 00
> 40: 01 00 10 00 00 00 00 5e 1f 02 89 c4 41 95 00 a3
> 50: ff ff 00 ff ff ff 00 00 21 60 10 13 19 0f ff 05
                              ^^
OK, my fault. Detection code in the w83781d module expects 0x20 as the
W83627HF chip ID. We used to ignore the LSB, and when I changed that
behavior, I didn't check the exact device ID of all chips. This is why
your W83627HF was not detected as such by the w83781d driver. I just
commited a fix to our CVS repository. Feel free to check it out and give
it a try. It should work, although the w83627hf driver is prefered for
your chip. Comparing both drivers may help you solve a number of issues.
If this happen, let us know so that we can fix whatever needs to be.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
