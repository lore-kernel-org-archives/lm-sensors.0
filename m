From: marc@paracel.com (Marc Rieffel)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: lm_sensors on Itanium
Message-Id: <9D8C1A43309BAD4A9B46071DAF911D9E3E2A14@exch01.paracel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <9D8C1A43309BAD4A9B46071DAF911D9E4C89F0@exch01.paracel.com>
In-Reply-To: <9D8C1A43309BAD4A9B46071DAF911D9E4C89F0@exch01.paracel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

OK, thanks!  I'll see what I can get from Intel.

> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Wednesday, March 03, 2004 1:58 PM
> To: Marc Rieffel
> Cc: sensors@Stimpy.netroedge.com
> Subject: Re: lm_sensors on Itanium
> 
> 
> > After modifying smsc47m1.c, sensors-detect didn't detect 
> anything, but
> > manually loading the smsc47m1 driver succeeded and gave me bogus fan
> > speeds,
> > 
> > sensors
> > smsc47m1-isa-0800
> > Adapter: ISA adapter
> > fan1:       -1 RPM  (min = 2997 RPM, div = 2)
> > fan2:       -1 RPM  (min = 2997 RPM, div = 2)
> 
> Looks like the chip is there and activated, but no fans are 
> plugged. No
> luck...
> 
> > What do you think is preventing us from accessing the adm1026 chip?
> 
> The fact that we cannot find on which bus it is. Franckly, I have no
> more clue. Time to contact the motherboard and/or system 
> vendor and ask
> for information?
> 
> -- 
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
> 
