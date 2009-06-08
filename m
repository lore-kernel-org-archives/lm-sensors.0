From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 08 Jun 2009 18:19:26 +0000
Subject: Re: [lm-sensors] hwmon-vid driver from linux 2.6.29
Message-Id: <20090608201926.40f47d3c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A0C6BF7.9010107@assembler.cz>
In-Reply-To: <4A0C6BF7.9010107@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 8 Jun 2009 21:03:32 +0300, Hleb Valoshka wrote:
> On 6/8/09, Jean Delvare <khali@linux-fr.org> wrote:
> > For completeness, please also provide the output of:
> > isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 7
> 
> su@globus-debian:~$ sudo isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 7
> [sudo] password for globus:
> WARNING! Running this program can cause system crashes, data loss and worse!
> I will probe address register 0x2e and data register 0x2f.
> Probing bank 7 using bank register 0x07.
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 00 00 00 00 00 00 07 00 00 00 00 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 87 16 00 10 1a 00 00 00 80 00 00 00 1f 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 02 20 02 38 00 00 00 00 00 00 00 00 00 00
> 70: 00 01 00 38 00 04 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 80 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 27 00 00 00 00 00 32 00 00 00

VID input value is alternatively available at 0xfc, but as you can see
the value is the same: 0x32, which we know is not correct.

> > And also tell me which revision is printed when you load the it87
> > driver.
> 
> it87: Found IT8716F chip at 0x228, revision 0

A revision C chip... for what it's worth.

> it87: in3 is VCC (+5V)
> it87: in7 is VCCH (+5V Stand-By)

You can use this information to tweak your configuration file. Ideally
the driver would export the labels...

> > You could contact the motherboard vendor and tell them about the
> > problem (the question is "Is VID5 properly routed from CPU to
> > IT8716F?") and see what they have to say about this.
> 
> The question is sent.

OK, thanks. Please let us know if you manage to get something useful.

> > I don't really know how to work around this. I suspect that only the
> > late 0Fh family CPUs actually make use of VID5. If I am right then we
> > could tweak the hwmon-vid VRM selection table and use 5-pin VID (VRM
> > code 24) for some of the 0Fh family CPUs. I don't know where to put the
> > limit, and this is fixing the problem where it is not... which is
> > likely to cause even more problems on other systems in the future.
> 
> AFAIR my CPU is based on early revisions of Brisban core.

Correct.

> > Maybe we can have a DMI-based workaround either in it87 or hwmon-vid.
> > This is ugly and we avoid it as much as possible, but if there's no
> > other way... Hleb, please provide the output of dmidecode on your
> > system.
> 
> It's in attachment

OK, thanks. The DMI data is good so at least we know we can use it for
a mainboard-specific quirk if needed.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
