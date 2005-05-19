From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: PC87366 with the net4801
Message-Id: <20040627140811.2cf16d11.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
In-Reply-To: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

(Could you please inline files you are sending instead of gziping
and attaching them? It would make my work easier.)

> > > CPU0 Temp:    +0 C  (low  =    +0 C, high =   +70 C)
> > > CPU0 Crit:   +85 C
> > > CPU1 Temp:    +0 C  (low  =    +0 C, high =   +70 C)
> > > CPU1 Crit:   +85 C
> > > S-IO Temp:   +83 C  (low  =    +0 C, high =   +70 C)   ALARM
> > > S-IO Crit:   +85 C
> > > ERROR: Can't get TEMP4 data!
> > > ERROR: Can't get TEMP4 overtemperature data!
> > > ERROR: Can't get TEMP5 data!
> > > ERROR: Can't get TEMP5 overtemperature data!
> > > temp6:      -273 C  (low  =    +1 C, high =   +67 C)   ALARM
> > > ERROR: Can't get TEMP6 overtemperature data!
> >
> > This is no good (I guess you knew that already).
> >
> > Do the errors happen consistently?
> 
> Yes, they do seem to be consistent.

OK, I found what was causing these errors. Actually it's me, through an
incomplete fix I commited some times ago. I won't go into technical
details, but in the end it triggered an arithmetic error (such as ln(x)
where x<0).

I just fixed it into libsensors. Please do "cvs update lib/chips.c" and
update the library with "make user && make user_install". The errors
should go away and we may have more interesting readings to go with.

Please let me know how it goes after that.

> Yep, definitely quite a bit more output. Included in attachment.

Debug stuff looks good, the thermistor channels are obviously already
activated. I think that you should be able to get readings from temp4
and temp5. OTOH, temp6 doesn't seem to be wired at all.

So I invite you to add the following lines in your configuration file:

   set temp4_min    0
   set temp4_max   85
   set temp5_min    0
   set temp5_max   85

*after* the compute lines. Don't attempt to set temp4/5_crit yet (if
ever). Run "sensors -s" for the new limits to take effect.

> I've also sent that email off to Soekris. Hopefully they'll
> respond to it soon.

I hope too, but in my experience directing technical questions to sales@
rarely works. Don't they have a support@ contact?

-- 
Jean Delvare
http://khali.linux-fr.org/
