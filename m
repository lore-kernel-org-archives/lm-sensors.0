From: "Ian Dobson" <i.dobson@planet-ian.com>
Date: Tue, 12 Apr 2011 16:49:43 +0000
Subject: Re: [lm-sensors] Standalone driver for W83677HG-I, NCT6775F,
Message-Id: <CCFE26677DFD461B82943F1AD4CF18C9@portable2>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110205175852.GA26672@ericsson.com>
In-Reply-To: <20110205175852.GA26672@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



--------------------------------------------------
From: "Ian Pilcher" <arequipeno@gmail.com>
Sent: Sunday, April 10, 2011 5:28 PM
To: <lm-sensors@lm-sensors.org>
Subject: Re: [lm-sensors] Standalone driver for W83677HG-I, 
NCT6775F,NCT6776F [rev 2]

> Just a quick note that this driver (10-Mar-2011?) seems to be working
> well on my Intel DQ67SW.  Temperature and fan monitoring were pretty
> easy to set up (no thermistors, thank goodness!); I haven't bothered
> with fan control, since that seems to be working "automagically".
>
> As always, trying to figure out how they've wired up the voltages will
> be the most challenging part.  I was hoping that Intel might be more
> forthcoming in this area than other manufacturers, but that does not
> appear to be the case.
>
> With a bit of luck, I should be able to post a config for this board
> relatively shortly.
>
> What kernel version is this updated driver likely to appear in?  I'd
> love to get rid of the DKMS hackery.
>
> Thanks!
>
> -- 
> ====================================
> Ian Pilcher                                         arequipeno@gmail.com
> "If you're going to shift my paradigm ... at least buy me dinner first."
> ====================================
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
Hi,

The merge request went in during the .39 merge window, so the driver should 
make it into 2.6.39

Regards
Ian Dobson
 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
