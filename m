From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Wed, 14 Sep 2005 04:12:43 +0000
Subject: [lm-sensors] libsensors / libsysfs patches for review
Message-Id: <20050914021217.GA28187@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050911040600.GB3629@jupiter.solarsys.private>
In-Reply-To: <20050911040600.GB3629@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again:

* Mark M. Hoffman <mhoffman@lightlink.com> [2005-09-11 00:06:00 -0400]:
> Known caveats: 
> 
> 1) To build libsensors on a box w/ Linux 2.4.x kernel, you still need to have
> built and installed libsysfs first.  That's awkward for sure, but it's only
> temporary.  The long-term plan is for lib/sysfs.c to be optional.  Likely
> I'll add more automagic to the makefile.

Decided to do this sooner rather than later - the seventh patch in the series
addresses it.  The other six haven't changed; all seven are here:

http://members.dca.net/mhoffman/sensors/patches/lm_sensors2/20050913/

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

