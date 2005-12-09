From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 09 Dec 2005 20:35:22 +0000
Subject: [lm-sensors] i2cdetect fails on a Asus P5ND2-Sli Deluxe
Message-Id: <20051209213522.4415984b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4399D312.1010109@free.fr>
In-Reply-To: <4399D312.1010109@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Fred,

> And lspci sounds good :
> 
> 0000:00:0a.0 ISA bridge: nVidia Corporation: Unknown device 0030 (rev a3)
>         Subsystem: Asustek Computer, Inc.: Unknown device 818a
>         Flags: bus master, 66MHz, fast devsel, latency 0
> 
> 0000:00:0a.1 SMBus: nVidia Corporation: Unknown device 0034 (rev a2)
>         Subsystem: Asustek Computer, Inc.: Unknown device 818a
>         Flags: 66MHz, fast devsel, IRQ 3
>         I/O ports at e400 [size2]
>         I/O ports at 5000 [sized]
>         I/O ports at 5100 [sized]
>         Capabilities: <available only to root>

It doesn't, actually. Device 0x0034 isn't supported by the i2c-nforce2
driver (yet). No wonder it doesn't work.

What kind of nForce chip is it? If it brand new?

You may take your chance and add 0x0034 to the list of IDs in
drivers/i2c/busses/i2c-nforce2.c. If your chip is actually compatible
with the earlier incarnations, it may work. Or it may not work, and
may even do bad things. Unless you have a datasheet, it's impossible
for us to tell. And you're on your own if something bad happens, of
course.

If you try it out, please let us know the outcome.

-- 
Jean Delvare

