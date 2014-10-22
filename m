From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 22 Oct 2014 22:53:35 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (i5500_temp) Don't bind to disabled sensors
Message-Id: <20141022225335.GA20733@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20141022111321.22ab7122@endymion.delvare>
In-Reply-To: <20141022111321.22ab7122@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Romain,

On Wed, Oct 22, 2014 at 07:54:49PM +0200, Romain Dolbeau wrote:
> 2014-10-22 18:26 GMT+02:00 Guenter Roeck <linux@roeck-us.net>:
> > Is there really no other register you can use to detect if the sensor is enabled ?
> > How about the TSTIMER register ?
> 
> As far as I can tell (but I'm not an expert), all the documented
> registers display "sane" values, so it's hard to tell apart working

Too bad. I thought that maybe the TSTIMER would have its poweron
value of 0, though the datasheet is a bit confusing in that regard.
It seems to state that the default value is 0 and 200,000 at the
same time.

Maybe it is as simple as VCCTS or TSIREF not connected on the
'failing' board.

Did you check for 'thermal error enable' in the GERRCTL register ?

> and non-working systems. I tried copying the whole register
> space from the working to the non-working system, and it didn't
> help one bit. Seems there's some undocumented initialization
> missing (or the sensor is just not there).
> 
> So among the possibilities I see
> 
> 1) Jean's solution, which I think is the best one. Simply reject
> if TSFSC=0x7F and document why.  In the odd case where a
> cold system won't load, the admin can always load it on a
> warm (literally) system (@reboot in crontab).
> 
> 2) the variability solution. perhaps a tiny bit more reliable, but
> much more complicated (and how much time does it take
> of TSFSC to react to change in TSTHRHI anyway ?)
> 
> 3) depends on some undocumented behavior, such as the
> byte @ 0xE4 seemingly containing (TSTHRTHI-TSFSC).
> 
> 4) the TSTHRCATA register is write-once, and (apparently)
> already written on the "working" system but not on the
> "non-working" system. But that's on a sample of 1 system
> of either kind, so again not very safe.
> 
> I think 1) is still the best solution, because it's simple
> and has no side-effect other than not loading in an hypothetical
> scenario unlikely to happen. 5500-based system are 3 to 4
> generations back, it's unlikely chipset temperature is going
> to be a critical factor where the driver just _must_ load :-)
> 
I thought you were suggesting solution 2) earlier ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
