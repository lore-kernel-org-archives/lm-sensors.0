From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 11 Nov 2008 09:45:10 +0000
Subject: Re: [lm-sensors] Intel DG45FC
Message-Id: <20081111104510.0a35cf04@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <7bccedf10809181658o18aa47bbt46480ca2a67b1ac9@mail.gmail.com>
In-Reply-To: <7bccedf10809181658o18aa47bbt46480ca2a67b1ac9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Anthony,

On Fri, 7 Nov 2008 17:38:00 -0800, Anthony Arobone wrote:
> # isadump 0x2e 0x2f 8
> WARNING! Running this program can cause system crashes, data loss and worse!
> I will probe address register 0x2e and data register 0x2f.
> Probing bank 8 using bank register 0x07.
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 41
> 20: f1 01 00 00 01 01 00 91 00 11 2e 00 00 10 00 00
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

OK, so as expected, the logical device with the hardware monitoring
features is disabled. If you look at ticket #2182 starting at:
http://www.lm-sensors.org/ticket/2182#comment:13

You'll see what we tried with the other user to enable the logical
device and see if it "woke up" the "emulated" LM96000. It did not work
for him, but feel free to try too and see if it helps on your board:

isaset -y 0x2e 0x2f 0x07 8
isaset -y 0x2e 0x2f 0x60 0x02
isaset -y 0x2e 0x2f 0x61 0x90
isaset -y 0x2e 0x2f 0x30 1

(After checking in /proc/ioports that there's nothing at 0x290 on your
system.) Then:

rmmod lm85
modprobe lm85

That being said, I'm not holding my breath. Maybe your system has the
same chip variant (WPCD377i) without the hardware monitoring feature
and that's the reason why all the readings are 0 and the actual
monitoring is done by the Intel ICH chip.

> So I was looking into this a little more and I came across an Intel driver
> called HECI.  I guess it was submitted to the linux kernel, but hasn't made
> it in yet.  At any rate, I downloaded it and some other goodies from
> http://www.openamt.org/.  In short, I tweaked a few places to get it to
> compile and load for my kernel, 2.6.27 (actually on .28-rc3 now).  But I
> think this is the new way to access all the Intel sensors, etc.  I don't
> know much about it yet, looks like it can do alot.  But I didn't see a way
> to get the temp assets from any of the examples, and I don't think I'll have
> anymore time to look into this further.
> 
> Thanks for all your help though, but I think you are right.  Accessing the
> temps via the tradional drivers (for lack of better word) is never going to
> happen.  I think its going to be through this HECI driver, but it looks like
> whatever support was being put into that has flat lined.

Yes, I think you are right here, we need Intel's AMT/HECI stuff in the
kernel first and then we can start working on support for the hardware
monitoring features on top of that framework. That's a long way to go
though so you'll have to be patient. Oh well, maybe by then I will have
access to one of these motherboards so I can start helping Intel with
the code.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
