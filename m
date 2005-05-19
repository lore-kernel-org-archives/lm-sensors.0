From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: Dallas 1-wire protocol implementation.
Message-Id: <20040405222133.39e32924.johnpol@2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040402012453.0b5db46e.johnpol@2ka.mipt.ru>
In-Reply-To: <20040402012453.0b5db46e.johnpol@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greg, Mark, thank you for your suggestions.

This version resolves following issues:
1. Using dev_*() macros instead of log().
2. Using struct pci_device_id and struct pci_driver for registering
	matrox_w1 GPIO device.
3. Code from w1.c was splitted into w1.c, w1_family.[ch] w1_term.c. 
	The latter implements temperature operations. w1_family.[ch] provide
	1-wire families registering/unregistering mechanism.

Patch, w1_family.[ch] and w1_term.c are attached.

Please review and comment.

	Evgeniy Polyakov ( s0mbre )

Only failure makes us experts. -- Theo de Raadt
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w1.patch
Type: application/octet-stream
Size: 16048 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040405/db8a6fc1/w1.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w1_term.c
Type: text/x-csrc
Size: 3861 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040405/db8a6fc1/w1_term.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w1_family.c
Type: text/x-csrc
Size: 2782 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040405/db8a6fc1/w1_family.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w1_family.h
Type: text/x-chdr
Size: 1632 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040405/db8a6fc1/w1_family-0001.bin
