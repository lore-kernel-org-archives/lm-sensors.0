From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: lm_sensors2/doc/chips asb100
Message-Id: <20040114055324.GO894@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* author@mordac.netroedge.com <author@mordac.netroedge.com> [2004-01-13 22:21:44 -0800]:
> Update of /home/cvs/lm_sensors2/doc/chips
> In directory mordac.netroedge.com:/tmp/cvs-serv4968/doc/chips
> 
> Modified Files:
> 	asb100 
> Log Message:
> (mmh) Add a pointer in case of broken BIOS.

I want to make sure everyone sees this pointer, as it's
close to becoming a FAQ:

--- doc/chips/asb100    5 Jan 2004 03:52:23 -0000       1.2
+++ doc/chips/asb100    14 Jan 2004 06:20:36 -0000
@@ -15,6 +15,15 @@
  
 <TODO: fill in here>
  
+Asus' BIOS is often broken
+--------------------------
+
+If you have an Asus P4PE, you need to read prog/hotplug/README.p4b.
+
+If you have any other (Asus) board for which sensors-detect finds neither
+asb100 nor an I2C bus, please read prog/hotplug/README.p4b before sending
+a bug report.
+
 Description
 -----------

-- 
Mark M. Hoffman
mhoffman@lightlink.com
