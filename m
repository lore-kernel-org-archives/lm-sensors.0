From: marc@paracel.com (Marc Rieffel)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: Issues with Arima HDAMA Opteron Motherboard
Message-Id: <9D8C1A43309BAD4A9B46071DAF911D9E4C8B39@exch01.paracel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <9D8C1A43309BAD4A9B46071DAF911D9E13FD85@exch01.paracel.com>
In-Reply-To: <9D8C1A43309BAD4A9B46071DAF911D9E13FD85@exch01.paracel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Well, I can't see any assembly code in i2c-algo-biths.c, so it is most
> likely a compiler problem. Anyway, I'm not even sure i2c-algo-biths is
> usable, so who cares...

Yes, it does sound like a compiler problem, apparently one that's been around through several versions of gcc.  

> > Everything else worked just fine, though.  It detected the adm1026
> > chip automatically.
> 
> Do you mean that the same system on which we failed so hard 
> to find the
> adm1026 chip some times ago now just works, without any additional
> effort needed. Wow.

Alas, not quite.  With your help and some tweaks to lm_sensors, I got it working on this dual-Opteron system back with 2.8.1 several months ago.  Now those tweaks are integrated so it just works without additional effort.  That's certainly progress.

The system on which we tried and failed to detect the adm1026 was an Itanium, and I still haven't gotten any sensors working on it, though I haven't tried recently.  I noticed that there's now a FreeIPMI package that might be able to do it.  Perhaps I'll try that some day.

> I'm glad you finally made it, although it doesn't really explain
> anything. And thanks for the hat again ;)

Pas de quoi! :)
