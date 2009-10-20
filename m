From: Simon Wilson <simon@simonandkate.net>
Date: Tue, 20 Oct 2009 02:05:58 +0000
Subject: Re: [lm-sensors] Gigabyte GA-P35-DS3P - VID Zero value
Message-Id: <20091020120558.204768vel4z99ybq@mail.simonandkate.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
In-Reply-To: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Adam Nielsen <a.nielsen@shikadi.net>:

>> The file is dated Sept 20 2006. I suspect this may be the issue... there
>> is nothing in there for VRM 10 or 11. It would appear that I need a
>> later hwmon-vid driver? Or am I completely on the wrong track there LOL...
>
> That's only your installed header file.  It would only affect userspace
> programs doing the conversion themselves.  The latest code from the
> kernel module is at:
>
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;  
> =drivers/hwmon/hwmon-vid.c;hb=HEAD
>
> And all the VID revisions are defined in there.
>
> Well it looks like the value isn't being read properly during chip
> initialisation.  Perhaps a bug in the it87 hwmon driver?
>
> The VID seems to get read in around line 1037:
>
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;  
> =drivers/hwmon/it87.c#l1035
>
> Probably more research required to figure out why that value is zero on
> our motherboards.
>
> Cheers,
> Adam.
>

Thanks for clarifying that. Still new at all this stuff really... :)

Well, based on the git version of hwmon-vid.c the fact that  
/sys/class/hwmon/hwmon0/device/vrm is originally 110 on my system  
would seem to indicate then that the hwmon-vid driver is correctly  
setting the VRM version based on my Conroe CPU to 110. Is there any  
way to interrogate the hwmon-vid driver to see whether it is working  
at a lower level before the it87 driver reads it in?

Perhaps the elrepo.org kmod-it87 driver that I am using needs to be  
updated with more recent code to support the different VID  
configuration of the 8718 and 8720 chips...

Simon.

-- 
Simon Wilson
www.simonandkate.net

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
