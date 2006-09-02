From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 02 Sep 2006 14:42:48 +0000
Subject: [lm-sensors] Interface to PCI device list
Message-Id: <20060902164248.9a0075e4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Currently, the sensors-detect script uses /proc/bus/pci/devices (file)
to get a list of the PCI devices on the system. As this file doesn't
contain PCI class data, and I need it, I was looking for an
alternative. For 2.6 kernels, /sys/bus/pci/devices (directory) looks
like the right place to look at. This raises a few questions, which I
hope you can answer:

1* /proc/bus/pci/devices doesn't appear to contain PCI domain
information. I guess it only lists the devices on domain 0000, and
would miss devices on multi-domain machines?

2* Since which kernel version does /sys/bus/pci/devices look like the
way it is right now? Did the device IDs always include the PCI domain?
If it's stable since 2.6.0, I could use it in sensors-detect.

3* Will /sys/bus/pci/devices go away eventually?

Thanks,
-- 
Jean Delvare

