From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 28 Jan 2009 08:06:28 +0000
Subject: Re: [lm-sensors] Problem with order of module loading
Message-Id: <20090128090628.5aca12ff@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090125021151.GE16739@paradise.net.nz>
In-Reply-To: <20090125021151.GE16739@paradise.net.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 26 Jan 2009 15:57:10 +0100, Jean Delvare wrote:
> On Mon, 26 Jan 2009 22:47:36 +1300, Volker Kuhlmann wrote:
> > On Mon 26 Jan 2009 02:47:24 NZDT +1300, Jean Delvare wrote:
> > > I'm not sure why you think my approach wouldn't work. Let's take the
> > > case of your board: the k8temp driver loads automatically, the it87
> > > driver doesn't.
> > > 
> > > At first run, sensors-detect would stop the lm_sensors service (no
> > > effect as the service wasn't configured yet.) It would detect k8temp and
> > > it87, but seeing that k8temp is already loaded, would only list it87
> > > in /etc/sysconfig/lm_sensors.
> > > 
> > > At this point, starting the lm_sensors service only loads it87, because
> > > k8temp is already loaded. Likewise, stopping or restarting the
> > > lm_sensors service only unloads the it87 driver.
> > > 
> > > This means that a further run of sensors-detect will only unload the
> > > it87 driver. Then it will see that k8temp is loaded and again will not
> > > list it in /etc/sysconfig/lm_sensors.
> > 
> > Ah yes, put it like that, it should work. It would be very sensitive to
> > run-status being the same as boot-status though. Is this robust enough?
> 
> I agree it is a little fragile. It should work in the general case if
> the user doesn't edit the configuration file manually and doesn't load
> or unload hwmon drivers on its own. My hope is that users who start
> loading or unloading drivers or editing configuration files will know
> how to fix things if they break. But maybe that's too optimistic.

I have discussed this a bit with Kay Sievers yesterday. He suggested
that we can use the modalias files in sysfs together with "modprobe -n"
to find out whether a loaded hwmon driver has been auto-loaded or not.
This would let us exclude kernel modules from /etc/sysconfig/lm_sensors
based on whether they auto-load rather than based on whether they were
loaded when sensors-detect was run. This should be way more robust than
my initial proposal, to a point where I think it would make sense to
give it a try.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
