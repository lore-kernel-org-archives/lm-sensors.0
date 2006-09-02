From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 02 Sep 2006 20:41:51 +0000
Subject: [lm-sensors] Interface to PCI device list
Message-Id: <20060902224151.0bfc151d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060902164248.9a0075e4.khali@linux-fr.org>
In-Reply-To: <20060902164248.9a0075e4.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

> > 1* /proc/bus/pci/devices doesn't appear to contain PCI domain
> > information. I guess it only lists the devices on domain 0000, and
> > would miss devices on multi-domain machines?
> 
> Yes, it doesn't contain domain info on x86 boxes.  Not sure about bigger
> ones like ia64 or ppc64.

I just checked on two ia64 boxes, one with domains and one without, and
the info doesn't appear to be in /proc/bus/pci/devices (same column
count, none of which matched the domains). The difference is in the
names of the directories below /proc/bus/pci.

On the multi-domain ia64 machine:

dr-xr-xr-x 2 root root 0 2006-09-02 22:08 0001:00
dr-xr-xr-x 2 root root 0 2006-09-02 22:08 0002:00
dr-xr-xr-x 2 root root 0 2006-09-02 22:08 0003:00
dr-xr-xr-x 2 root root 0 2006-09-02 22:08 0004:00
dr-xr-xr-x 2 root root 0 2006-09-02 22:08 0005:00
dr-xr-xr-x 2 root root 0 2006-09-02 22:08 0006:00
dr-xr-xr-x 2 root root 0 2006-09-02 22:08 0011:00
dr-xr-xr-x 2 root root 0 2006-09-02 22:08 0012:00
dr-xr-xr-x 2 root root 0 2006-09-02 22:08 0013:00
dr-xr-xr-x 2 root root 0 2006-09-02 22:08 0013:01
dr-xr-xr-x 2 root root 0 2006-09-02 22:08 0014:00
dr-xr-xr-x 2 root root 0 2006-09-02 22:08 0014:01
dr-xr-xr-x 2 root root 0 2006-09-02 22:08 0015:00
dr-xr-xr-x 2 root root 0 2006-09-02 22:08 0015:01
dr-xr-xr-x 2 root root 0 2006-09-02 22:08 0016:00
-r--r--r-- 1 root root 0 2006-09-02 22:08 devices

On another machine:

dr-xr-xr-x  2 root root 0 2006-09-02 22:09 00
dr-xr-xr-x  2 root root 0 2006-09-02 12:31 01
dr-xr-xr-x  2 root root 0 2006-09-02 22:09 02
-r--r--r--  1 root root 0 2006-09-02 22:09 devices

So on the multi-domain machine, the domain is prepended to the bus
number. This is where lspci appears to be taking the information when
told to use /proc. I found that lspci was using /sys/bus/pci/devices by
default on Linux 2.6. It can be forced back to using /proc/bus/pci,
with more or less success depending on the system.

> > 2* Since which kernel version does /sys/bus/pci/devices look like the
> > way it is right now? Did the device IDs always include the PCI domain?
> > If it's stable since 2.6.0, I could use it in sensors-detect.
> 
> /sys/bus/pci/devices has always been there since 2.6.0.  I don't know
> for sure about the format of the pci bus ids, but I think they have been
> the same since that time too.

Good. I checked on 2.6.5 (Suse flavor) and it's indeed the same. And
I think supporting from 2.6.5 is good enough, nobody sane would use a
2.6 kernel older than that these days.

> > 3* Will /sys/bus/pci/devices go away eventually?
> 
> No, that is the proper way to easily enumerate all PCI devices in the
> system.  X is also switching over to use this, so it can not go away any
> time in the next couple of years, unless something really wrong is found
> with it (and something new would have to be created for it, which I
> don't see happening...)

Damn. I thought your answer was a bit strange, until I read my question
again and noticed I had messed up ;) Let me try again:

3B* Will /proc/bus/pci go away eventually?

Of course, I did not expect /sys/bus/pci/devices to go away by the
next 7 years...

> Hope this helps,

Well, now I get to decide what I want to do. I need the PCI class and
this doesn't appear to be easy to get using /proc/bus/pci (you need to
walk through subdirectories, and extract the 3 class bytes from each
binary file.) This seems much easier to get it
from /sys/bus/pci/devices (single directory to get the list, then just
one text file to read to get the class for each device.)

For now my code is a ugly hack reading the device list
from /proc/bus/pci/devices, then for each device the class
from /sys/bus/pci/devices if available. That was the shortest path from
the current code to what I wanted to do, and was good enough for
testing, but I'd be ashamed to commit it as is. The only advantage is
the compatibility with 2.4 kernels.

Thanks,
-- 
Jean Delvare

