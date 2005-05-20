From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 20 May 2005 10:27:02 +0000
Subject: [lm-sensors] Motherboard data collection
Message-Id: <0DCLQpJL.1116577130.9944310.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200505190141.07306.holger.oehm@holger-oehm.de>
In-Reply-To: <200505190141.07306.holger.oehm@holger-oehm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hallo Holger,

> > Unfortunately not, although the need exists and some tries were made.
>
> Hmm, they failed? Why? Is it just that collecting the data would mean
> a *lot* of work? Or would you say it simply cant be done?
> What if someone would volunteer to give it a try? (Probably one of my
> worst ideas lately ;-)

It can be done. The point was to build a system which would require next
to zero maintenance time: a web interface, where users could easily add
their own configuration files (wiki-like, in a way). But setting this up
requires a time and energy investment, which just didn't happen.

> Well, creating some formal place for board-sorted sensors.conf files
> (for example somewhere on the lm_sensors page or just a folder structure 
> in CVS) would not be the problem, I assume?

It would, and is what I had in mind in the first place too. Although much
more simple to set up, it would require work from us for every added or
modified configuration file, we can't really afford that.

Thanks,
--
Jean Delvare
