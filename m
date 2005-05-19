From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:54 +0000
Subject: sensord: rrd database and timeslots
Message-Id: <20040423112037.GA13931@pc.aurel32.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040421222823.GA14256@pc.aurel32.private>
In-Reply-To: <20040421222823.GA14256@pc.aurel32.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Apr 22, 2004 at 11:04:42AM +0200, Mario 'BitKoenig' Holbe wrote:
> Hi,
Hi !

> (I'm the user who suggested the patch)
> 
> On Thu, Apr 22, 2004 at 12:28:23AM +0200, Aurelien Jarno wrote:
> > On IRC, Jean Delvare suggests to disable the interpolation function of

> Afaik you cannot disable the interpolation of rrd, except you
> store data exactly at the 'official timeslots'.
It is possible to change the option passed to rrd_create from AVERAGE to
LAST; it has to be done in sensord. However, it stills keep the date of 
the official 'timeslots'.

> I'm currently running the modified sensord with both parts
> of my patch (sampling at fixed timeslots and 'faking' the
> samle time) on a quite fast machine (P3-1000) with quite low
> load (something around 0.5). But even there, according to
> the modification time of the rrd, it happens quite often,
> that the update happens one second after the official timeslot
> (for example at 00:00:01 instead of 00:00:00).
> This is no big issue, if the RRD update interval is something
> like 5 minutes: the deviance in this case would be something
> around 0.3%. However, the issue grows with smaller update
> intervals: with 1 minute update interval you get a deviance
> of 1.6%, which leads to a noticeable interpolation.
What is the problem with such an interpolation? I totally agree that it
is better that have to be sampled as near as possible from the time
slots to get correct values. However, IMHO the values would be more
"true" if the sensors are sampled a little to late but corrected than if
they are sample to late and not corrected.

Bye,
Aurelien

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
