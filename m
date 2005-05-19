From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: trying BK...
Message-Id: <3FE8FB4D.3080308@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FE8DCDD.9010303@verizon.net>
In-Reply-To: <3FE8DCDD.9010303@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks for the advice, 
that was my goal, to test your current tree, and
eventually to send you patches.
I'll try the usb-2.5.
mds

Greg KH wrote:
> On Tue, Dec 23, 2003 at 07:25:01PM -0500, Mark Studebaker wrote:
> 
>>Greg,
>>I think I have enough bandwidth and disk space now to try BK...
>>I should start by cloning your tree?
> 
> 
> If you want to :)
> 
> 
>>This one bk://kernel.bkbits.net/gregkh/linux/i2c-2.6
> 
> 
> That's not currently available, I need to rebuild all of my
> kernel.bkbits.net bk trees, as they were wiped when the system was
> rebuilt after the breakin on that box.
> 
> 
>>or this one bk://linuxusb.bkbits.net/i2c-2.6
>>or???
> 
> 
> Depends on what you want to do.  If you want to track my current
> development tree, you can use bk://linuxusb.bkbits.net/usb-2.5/  
> 
> Despite the name, it has all of the patches submitted to me for i2c,
> pci, and usb in it.  I then break them out of there and build up a bk
> tree for Linus or Marcelo to pull from.  Or I make patches out of it,
> like I've been doing for the past few days for the sysfs stuff.
> 
> But that tree is not based off of Linus's tree, which is good and bad.
> Good in that it's faster to use it than Linus's tree as there are less
> changesets in it.  Bad in that it's a bit harder to pull patches out of
> at times.
> 
> Not to deter you, but I would recommend you try out the usb-2.5 tree for
> now.  That's what a lot of the usb developers track, and it seems to
> work well for them.  Watch out for a few odd things that I have in that
> tree (lots of extra sysfs and pci hotplug and security patches).
> 
> Also, please go through the bk tutorial on the bk site.  It will help
> you out a lot in figuring out how things work.  If you have any specific
> questions, or you want to send me a patch, have me merge it with my
> tree, and see how you resolve the patch on your end, please let me know.
> 
> thanks,
> 
> greg k-h
> 
