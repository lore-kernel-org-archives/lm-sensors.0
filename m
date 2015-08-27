From: Fengguang Wu <fengguang.wu@intel.com>
Date: Thu, 27 Aug 2015 08:24:14 +0000
Subject: Re: [lm-sensors] [hwmon:watchdog-next 25/25] drivers/watchdog/txx9wdt.c:134:20: error: 'pdev' undecl
Message-Id: <20150827082414.GB7941@wfg-t540p.sh.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <201508190641.YilMpD2S%fengguang.wu@intel.com>
In-Reply-To: <201508190641.YilMpD2S%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Aug 27, 2015 at 09:33:18AM +0200, Jean Delvare wrote:
> On Wed, 19 Aug 2015 06:03:43 +0800, kbuild test robot wrote:
> > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-next
> > head:   8f5555c0f5a355e5f45944d9517e983a1146fe4a
> > commit: 8f5555c0f5a355e5f45944d9517e983a1146fe4a [25/25] Watchdog: Fix parent of watchdog_devices
> > config: mips-jmr3927_defconfig (attached as .config)
> > reproduce:
> >   wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
> >   chmod +x ~/bin/make.cross
> >   git checkout 8f5555c0f5a355e5f45944d9517e983a1146fe4a
> >   # save the attached .config to linux build tree
> >   make.cross ARCH=mips 
> > 
> > All error/warnings (new ones prefixed by >>):
> > 
> >    drivers/watchdog/txx9wdt.c: In function 'txx9wdt_probe':
> > >> drivers/watchdog/txx9wdt.c:134:20: error: 'pdev' undeclared (first use in this function)
> >      txx9wdt.parent = &pdev->dev;
> >                        ^
> >    drivers/watchdog/txx9wdt.c:134:20: note: each undeclared identifier is reported only once for each function it appears in
> > 
> > vim +/pdev +134 drivers/watchdog/txx9wdt.c
> > 
> >    128	
> >    129		if (timeout < 1 || timeout > WD_MAX_TIMEOUT)
> >    130			timeout = TIMER_MARGIN;
> >    131		txx9wdt.timeout = timeout;
> >    132		txx9wdt.min_timeout = 1;
> >    133		txx9wdt.max_timeout = WD_MAX_TIMEOUT;
> >  > 134		txx9wdt.parent = &pdev->dev;
> >    135		watchdog_set_nowayout(&txx9wdt, nowayout);
> >    136	
> >    137		ret = watchdog_register_device(&txx9wdt);
> 
> You are sending this to the wrong mailing list, lm-sensors has nothing
> to do with watchdog drivers.

Sorry! Will fix it right away.

Thanks,
Fengguang

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
