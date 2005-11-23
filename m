From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 23 Nov 2005 22:36:24 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <20051123223705.6aa6ca21.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Henrique,

> > > 60: XX 61 XX XX 64 XX XX XX XX 69 XX XX XX XX XX XX
> > > 70: XX XX XX XX XX XX XX XX
> > 
> > I am really curious what the device at 0x64 can be. We don't know of any
> > device living at that address.
> 
> And that 0x61? What would be that one?

It's tagged "SMBus Device Default Address" in the SMBus 2.0
specification. It seems to be part of the address resolution protocol
together with 0x08 (Host Address) and maybe 0x44 (not mentionned in the
specification but almost always seen on SMBus 2.0 busses.)

I'd guess that a responsive 0x61 address means that at least one device
on the bus is waiting to be given an address, but actually I don't know
much about SMBus ARP and we don't support it at the moment. There is an
experimental driver for 2.4 (smbus-arp) but it's more or less
abandonned. I wish I had an SMBus 2.0 system myself to experiment with,
but unfortunately even the most recent systems I have don't support
SMBus 2.0.

-- 
Jean Delvare
