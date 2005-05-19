From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: lm_sensors2/kernel/chips lm75.h lm75.c
Message-Id: <20031203032838.GA13028@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031202053341.GB19505@earth.solarsys.private>
In-Reply-To: <20031202053341.GB19505@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Mark D. Studebaker <mds@paradyne.com> [2003-12-02 21:10:45 -0500]:
> what was broken before?

Good question.  Actually the macros in lm75.c -r1.44 worked OK for negative
values.  However, many of the cloned copies which handle subclient sensors
(like w83781d.c) do not.  The limits according to the datasheet (-55 to
+125 C) were/are indeed broken everywhere.  The idea is to implement this
common conversion once.

I'd also like to think that my version is easier to read... ;) but if
people disagree then I'll try again or revert it.

Also btw: the special as99127 temp conv routines never made any sense to
me at all.  I'm not saying they're wrong for as99127, but they *are* wrong
for asb100.  Result is that anyone going from kernel 2.4 + sensors cvs to
kernel 2.6 will have broken temp readings on asb100 until I get that driver
ported and merged.

> "Mark M. Hoffman" wrote:
> > 
> > * author@mordac.netroedge.com <author@mordac.netroedge.com> [2003-12-01 21:53:27 -0800]:
> > > Update of /home/cvs/lm_sensors2/kernel/chips
> > > In directory mordac.netroedge.com:/tmp/cvs-serv17140/kernel/chips
> > >
> > > Modified Files:
> > >       lm75.c
> > > Added Files:
> > >       lm75.h
> > > Log Message:
> > > (mmh) Pulled the TEMP_TO_REG and TEMP_FROM_REG functions into a separate
> > >       header and gave them the prefix LM75_. Also rewrote them according
> > >       to the lm75 datasheet.  The next step is to replace all the various
> > >       scattered (broken?) copies of these functions (especially in Winbond
> > >       subclients) with this one.
> > 
> > This works nicely for me - negative values ok, 1/2 degree increments ok -
> > but I should mention I tested it on asb100 and w83627thf (code not yet
> > committed).  I haven't actually tested on lm75 itself; I don't have one.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
