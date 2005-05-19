From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:34 +0000
Subject: [2.6 patch] i2c-core.c: make some code static
Message-Id: <20050131230416.59daa051.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050131185955.GA18316@stusta.de>
	<20050131215050.61c2924c.khali@linux-fr.org>
	<20050131214622.GF21437@stusta.de>
In-Reply-To: <20050131214622.GF21437@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@stusta.de>
Cc: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org, greg@kroah.com

Hi Adrian,

> > > -struct bus_type i2c_bus_type = {
> > > -	.name =		"i2c",
> > > -	.match =	i2c_device_match,
> > > -	.suspend =      i2c_bus_suspend,
> > > -	.resume =       i2c_bus_resume,
> > > -};
> > (...)
> > 
> > Is moving that code around really necessary? Looks to me like only
> > the i2c_bus_type structure needs to be moved.
> 
> i2c_bus_type requires i2c_device_match, i2c_bus_suspend and 
> i2c_bus_resume...

Oops, seems I missed the obvious here :/

Sorry for the noise. I guess I better get some sleep now...

-- 
Jean Delvare
