From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:59 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.12-rc4 1/15] (dynamic sysfs callbacks)
Message-Id: <253818670505180028696cc991@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705051703394944e949@mail.gmail.com>
	 <20050518072239.GA11889@kroah.com>
In-Reply-To: <20050518072239.GA11889@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Russell King <rmk+lkml@arm.linux.org.uk>

Hi Greg,

On 5/18/05, Greg KH <greg@kroah.com> wrote:
> Ok, I think I got all of these patches applied properly (hint, don't
> label your intro message as 1/15, it should be 0/14, with 14 different
> patches, that threw me off for a bit.)  I've also included your i2c
> driver patch for the adm1026 driver only.  All of these patches are now
> in my tree and can be found on kernel.org in the place where my
> patchscripts notified you.  If you could verify them I would appreciate
> it (I also added a few patches for stuff that was in my tree only, like
> new i2c drivers and some usb and pci sysfs stuff to make them build
> properly.)  All of this should show up in the next -mm release too.

Thanks a lot! Sorry about the incorrect numbering, first time I've
done an intro. I'll have to send you a patch against the differences
between 2.6.12-rc4 and 2.6.12-rc4-mm2 so we don't run into a huge
amount of trouble when they merge...

A quick glance through everything looks fine, but I'll do a proper
check tomorrow using your git tree.

> Thanks a lot for sticking with this process, I really appreciate it.
> Now you can get back to actually fixing up the i2c drivers you wanted
> to, which was what you wanted to do in the first place :)

Yes it will be good to get back to my own area for a bit, maybe even
finally get bmcsensors into a state where it can be accepted :-),
however it has been a nice break and I can see other areas that could
benefit from things along the line of this patch so I might yet
intrude upon the rest of the kernel again ;-).

Thanks,
Yani

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
