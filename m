From: gregkh@suse.de (Greg KH)
Date: Mon, 06 Feb 2006 20:18:57 +0000
Subject: [lm-sensors] [PATCH] i2c: Rename i2c-sis96x documentation file
Message-Id: <11392571371257@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Rename i2c-sis96x documentation file

This patch just renames the documentation file to correct file name.
i2c-sis69x -> i2c-sis96x.

Signed-off-by: Rudolf Marek <r.marek at sh.cvut.cz>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit 806ba6409061ae49421319e3745026014abc49c2
tree c23a62bb0d8367d38b3e75841d72881d882391c8
parent 413b64515079a4063776d81067f69cc41bdb34ad
author Rudolf Marek <r.marek at sh.cvut.cz> Mon, 09 Jan 2006 22:46:14 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Mon, 06 Feb 2006 12:02:14 -0800

 Documentation/i2c/busses/i2c-sis69x |   73 -----------------------------------
 Documentation/i2c/busses/i2c-sis96x |   73 +++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 73 deletions(-)

diff --git a/Documentation/i2c/busses/i2c-sis69x b/Documentation/i2c/busses/i2c-sis69x
deleted file mode 100644
index b88953d..0000000
--- a/Documentation/i2c/busses/i2c-sis69x
+++ /dev/null
@@ -1,73 +0,0 @@
-Kernel driver i2c-sis96x
-
-Replaces 2.4.x i2c-sis645
-
-Supported adapters:
-  * Silicon Integrated Systems Corp (SiS)
-    Any combination of these host bridges:
-	645, 645DX (aka 646), 648, 650, 651, 655, 735, 745, 746
-    and these south bridges:
-    	961, 962, 963(L) 
-
-Author: Mark M. Hoffman <mhoffman at lightlink.com>
-
-Description
------------
-
-This SMBus only driver is known to work on motherboards with the above
-named chipset combinations. The driver was developed without benefit of a
-proper datasheet from SiS. The SMBus registers are assumed compatible with
-those of the SiS630, although they are located in a completely different
-place. Thanks to Alexander Malysh <amalysh at web.de> for providing the
-SiS630 datasheet (and  driver).
-
-The command "lspci" as root should produce something like these lines:
-
-00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0645
-00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
-00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
-
-or perhaps this...
-
-00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0645 
-00:02.0 ISA bridge: Silicon Integrated Systems [SiS]: Unknown device 0961
-00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
-
-(kernel versions later than 2.4.18 may fill in the "Unknown"s)
-
-If you cant see it please look on quirk_sis_96x_smbus
-(drivers/pci/quirks.c) (also if southbridge detection fails)
-
-I suspect that this driver could be made to work for the following SiS
-chipsets as well: 635, and 635T. If anyone owns a board with those chips
-AND is willing to risk crashing & burning an otherwise well-behaved kernel
-in the name of progress... please contact me at <mhoffman at lightlink.com> or
-via the project's mailing list: <lm-sensors at lm-sensors.org>.  Please
-send bug reports and/or success stories as well.
-
-
-TO DOs
-------
-
-* The driver does not support SMBus block reads/writes; I may add them if a
-scenario is found where they're needed.
-
-
-Thank You
----------
-
-Mark D. Studebaker <mdsxyz123 at yahoo.com>
- - design hints and bug fixes
-Alexander Maylsh <amalysh at web.de>
- - ditto, plus an important datasheet... almost the one I really wanted
-Hans-G?nter L?tke Uphues <hg_lu at t-online.de>
- - patch for SiS735
-Robert Zwerus <arzie at dds.nl>
- - testing for SiS645DX
-Kianusch Sayah Karadji <kianusch at sk-tech.net>
- - patch for SiS645DX/962
-Ken Healy
- - patch for SiS655
-
-To anyone else who has written w/ feedback, thanks!
-
diff --git a/Documentation/i2c/busses/i2c-sis96x b/Documentation/i2c/busses/i2c-sis96x
new file mode 100644
index 0000000..00a009b
--- /dev/null
+++ b/Documentation/i2c/busses/i2c-sis96x
@@ -0,0 +1,73 @@
+Kernel driver i2c-sis96x
+
+Replaces 2.4.x i2c-sis645
+
+Supported adapters:
+  * Silicon Integrated Systems Corp (SiS)
+    Any combination of these host bridges:
+	645, 645DX (aka 646), 648, 650, 651, 655, 735, 745, 746
+    and these south bridges:
+    	961, 962, 963(L)
+
+Author: Mark M. Hoffman <mhoffman at lightlink.com>
+
+Description
+-----------
+
+This SMBus only driver is known to work on motherboards with the above
+named chipset combinations. The driver was developed without benefit of a
+proper datasheet from SiS. The SMBus registers are assumed compatible with
+those of the SiS630, although they are located in a completely different
+place. Thanks to Alexander Malysh <amalysh at web.de> for providing the
+SiS630 datasheet (and  driver).
+
+The command "lspci" as root should produce something like these lines:
+
+00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0645
+00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
+00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
+
+or perhaps this...
+
+00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0645
+00:02.0 ISA bridge: Silicon Integrated Systems [SiS]: Unknown device 0961
+00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
+
+(kernel versions later than 2.4.18 may fill in the "Unknown"s)
+
+If you cant see it please look on quirk_sis_96x_smbus
+(drivers/pci/quirks.c) (also if southbridge detection fails)
+
+I suspect that this driver could be made to work for the following SiS
+chipsets as well: 635, and 635T. If anyone owns a board with those chips
+AND is willing to risk crashing & burning an otherwise well-behaved kernel
+in the name of progress... please contact me at <mhoffman at lightlink.com> or
+via the project's mailing list: <lm-sensors at lm-sensors.org>.  Please
+send bug reports and/or success stories as well.
+
+
+TO DOs
+------
+
+* The driver does not support SMBus block reads/writes; I may add them if a
+scenario is found where they're needed.
+
+
+Thank You
+---------
+
+Mark D. Studebaker <mdsxyz123 at yahoo.com>
+ - design hints and bug fixes
+Alexander Maylsh <amalysh at web.de>
+ - ditto, plus an important datasheet... almost the one I really wanted
+Hans-G?nter L?tke Uphues <hg_lu at t-online.de>
+ - patch for SiS735
+Robert Zwerus <arzie at dds.nl>
+ - testing for SiS645DX
+Kianusch Sayah Karadji <kianusch at sk-tech.net>
+ - patch for SiS645DX/962
+Ken Healy
+ - patch for SiS655
+
+To anyone else who has written w/ feedback, thanks!
+


