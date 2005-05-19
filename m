From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:24 +0000
Subject: lm_sensors2 Makefile CHANGES
Message-Id: <20031111064711.GB30118@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark:

* author@mordac.netroedge.com <author@mordac.netroedge.com> [2003-11-08 19:00:31 -0800]:
> Update of /home/cvs/lm_sensors2
> In directory mordac.netroedge.com:/tmp/cvs-serv12500
> 
> Modified Files:
> 	Makefile CHANGES 
> Log Message:
> (mds) add dependency on the kernel .config file; quit without it

Thanks for this, I had forgotten about it.

I added the dependency to *.d as well, seems to work ok.
Also, this issue first came about due to RedHat related
FAQs, so I added some text to hopefully help resolve that.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
