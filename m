From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: lm_sensors2/kernel/chips w83792d.c
Message-Id: <20050329011601.GA14733@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* author@mordac.netroedge.com <author@mordac.netroedge.com> [2005-03-26 17:44:27 -0800]:
> Update of /home/cvs/lm_sensors2/kernel/chips
> In directory mordac.netroedge.com:/tmp/cvs-serv26712
> 
> Modified Files:
> 	w83792d.c 
> Log Message:
> (mds) fix negative fan values. Patch from Chunhao.

Why is there a huge 'do {...} while(0)' loop in w83792d_fan()?  I guess
it's some kind of fan divisor auto-configuration.  If that's the case,
shouldn't it be 'do {...} while(1)'?  Also, why not move the 
w83792d_update_client() call to the bottom of the loop?

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
