From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: lm_sensors2/kernel/include sensors.h
Message-Id: <3EFCD70E.8030401@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Don't do this!
sensors.h is now automatically generated...
(see sensors.h.template and Module.mk).
We're going to remove sensors.h from CVS before the release.
If there's a warning to be fixed it's in sensors.h.template??

author@mordac.netroedge.com wrote:
> Update of /home/cvs/lm_sensors2/kernel/include
> In directory mordac.netroedge.com:/tmp/cvs-serv26137
> 
> Modified Files:
> 	sensors.h 
> Log Message:
> (Khali) Trivial warning removal.
> 
