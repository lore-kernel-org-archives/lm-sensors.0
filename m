From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 03 Sep 2006 08:28:09 +0000
Subject: [lm-sensors] Interface to PCI device list
Message-Id: <20060903102809.0207bcba.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060902164248.9a0075e4.khali@linux-fr.org>
In-Reply-To: <20060902164248.9a0075e4.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

On Sat, 2 Sep, Greg KH wrote:
> On Sat, Sep 02, 2006 at 10:41:51PM +0200, Jean Delvare wrote:
> > For now my code is a ugly hack reading the device list
> > from /proc/bus/pci/devices, then for each device the class
> > from /sys/bus/pci/devices if available. That was the shortest path from
> > the current code to what I wanted to do, and was good enough for
> > testing, but I'd be ashamed to commit it as is. The only advantage is
> > the compatibility with 2.4 kernels.
> 
> Ick, who cares about 2.4 anymore :)

You'd be surprised. We had many requests to backport drivers from 2.6
to 2.4 for chips which are found only on recent (1 or 2 year old)
motherboards. Of course we can ignore these requests, but at least I'd
avoid breaking common code (like the sensors-detect script) which
worked on 2.4 for years. So I'll leave the old code around.

> I'd recommend using sysfs, and following the rules of walking the tree
> and not relying on specific files to be present that might not be in the
> future.  Also please be able to handle any directory turning into a
> symlink at any point in the future too, but since you aren't messing
> with the /sys/class/ directories, I don't think this will be a problem
> for you.

I don't see how it can be a problem at all, given that symbolic links
are meant to be transparent to applications by design. I know recent
events prove me wrong though :(

My algorithm is simple, I do (pseudocode):

opendir("/sys/bus/pci/devices")
  for each entry that matches %x:%x:%x.%x (or %x:%x.%x, just in case),
    add an element to my list of pci devices
    read attribute file "vendor" and store the value
    read attribute file "device" and store the value
    read attribute file "class" and store the value
closedir("/sys/bus/pci/devices")

Now I admit that the code getting the info from /proc was more compact,
but it misses the domain and the class, and adding them would make the
code MUCH more complex, so I'm not gonna do it.

I attached the real code in case someone wants to take a look and
comment. I'll probably apply it soon if no objections arise.

> If you want, we have some very flexible code in udev to traverse sysfs
> and get various things from it.  Feel free to use it, as the license is
> the same for both projects (GPL).

The code was simple enough that I could write it myself in a few
minutes. And I doubt there's much perl code in udev, is there?

Thanks,
-- 
Jean Delvare
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: sensors-detect-sys-pci-bus-devices.patch
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060903/5b6447f6/attachment-0001.pl 
