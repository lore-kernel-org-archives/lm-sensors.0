From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 20 Feb 2006 09:42:19 +0000
Subject: [lm-sensors] Output (i2cdump) for ULI M1695 Chipset
Message-Id: <RADiPUpX.1140428539.4397450.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200602192129.02414.s.kostka@arcor.de>
In-Reply-To: <200602192129.02414.s.kostka@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hallo Sebastian,

On 2006-02-19, Sebastian Kostka wrote:
> So here is my output of i2cdump which unfortunaltely never changed - But i
> went back to Windows and wrote down what Speedfan detected, i hope this
> helps you a little.
> (...)
> Default:(vcore 1,1v)
> 00: c3 8b 18 00 03 45 02 00 9c 34 3f 00 00 03 09 00    ???.?E?.?4?..??.
> 10: 18 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00    ?...?...........
> 
> Default: (vcore 1,4volt)
> 00: c3 8b 18 00 03 45 02 00 9c 34 3f 00 00 03 09 00    ???.?E?.?4?..??.
> 10: 18 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00    ?...?...........
> 
> Overclocked: (vcore 1,4v)
> 00: c3 8b 18 00 03 45 02 00 9c 34 3f 00 00 03 09 00    ???.?E?.?4?..??.
> 10: 18 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00    ?...?...........
> 
> Overclocked (100% CPU) (vcore 1,4v)
> 00: c3 8b 18 00 03 45 02 00 9c 34 3f 00 00 03 09 00    ???.?E?.?4?..??.
> 10: 18 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00    ?...?...........

No change, so it has to be a control device and not a monitoring device.

> Scanning Uli SMBus at $0400...
> LM80 found on SMBus at $22

I'm pretty certain this is a misdetection, as the LM80 has most of its
registers between 0x20 and 0x3b, and the chip you have doesn't even
seem to have registers there.

At this point, the only way to figure out what this mysterious chip is,
is to ask the motherboard manufacturer directly - if you want to do that
at all. After all, you have monitoring working on your system and
that's what you wanted in the first place, I guess.

--
Jean Delvare

