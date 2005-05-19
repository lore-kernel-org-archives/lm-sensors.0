From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:33 +0000
Subject: Asus P4B266-C
Message-Id: <20020523092101.M3066@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020503123913.C10198@Stimpy.netroedge.com>
In-Reply-To: <20020503123913.C10198@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Yeah, it looks like the chip is a ASUS ASIC.  I wonder if we can get
documentation for it?


Phil

On Thu, May 23, 2002 at 02:20:22AM -0400, Eric P. McCoy wrote:
> On Wed, 22 May 2002 13:40:22 -0700 you wrote:
> 
> > Hi, nag away. :')
> > Take a look at this (a link from the news on our home page):
> > http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/hotplug/README.p4b
> > I'm fuzzy as to what this does, but you may want to get the latest CVS
> > and follow the directions.
> 
> According to the stuff I read about it, it reenables the, uh... i801
> sensors?  The ones on the i845 chipset.  ASUS disabled the sensors on
> the PCI bus at the factory, so the above is a hack to get it working
> again.  You use some pciutils programs to tweak the bus and reenable the
> sensor, then use the above driver to hot-plug the "new" device and make
> the kernel detect it.  Then the i801 driver from lm-sensors will work.
> 
> The problem, of course, is that the i801 only has like one sensor.  I've
> tried it and it works, but I was hoping for fan speeds and voltages too.
>  Also I'm not really wild about PCI bus hacking (because I don't
> understand it at all), even if it is just to reveal hidden devices.
> 
> -- 
> Eric McCoy (reverse "ten.xoc@mpe", mail to "ctr2sprt" is filtered)
> 
> "Last I checked, it wasn't the power cord for the Clue Generator that
> was sticking up your ass."	- John Novak, rasfwrj

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
