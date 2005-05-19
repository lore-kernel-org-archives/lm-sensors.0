From: mathog@mendel.bio.caltech.edu (David Mathog)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: ticket 1775
Message-Id: <E1CCMpv-0007kt-00@mendel.bio.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1C9PtS-000754-00@mendel.bio.caltech.edu>
In-Reply-To: <E1C9PtS-000754-00@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

WARNING: This e-mail has been altered by MIMEDefang.  Following this
paragraph are indications of the actual changes made.  For more
information about your site's MIMEDefang policy, contact
andrew.net.au Postmaster <postmaster@andrew.net.au>.  For more information about MIMEDefang, see:

            http://www.roaringpenguin.com/mimedefang/enduser.php3

An attachment named sensor_monitor.sh was removed from this document as it
constituted a security hazard.  If you require this document, please contact
the sender and arrange an alternate means of receiving it.

-------------- next part --------------
> > By the way, why are there no shutdown options in sensord?
> 
> Sensord is abandonware. It's that easy. None of us developers use it.

Ah, that would explain a few things.  Guess I'll shut it off then
until I get enough time to see what state it's really in.

> 
> > sensord does pretty much everything mondo does except give
> > an option for shutdown.  Is this feature going to be added to
> > sensord anytime soon?
> 
> Patches are welcome ;)
> 
> > Failing that, what is the most common "shut down on over temperature"
> > script/program in use with lm_sensors on 2.6.x kernels?
> 
> No idea, sorry.
> 

Turned out not to be too difficult to roll my own.  One of the
attached two files use my "extract" program

 ftp://saf.bio.caltech.edu/pub/software/linux_or_unix_tools/extract.c

and lm_sensors and that's pretty much it to monitor CPU T and Fan
speeds, with a final poweroff if a value gets too badly out of range,
logs and warnings otherwise.

[For Unix purists extract could be eliminated and replaced with
sed, set, awk or the like, but it's my Swiss army
knife program and builds and runs on every OS I've tried so
far, so I tend to use it a lot.]

sensor_monitor is the /etc/rc.d/init.d script and should work as
is on Mandrake, RedHat, and other similar systems. 

sensor_monitor.sh is the daemon script, mine lives in /usr/local/sbin

When running it doesn't go above .3% CPU, and then only once every
5 seconds, so the load is negligible.

Regards,


David Mathog
mathog@caltech.edu
Manager, Sequence Analysis Facility, Biology Division, Caltech
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/octet-stream
Size: 2063 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040928/b5347961/attachment.obj
