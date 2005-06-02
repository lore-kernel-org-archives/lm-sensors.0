From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 02 Jun 2005 14:50:45 +0000
Subject: [lm-sensors] [Fwd: Linux kernel - i2c - eeprom module]
Message-Id: <429F0092.5000202@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <429C9BCD.1040605@edgedesign.us>
In-Reply-To: <429C9BCD.1040605@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Correct place to ask is this mailing list.

> 
> Lately I've been playing a lot with the kernel i2c modules. I want to
> use the
> eeprom module to read/write eeproms. However, it only has read support,
> and it
> supports only one size (256 bytes). I'm interested in adding new
> features to
> this module. I could code them myself, but I don't know who to ask about
> details...

Well this is quite dangenourous. Athough SPD eeproms do have sometimes writeprotect lock
this is not always true imho.

Now digging through JEDEC standards to see how it is about write protection:

This is aprooved:

"The contents of the lower 128 bytes (bytes 0-127) of the SPD EEPROM must
be software write protected by the DIMM vendor, using one of the two
methods defined by ballot JC-42.4-03-103 (item 1435.01,) either the
permanent software write protect method, or the reversible software write
protect method. This requirement is to be phased in by the end of the first
quarter of 2004."

But I failed to find ballot JC-42.4-03-103 (item 1435.01,) I will try again.

My question is why you need kernel support for this and why you cannot use the userspace utils in
lm_sensors packages for that?

Also when implemented I am for [ ] compile time feature that will clearly state that it is EXTREMLY DANGEROUS

> My question is: who is the current eeprom maintainer?
Most of stuff goes through this list.

Regards

Rudolf

