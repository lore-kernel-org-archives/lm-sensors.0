From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 31 Oct 2007 19:40:21 +0000
Subject: Re: [lm-sensors] Intel DP35DP - P35 Sensor Support?
Message-Id: <20071031204021.1a4ce840@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20071015T022008-788@post.gmane.org>
In-Reply-To: <loom.20071015T022008-788@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 30 Oct 2007 15:26:55 -0700, d. d. gmane wrote:
> Here are the results of:  isadump 0x2e 0x2f 0x08
> 
> [root@skippy dump]# pwd
> /home/david/lm_sensors-3.0.0-rc3/prog/dump
> 
> [root@skippy dump]# ./isadump 0x2e 0x2f 0x08
> WARNING! Running this program can cause system crashes, data loss and worse!
> I will probe address register 0x2e and data register 0x2f.
> Probing bank 8 using bank register 0x07.
> Continue? [Y/n] Y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 41
> 20: f1 91 00 00 c1 01 00 91 00 91 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 03 00 00 04 04 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

OK, access to the hardware monitoring device is disabled. If you want
to investigate a bit further, you can attempt to enable it:

* Search in /proc/ioports for a free space of at least 256 bytes,
aligned on a 256-byte boundary (e.g. 0x0a00 to 0x0aff).

* Write the address in question to the PC8374L chip and
  enable the logical device:

isaset 0x2e 0x2f 0x07 0x08
isaset 0x2e 0x2f 0x60 0x0a # <-- high byte of the address
isaset 0x2e 0x2f 0x61 0x00 # <-- low byte of the address
isaset 0x2e 0x2f 0x30 0x01

* Run isadump again and check that the writes were successful:

isadump 0x2e 0x2f 0x08

* If registers 0x30, 0x60 and 0x61 have the expected values, try
  dumping the logical device's I/O area:

isadump -f 0x0a00 # <-- adjust with the address you used

Only do that if you are really motivated in getting the voltage
readings. I don't know the PC8374L very well and it seems to be a
somewhat complex chip - or at least different from what I'm used to.
Even if the sequence above reveals something interesting, there's
probably a long way to go before you can get the voltage readings, and
I am almost certain that you won't get temperatures nor fan speeds from
that device anyway.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
