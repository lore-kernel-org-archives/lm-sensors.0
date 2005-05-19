From: mochel@digitalimplant.org (Patrick Mochel)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: i2c-ali1563 driver
Message-Id: <Pine.LNX.4.50.0404191148200.32074-100000@monsoon.he.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040415202451.3df53f20.khali@linux-fr.org>
In-Reply-To: <20040415202451.3df53f20.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



On Thu, 15 Apr 2004, Jean Delvare wrote:

> Hi Patrick,
>
> Just noticed that you have been writing a Linux 2.6 driver for ALi's
> M1563 SMBus. Two questions:
>
> 1* Do you plan to backport it to Linux 2.4?

No, I do not plan to back port it. It should be straight forward, though.

> 2* It would be great to add support for it to our userspace tool
> "sensors-detect". Basically, all it takes is to add the correct PCI ID
> to the list of supported PCI adapters. I guess that the PCI ID is
> 10B9:1563. Am I correct? Would you agree to test the updated script once
> I am done with it?

Yes, that is the correct ID. And, I would be happy to test the script.



	Pat
