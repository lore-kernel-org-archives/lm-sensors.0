From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 06 Jul 2006 14:08:13 +0000
Subject: [lm-sensors] AMD K8 digital temperature sensor
Message-Id: <44AD194D.8050303@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <44A9941C.4020106@sh.cvut.cz>
In-Reply-To: <44A9941C.4020106@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I have updated the archive at http://assembler.cz/download/amd_digital_temp.tar.gz

So it supports the userspace too ;)

There was a little problem with PCI support to libsensors but it seems I solved
it somehow. I'm attaching the patch here too.

It adds new bus of type PCI and does not change the "address" which is scalar.
Instead it "concatenates" the PCI addr together.

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control

k8temp-pci-0183
Adapter: PCI adapter
Core0Temp:   +47?C

Regards
Rudolf


-------------- next part --------------
A non-text attachment was scrubbed...
Name: add_pci_and_k8temp.patch
Type: text/x-patch
Size: 8333 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060706/cec73032/attachment-0001.bin 
