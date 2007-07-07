From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sat, 07 Jul 2007 19:01:45 +0000
Subject: Re: [lm-sensors] also recognise /etc/modprobe.conf (Fedora patch)
Message-Id: <468FE319.5000407@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070707195630.3cfded29@hyperion.delvare>
In-Reply-To: <20070707195630.3cfded29@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Sat, 07 Jul 2007 20:01:48 +0200, Hans de Goede wrote:
>> I fully agree, with all of the above. My perl-foo is not all that good, so the 
>> last bullet / point (default depending on kernel version) is probably best 
>> handled by someone else. I can implement the other 2 points if you want, but 
>> those are so trivial that when someone does 3 he can easily do them too, 
>> eitherway let me know.
> 
> I can take care of it. But my initial plan is not correct. My Slackware
> system has both /etc/modprobe.conf and /etc/modules.conf... because it
> can run with either a 2.4 or a 2.6 kernel, and I actually use both
> (it's my test system). In fact, which config file you should edit merely
> depends on the kernel version you're running.
> 
> So I think I'll go with a more straightforward strategy: if kernel >> 2.6.0, use /etc/modprobe.conf, otherwise use /etc/modules.conf. OK?
> 

Sounds fine to me.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
