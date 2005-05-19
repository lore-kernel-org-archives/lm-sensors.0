From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: ALI15X3_smb upgrade BIOS or use force_addr=0xaddr
Message-Id: <t2PNFJTl.1107333014.9307620.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502020137.15626.lists@localguru.de>
In-Reply-To: <200502020137.15626.lists@localguru.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Marcus,

> after going back from kernel 2.6.8 to 2.4.27 sensors-detect produces the
> following output in my syslog:
>
> Feb  2 01:22:09 vernon kernel: ALi Corporation M7101 PMU: ALI15X3_smb
> region uninitialized - upgrade BIOS or use force_addr=0xaddr
> Feb  2 01:22:09 vernon kernel: ALi Corporation M7101 PMU: ALI15X3 not
> detected, module not inserted.
>
> I had no pronlems running kernel 2.6.8 with modules i2c-ali15x3 and lm75 on
> the same machine (i568, 233 MMX). I have no idea how to figure out which
> address range could be free.

The 2.6 kernels have PCI quirks related to the M7101, which might explain
why you didn't have to care about the address there. This might mean we
could even get rid of the force_addr parameter in 2.6.

Why don't you pick the exact same address in 2.4 that was automatically
detected in 2.6? I'd assume this would be the safest choice. Or, like
Mark said, just any free address (i.e. from a range not listed as used
in /proc/ioport) should do.

Thanks,
--
Jean Delvare
