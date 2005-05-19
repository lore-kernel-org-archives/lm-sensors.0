From: patrik@yes.nu (Patrik Kullman)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: SiS 651 chipset
Message-Id: <1101917532.31169.8.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello!

I was browsing your "Supported chipsets"[1] page and saw that my SiS 651
computer should have the i2c-sis645 kernel-module, but my kernel-sources
(2.6.9) only have i2c-sis96x.

Is this the same module? [2]
It doesn't seem that way, since you're listing both drivers on the
"Supported chipsets"-page.

Final question would be:
Does my kernel lack the recommended module or is the "Supported
chipsets"-page out of sync?

Also, what would the best way be to use the sensors on this kind of
motherboard?
Right now I'm using i2c-isa and it87 (it87-isa-0290).

Thanks in advance,
Patrik


1. http://secure.netroedge.com/~lm78/supported.html
2. http://seclists.org/lists/linux-kernel/2003/May/3614.html
