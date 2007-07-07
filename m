From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 07 Jul 2007 19:00:50 +0000
Subject: Re: [lm-sensors] also recognise /etc/modprobe.conf (Fedora patch)
Message-Id: <20070707210050.1719129d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070707195630.3cfded29@hyperion.delvare>
In-Reply-To: <20070707195630.3cfded29@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 07 Jul 2007 20:01:48 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> >> --- /lm-sensors/branches/lm-sensors-3.0.0/prog/detect/sensors-detect (revision 4562)
> >> +++ /lm-sensors/branches/lm-sensors-3.0.0/prog/detect/sensors-detect (revision 4567)
> >> @@ -2168,6 +2168,8 @@
> >>      $modules_conf = '/etc/modules.conf';
> >>    } elsif (-f '/etc/conf.modules') {
> >>      $modules_conf = '/etc/conf.modules';
> >> +  } elsif (-f '/etc/modprobe.conf') {
> >> +    $modules_conf = '/etc/modprobe.conf';
> >>    } else { # default
> >>      $modules_conf = '/etc/modules.conf';
> >>    }
> > 
> > Very good. We should have done this a long time ago, I think that all
> > the distributions out there were patching sensors-detect that way.
> > 
> > I would go even further:
> > 
> > * We can probably drop support for /etc/conf.modules entirely?
> > 
> > * If both /etc/modprobe.conf and /etc/modules.conf are present, it is
> > likely that /etc/modprobe.conf should be used, so I we should test it
> > first.
> > 
> > * If neither file is found, the default could depend on the kernel
> > version. Defaulting to /etc/modules.conf for a 2.6 kernel-based system
> > is rather unlikely to be correct.
> 
> I fully agree, with all of the above. My perl-foo is not all that good, so the 
> last bullet / point (default depending on kernel version) is probably best 
> handled by someone else. I can implement the other 2 points if you want, but 
> those are so trivial that when someone does 3 he can easily do them too, 
> eitherway let me know.

I can take care of it. But my initial plan is not correct. My Slackware
system has both /etc/modprobe.conf and /etc/modules.conf... because it
can run with either a 2.4 or a 2.6 kernel, and I actually use both
(it's my test system). In fact, which config file you should edit merely
depends on the kernel version you're running.

So I think I'll go with a more straightforward strategy: if kernel >2.6.0, use /etc/modprobe.conf, otherwise use /etc/modules.conf. OK?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
