From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: i2c-ali1563 driver
Message-Id: <20040415202451.3df53f20.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Patrick,

Just noticed that you have been writing a Linux 2.6 driver for ALi's
M1563 SMBus. Two questions:

1* Do you plan to backport it to Linux 2.4?

2* It would be great to add support for it to our userspace tool
"sensors-detect". Basically, all it takes is to add the correct PCI ID
to the list of supported PCI adapters. I guess that the PCI ID is
10B9:1563. Am I correct? Would you agree to test the updated script once
I am done with it?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
