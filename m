From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: Ticket #1941: nforce4 support in sensors-detect
Message-Id: <20050325220626.4fdc613c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Here is a patch to sensors-detect which should add detection for your
nForce4 SMBus. Can you please try and report? If it doesn't work, please
provide the output of lspci -v and lspci -n.

Thanks,
-- 
Jean Delvare
-------------- next part --------------
Index: prog/detect/sensors-detect
=================================RCS file: /home/cvs/lm_sensors2/prog/detect/sensors-detect,v
retrieving revision 1.376
diff -u -r1.376 sensors-detect
--- prog/detect/sensors-detect	20 Mar 2005 21:10:24 -0000	1.376
+++ prog/detect/sensors-detect	25 Mar 2005 21:23:03 -0000
@@ -670,6 +670,22 @@
        match => sub { $_[0] =~ /^SMBus nForce2 adapter at / },
      }, 
      {
+       vendid => 0x10de,
+       devid  => 0x00E4,
+       func => 1,
+       procid => "nVidia Corporation nForce3 250Gb SMBus (MCP)",
+       driver => "i2c-nforce2",
+       match => sub { $_[0] =~ /^SMBus nForce2 adapter at / },
+     }, 
+     {
+       vendid => 0x10de,
+       devid  => 0x0052,
+       func => 1,
+       procid => "nVidia Corporation nForce4 SMBus (MCP)",
+       driver => "i2c-nforce2",
+       match => sub { $_[0] =~ /^SMBus nForce2 adapter at / },
+     }, 
+     {
        vendid => 0x1166,
        devid  => 0x0200,
        func => 0,
