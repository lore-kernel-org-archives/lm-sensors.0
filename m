From: herbert@mamute.net (Herbert G. Fischer)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: No sensors found
Message-Id: <002801c4306e$7c6adb10$0100000a@volcano>
List-Id: <lm-sensors.vger.kernel.org>
References: <000801c43068$c801a6e0$0100000a@volcano>
In-Reply-To: <000801c43068$c801a6e0$0100000a@volcano>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've already did this.

The problem is that prog/rrd/* doesn't recognise the kernel 2.6 change.

I'm did some hardcoded paths in there.

----- Original Message ----- 
From: "Jean Delvare" <khali@linux-fr.org>
To: "Herbert G. Fischer" <herbert@mamute.net>
Cc: <sensors@Stimpy.netroedge.com>
Sent: Sunday, May 02, 2004 2:48 PM
Subject: Re: No sensors found


> > Just a problem now..
> > 
> > I don't have the dir "/proc/sys/dev/sensors/" on my running linux.
> > 
> > Neither some dir with the name sensors on /proc ou /sys
> 
> As root:
> mkdir /sys
> mount none /sys -t sysfs
> 
> If you want that done automatically, make sure that to have the
> following line in /etc/fstab:
> none     /sys     sysfs    defaults                        0 0
> 
> Hope that helps.
> 
> -- 
> Jean Delvare
> http://khali.linux-fr.org/
> 
