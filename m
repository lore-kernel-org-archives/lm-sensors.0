From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 11 Feb 2008 13:20:09 +0000
Subject: [lm-sensors] PATCH: sensors-detect: run chip_special_cases()
Message-Id: <47B04B89.7090705@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040909040902010001000707"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------040909040902010001000707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

The attached patch modifies sensors-detect to run chip_special_cases() earlier 
so that the special chips get added to the modules_supported list.

Without this sensors-detect would wrongly complain that fscher is not a sensor 
chip when run on a system with an fscher chip and the fscher driver already loaded.

If I don't get any objections I will be committing this to svn in a couple of days.

Regards,

Hans

--------------040909040902010001000707
Content-Type: text/x-patch;
	name="lm_sensors-3.0.1-sensors-detect-special-chips.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="lm_sensors-3.0.1-sensors-detect-special-chips.patch"

diff -up lm_sensors-3.0.1/prog/detect/sensors-detect~ lm_sensors-3.0.1/prog/detect/sensors-detect
--- lm_sensors-3.0.1/prog/detect/sensors-detect~	2008-02-11 13:59:25.000000000 +0100
+++ lm_sensors-3.0.1/prog/detect/sensors-detect	2008-02-11 13:59:25.000000000 +0100
@@ -5677,6 +5677,9 @@ sub main
   initialize_conf;
   initialize_proc_pci;
   initialize_modules_list;
+  # make sure any special case chips are added to the chip_ids list before
+  # making the support modules list
+  chip_special_cases();
   initialize_modules_supported;
   initialize_cpu_list();
 
@@ -5740,9 +5744,6 @@ sub main
     print "\n";
   }
 
-  # Before looking for chips, make sure any special case chips are
-  # added to the chip_ids list
-  chip_special_cases();
   $i2c_addresses_to_scan = i2c_addresses_to_scan();
 
   print "We are now going to do the I2C/SMBus adapter probings. Some chips may\n",

--------------040909040902010001000707
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------040909040902010001000707--

