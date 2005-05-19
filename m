From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: lm_sensors2/kernel/busses i2c-ali1535.c
Message-Id: <20050329013146.GB14733@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* author@mordac.netroedge.com <author@mordac.netroedge.com> [2005-03-26 18:22:10 -0800]:
> Update of /home/cvs/lm_sensors2/kernel/busses
> In directory mordac.netroedge.com:/tmp/cvs-serv31041
> 
> Modified Files:
> 	i2c-ali1535.c 
> Log Message:
> (mds) add delay loops everywhere, as recommended by the ALI 1535 Bios Programming Guide.
>       Should fix stability problems.
>       Patch by Ubel Walter <ubel@heidenhain.de>

The patch has a lot of noise, but...

Picking a random port for the delay loop might not always be safe.
You should at least [request|release]_region() on it.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
