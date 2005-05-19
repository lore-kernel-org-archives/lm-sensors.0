From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: lm_sensors2/doc useful_addresses.html
Message-Id: <20031119053441.GA2277@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* author@mordac.netroedge.com <author@mordac.netroedge.com> [2003-11-18 21:34:19 -0800]:
> Update of /home/cvs/lm_sensors2/doc
> In directory mordac.netroedge.com:/tmp/cvs-serv32488
> 
> Modified Files:
> 	useful_addresses.html 
> Log Message:
> (mmh) Added links to GKrellM and smartmontools.

Regarding smartmontools...  if you want drive temperature
try this:

smartctl -A /dev/hda | grep "^194 " | awk '{print $10}'

That package also apparently supports reading SMART info from
individual drives connected to a 3ware RAID controller - nice!

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
