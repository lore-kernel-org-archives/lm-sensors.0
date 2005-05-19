From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: Setting vrm with 'sensors -s' is broken (w/ Linux 2.6.x)
Message-Id: <1081325108.4073b634e5f4d@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040407035157.GD6289@earth.solarsys.private>
In-Reply-To: <20040407035157.GD6289@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

According to Mark M. Hoffman:

> The problem is in the last 8 lines of lib/proc.c:
> 
> > /* give up, use old name (probably won't work though...) */
> > /* known to be the same:
> >         "alarms", "beep_enable", "vrm", "fan%d_div"
> > */
> >         strcpy(sysname, name);
> >         *sysmag = (feature->scaling=0?0:3);
> >         return 0;
> > }
> 
> Oops, feature->scaling for VRM is 1!  That explains why 'sensors -s'
> tries to write "9000" to vrm instead of "90" under Linux 2.6.x.
> 
> Anyone know what that '=0?0:3' qualification is *supposed* to do?

My bad :( Originally the scaling was left unchanged for unlisted
entries. I thought that in 2.6 all values that weren't integer had
magnitude = 3 (this is the case for temperatures, voltages and
currents) so forcing non-zero magnitudes to 3 would be the best
approximation. Too bad I forgot about vrm (although it is listed in the
comment right above). Actually I though we were manupulating VRM values
as 82 and 90, not 8.2 and 9.0 (although a quick look at sensors.conf.eg
should have made me realize I was wrong).

In fact in looks like all voltage and temperatures cases are explicitly
handled before, so just removing the offending line should be just
find.

Sorry for the trouble.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
