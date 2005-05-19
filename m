From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: lm_sensors2/kernel/chips lm75.h lm75.c
Message-Id: <3FCD4625.2F56CE5E@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031202053341.GB19505@earth.solarsys.private>
In-Reply-To: <20031202053341.GB19505@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

what was broken before?

"Mark M. Hoffman" wrote:
> 
> * author@mordac.netroedge.com <author@mordac.netroedge.com> [2003-12-01 21:53:27 -0800]:
> > Update of /home/cvs/lm_sensors2/kernel/chips
> > In directory mordac.netroedge.com:/tmp/cvs-serv17140/kernel/chips
> >
> > Modified Files:
> >       lm75.c
> > Added Files:
> >       lm75.h
> > Log Message:
> > (mmh) Pulled the TEMP_TO_REG and TEMP_FROM_REG functions into a separate
> >       header and gave them the prefix LM75_. Also rewrote them according
> >       to the lm75 datasheet.  The next step is to replace all the various
> >       scattered (broken?) copies of these functions (especially in Winbond
> >       subclients) with this one.
> 
> This works nicely for me - negative values ok, 1/2 degree increments ok -
> but I should mention I tested it on asb100 and w83627thf (code not yet
> committed).  I haven't actually tested on lm75 itself; I don't have one.
> 
> Comments?
> 
> --
> Mark M. Hoffman
> mhoffman@lightlink.com
