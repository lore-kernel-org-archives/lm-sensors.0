From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 20 Oct 2009 14:15:36 +0000
Subject: Re: [lm-sensors] Gigabyte GA-P35-DS3P - VID Zero value
Message-Id: <20091020161536.28e7a02a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
In-Reply-To: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 20 Oct 2009 22:15:54 +1000, Adam Nielsen wrote:
> > # isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 7
> 
> Ha, well I certainly get different output to Simon:
> 
> $ isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 7
> WARNING! Running this program can cause system crashes, data loss and worse!
> I will probe address register 0x2e and data register 0x2f.
> Probing bank 7 using bank register 0x07.
> Continue? [Y/n] y
> Segmentation fault
> 
> Not sure that GDB is much help here:
> 
> Program received signal SIGSEGV, Segmentation fault.
> 0x0000000000401068 in superio_write_key (addrregF, key=<value optimized
> out>) at /usr/include/sys/io.h:99
> 99        __asm__ __volatile__ ("outb %b0,%w1": :"a" (__value), "Nd" (__port));
> 
> I stuffed around a bit more with the command arguments and eventually got the
> original command to work:
> 
> $ isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 7
> WARNING! Running this program can cause system crashes, data loss and worse!
> I will probe address register 0x2e and data register 0x2f.
> Probing bank 7 using bank register 0x07.
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 00 00 00 00 00 00 07 00 00 00 00 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 87 18 04 10 00 80 df 3f 43 89 00 00 1d 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 08 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 04 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 c2 00 00 00 00 00 00
> c0: 80 1d 3f 43 09 00 00 00 00 19 00 03 08 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 7e
> f0: 10 40 00 00 00 00 11 00 00 00 00 00 3f 00 00 00
> 
> Looks pretty similar to Simon, so I think we're all good there.

Indeed, the relevant registers have the same values, so whatever
applies to Simon probably applies to you as well.

> > as Simon already provided, to comment on your case. Just because the
> > symptoms look similar to Simon's, doesn't mean the problem is the same,
> > nor that the solution (if there exists any) would be the same.
> > Although, given the same motherboard manufacturer, there is a remote
> > chance.
> 
> Yup, like I say, different revisions of the same motherboard.
> 
> >>> One thing we could do is teach the it87 driver to not export the VID
> >>> value if any of VID pins 0-3 are configured for GPIO function. That
> >>> wouldn't be too difficult, but would you be able to test a kernel patch?
> >> I can test an it87 patch if you need a guinea pig - especially if it'll
> >> compile against 2.6.30 so I don't have to reboot ;-)
> > 
> > Sure, I can provide a standalone driver for any kernel version, no
> > reboot needed unless I badly screw up ;)
> 
> Haha yes, of course :-)
> 
> Cheers,
> Adam.
> 
> P.S. Just realised I had sensor programs running while I was running that,
> that's probably the reason for the segfault :-$

Shouldn't be, as the it87 driver doesn't access 0x2e/0x2f past
initialization. But other kernel drivers might. As the same command
that crashed, worked some time after, I admit I have no idea what could
have caused the crash.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
