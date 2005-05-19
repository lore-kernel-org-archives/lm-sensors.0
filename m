From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: [Fwd: i850 && lm_sensors]
Message-Id: <20030721143738.455afdaa.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F16EFDB.4040504@edgedesign.us>
In-Reply-To: <3F16EFDB.4040504@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> i2cdetect 0:
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX 2d XX XX
> 30: 30 31 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX
> 50: 50 51 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX

OK. 0x50 and 0x51 are your memory chip EEPROMs. 0x30 and 0x31 are likely
to be "ghost images" of these EEPROMs, don't care about them. 0x2d is
used very often by sensor chips, I think your chip is there. 0x44 isn't
used by any chip we know of, but it could be a subaddress for the chip
at 0x2d.

The sensors-detect script didn't find what the chip at 0x2d is, so
whatever it is, it's likely to be unsupported for now. However, it may
be similar enough to a chip we know to either direclty work with another
driver, or be possibly added to a driver.

I would like you to run "i2cdump 0 0x2d" and tell us what it says.
Additionally, the output of "i2cdump 0 0x44" would be welcome.

> on Intel's Express Installer CD is "Intel Active Monitor" (windows
> version of course ;-( and it works perfectly. It works with Intel
> SMBus driver, so one of this chips is on my motherboard:
> 
> Intel(R) 82801AA  I/O Controller Hub (ICH)
> Intel(R) 82801AB  I/O Controller Hub (ICH0)
> Intel(R) 82801BA  I/O Controller Hub (ICH2)
> Intel(R) 82801CAM I/O Controller Hub (ICH3M)
> Intel(R) 82801DB  I/O Controller Hub (ICH4)
> 
> Manual of iD850EMD2 && iD850EMV2 talks about Intel 82801BA I/O
> Controller Hub (=ICH2), so this is "problem" chip.

I don't think the bus chip cause any problem. It is detected and seem to
work. The sensor chip is the problem.

Could you use the Windows software to try to find out what the sensor
chip name is? That would help us a lot. If you could tell us how many
values and of what kind it returns, it would help too (how many
voltages, temperatures, can you set a low limit, a high limit,
hysteresis values, and so on). Maybe you could find info in the
motherboard manual too.

> btw: unfortunately, I'll go to holiday next week, so I won't be able
> to reply mails :-(

That ain't unfortunate. Holidays are great :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
