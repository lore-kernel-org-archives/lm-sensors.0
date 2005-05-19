From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: lm_sensors on RedHat 7.3
Message-Id: <3DA83F60.66BAE52B@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <E17oTrG-0002E5-00@mendel.bio.caltech.edu>
In-Reply-To: <E17oTrG-0002E5-00@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

David Mathog wrote:
> 
> Re:   Ticket # 994
> 
> Ok, I finally got it to build/work RedHat 7.3.  The problem was that the
> code in Makefile for both i2c and lm_sensors which sets the destination
> directory did not work.  The modules were either not being installed
> (in some cases) or going to the wrong directory (in others). I had to
> manually
> set that  to install.  In both Makefiles I had:
> 
> MODPREF := /lib/modules/2.4.18-3
> 
> on the A7V266E machines and it worked.  However when I set that to
> 
> MODPREF := /lib/modules/2.4.18-3smp
> 
> on the Tyan S2468UGN lm_sensor's install stuck the files under
> ..../misc instead of in the right place, and I had to manually copy them
> up one level to the right directory. I also manually set the SMP
> variable
> which may or may not have been necessary.

see the comment in kernel/chips/Module.mk for an explanation.

> 
> There were a couple of bugs in the /etc/r2.d/init.d startup
> script for lm_sensors.  The repaired one is attached.  (Basically wc
> was returning " 2" instead of "2" for the number of module lines and
> that was messing up the start/stop logic.  I also made it format the
> responses to look nicer on startup with green/red success/failure
> messages.

thanks, I'll merge your changes in.

> 
> Lastly, sensors always shows the negative voltage ranges in the ALARM
> state even when the measured value falls within the specified min/max
> range.
> This was for chip "as99127f" on the Asus A7V266E motherboard.  (I got
> the Tyan 2468 to the point where it would start lm_sensors but have not
> yet worked out the sensors.conf file for it.)  For instance, when -5v
> measures -5.03 and min is -5.48 and max is -4.50 the ALARM is shown.
> Ditto for the -12V range.  I think this is probably a bug in the
> "sensors"
> program having to do with negative voltage comparisons.  Is there a
> known
> fix for it?

The ALARM indication comes from the chip. The sensors program does not
do comparisons.
We don't have as99127f documentation so the ALARM bit mapping could be
wrong.
Sorry.

> 
> Thanks,
> 
> David Mathog
> mathog@caltech.edu
> Manager, Sequence Analysis Facility, Biology Division, Caltech
> 
> 
>                  Name: lm_sensors
>    lm_sensors    Type: unspecified type (application/octet-stream)
>              Encoding: base64
