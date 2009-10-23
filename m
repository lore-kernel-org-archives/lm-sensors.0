From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 23 Oct 2009 07:13:18 +0000
Subject: Re: [lm-sensors] Gigabyte GA-P35-DS3P - VID Zero value
Message-Id: <20091023091318.55c55203@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
In-Reply-To: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Adam,

On Fri, 23 Oct 2009 09:20:37 +1000, Adam Nielsen wrote:
> > Here's a standalone driver for you to try:
> > http://khali.linux-fr.org/devel/misc/it87/
> >
> > Build with "make", then as root, "rmmod it87&&  insmod it87.ko".
> 
> Works fine!  The "cpu0_vid" and "vrm" files disappear from the it87 sysfs 
> directory, and 'sensors' no longer reports a value for the VID.  There is a 
> log message telling me in3 is VCC (+5V), but no log message to tell me the VID 
> is disabled.  Not sure if that's worth including, in case somebody is trying 
> to figure out why their it87 behaves differently to someone else's.

I have been considering it. In general drivers should be quiet when
everything works fine. But indeed this is a change in behavior, which
might be worth underlining in the log. I'll add a message.

> Everything else seems to work as before.

Great, thanks for testing and reporting!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
