From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 01 Dec 2009 18:55:53 +0000
Subject: Re: [lm-sensors] LPC47M192-NC Fans
Message-Id: <20091201195553.2d60c56c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
In-Reply-To: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sean,

On Tue, 1 Dec 2009 12:49:59 -0500 (EST), Sean Fidler wrote:
> That's the mystery, the BIOS does show the temperature and the fan 
> speed.

What does it list exactly? Labels and values please.

Do the values somehow correlate with what the smsc47m192 driver
provides?

As this is a vendor machine, it is possible that it is using custom
logic for hardware monitoring.

> Here's the information you requested (isadump -k 0x55 0x2e 0x2f 0x0a):
> 
> 
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 00 00 00 00 00 00 0a 00 00 00 00 00 00 00 00 
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> 20: 60 01 19 00 44 00 2e 00 00 00 00 00 00 00 00 00 
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> 60: 06 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> a0: 00 00 00 00 00 00 00 00 00 00 ff ff ff ff ff ff 
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> f0: 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Hmm. Not activated, but I/O port set (0x600 at 0x60). Nothing there
according to your /proc/ioports. Let's try to enable it:

# isaset -y -f 0x2e 0x55
# isaset -y 0x2e 0x2f 0x07 0x0a
# isaset -y 0x2e 0x2f 0x30 0x01
# isaset -y -f 0x2e 0xaa

After that, check with isadump that register 0x30 has value 0x01
instead of 0x00:

# isadump -k 0x55 0x2e 0x2f 0x0a

If it worked, try loading the smsc47m1 driver, and see if "sensors"
shows something new. If not, search your kernel logs for a new error
message.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
