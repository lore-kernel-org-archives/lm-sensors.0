From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 05 Sep 2006 10:05:06 +0000
Subject: [lm-sensors] Interface to PCI device list
Message-Id: <20060905120506.616c1450.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060902164248.9a0075e4.khali@linux-fr.org>
In-Reply-To: <20060902164248.9a0075e4.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > I'd recommend using sysfs, and following the rules of walking the tree
> > and not relying on specific files to be present that might not be in the
> > future.  Also please be able to handle any directory turning into a
> > symlink at any point in the future too, but since you aren't messing
> > with the /sys/class/ directories, I don't think this will be a problem
> > for you.
> 
> I don't see how it can be a problem at all, given that symbolic links
> are meant to be transparent to applications by design. I know recent
> events prove me wrong though :(
> 
> My algorithm is simple, I do (pseudocode):
> 
> opendir("/sys/bus/pci/devices")
>   for each entry that matches %x:%x:%x.%x (or %x:%x.%x, just in case),
>     add an element to my list of pci devices
>     read attribute file "vendor" and store the value
>     read attribute file "device" and store the value
>     read attribute file "class" and store the value
> closedir("/sys/bus/pci/devices")
> 
> Now I admit that the code getting the info from /proc was more compact,
> but it misses the domain and the class, and adding them would make the
> code MUCH more complex, so I'm not gonna do it.
> 
> I attached the real code in case someone wants to take a look and
> comment. I'll probably apply it soon if no objections arise.

I just applied a cleaned-up version of this patch to SVN.

-- 
Jean Delvare

