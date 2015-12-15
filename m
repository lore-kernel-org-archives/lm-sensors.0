From: Andreas Werner <andreas.werner@men.de>
Date: Tue, 15 Dec 2015 15:11:24 +0000
Subject: Re: [lm-sensors] LM90 driver and ti tmp461 detection
Message-Id: <20151215151123.GA2349@awelinux>
List-Id: <lm-sensors.vger.kernel.org>
References: <20151210120856.GA27765@awelinux>
 <5669AB55.5030309@roeck-us.net>
 <20151210171231.GA28022@awelinux>
 <20151212110842.10e7693e@endymion.delvare>
In-Reply-To: <20151212110842.10e7693e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.de>
Cc: Andreas Werner <andreas.werner@men.de>, Guenter Roeck <linux@roeck-us.net>, wni@nvidia.com, jdelvare@suse.com, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Sat, Dec 12, 2015 at 11:08:42AM +0100, Jean Delvare wrote:
> Hallo Andreas,
> 
> On Thu, 10 Dec 2015 18:12:31 +0100, Andreas Werner wrote:
> > thanks for the register dump :-)
> 
> Can you please share the register dump of your TMP461 with us?
> 
> Thanks,
> -- 
> Jean Delvare
> SUSE L3 Support

Hi,
here is the register dump of the tmp461.
It seemse that we really cannot detect if it is a tmp461 or a tmp451.
Also the magic "ID Register" offset 0xff is 0x00 for both devices.

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 5a 00 2c 00 05 7f 80 7f 80 00 00 00 00 00 00 00    Z.,.?????.......
10: 00 00 00 f0 00 80 03 00 00 7f 00 00 00 00 00 00    ...?.??..?......
20: 7f 0a 01 00 00 XX 00 00 00 00 0e 00 00 00 40 00    ???..X....?...@.
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 55 00    ..............U.

Regards
Andy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
