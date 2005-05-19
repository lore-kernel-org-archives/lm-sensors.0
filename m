From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: lm_sensors: output for all sensors?
Message-Id: <Pine.LNX.4.58.0406161629570.20062@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200406161539.50952.haimat@lame.at>
In-Reply-To: <200406161539.50952.haimat@lame.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

Please can you take a look to dmesg or syslog if there is something
interresting ? (copy here)

Also what does the output of sensors-detect just before it terminates
says? There should be "recommneded modules".

Thanks
Regards

Rudolf



On Wed, 16 Jun 2004, Matthias F. Brandstetter wrote:

> ---------- quoting Rudolf Marek ----------
> > You have loaded driver for i2c bus (via pro) buy I guess you need
> > one more module for sensors which is as I hope called via686a
> >
> > Plz try
> >
> > modprobe via686a
>
> After issuing this cmd, I still get output for my memory only.
> Do I need any other modules loaded?
>
> Greetings and TIA, Matthias
>
> --
> Just squeeze your rage into a bitter little ball and release it at an
> appropriate time.  Like that day I hit that referee with a whiskey
> bottle.  'Member that?
>
> 		-- Homer Simpson
> 		   Whacking Day
>
