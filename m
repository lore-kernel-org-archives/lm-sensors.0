From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 27 Sep 2008 11:47:14 +0000
Subject: Re: [lm-sensors] Intel DG45FC
Message-Id: <20080927134714.1668ecd7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <7bccedf10809181658o18aa47bbt46480ca2a67b1ac9@mail.gmail.com>
In-Reply-To: <7bccedf10809181658o18aa47bbt46480ca2a67b1ac9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Anthony,

On Fri, 26 Sep 2008 10:19:31 -0700, Anthony Arobone wrote:
> Hi Jena,  thanks a lot for your help.
> 
> My BIOS does display all the correct values for temps and voltage for
> everything.

OK. So either the LM96000 can be re-enabled, or there's another
monitoring chip on your motherboard.

Can you please list the labels and values displayed by your BIOS? To
check whether this corresponds to the LM96000 inputs or not.

> > Can you please provide a dump of your chip? You should be able to get
> > it the following way:
> >
> > # rmmod lm85
> > # modprobe i2c-dev
> > # i2cdump 0 0x2e b
> >
> 
> I have i2c-dev built into kernel. Hope that's not a problem.

It's OK.

> # i2cdump 0 0x2e b
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c/0, address 0x2e, mode byte
> Continue? [Y/n] Y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 20: 00 00 00 00 00 00 00 00 ff ff ff ff ff ff ff ff    ................
> 30: ff ff ff 00 00 00 00 00 00 00 00 00 00 00 01 68    ..............?h
> 40: 04 00 00 00 00 ff 00 ff 00 ff 00 ff 00 ff 81 7f    ?.............??
> 50: 81 7f 81 7f ff ff ff ff ff ff ff ff 62 62 62 c4    ????........bbb?
> 60: c4 c4 00 00 80 80 80 00 00 00 64 64 64 44 44 a4    ??..???...dddDD?
> 70: ff ff ff 00 00 00 08 00 00 22 6e 6e 6e 00 00 00    ......?.."nnn...
> 80: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ?...............
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> f0: 00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00    ........?.......

OK, so this is basically the same case as in ticket 2182: first version
of the LM96000, and strange value in register 0x6f. So please do the
same test I suggested in this ticket:

# rmmod lm85
# i2cset -y 0 0x2e 0x40 0x04
# i2cset -y 0 0x2e 0x6f 0x00
# i2cset -y 0 0x2e 0x40 0x05
# modprobe lm85

And report if it helps or not.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
