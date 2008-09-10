From: Rudolf Marek <r.marek@assembler.cz>
Date: Wed, 10 Sep 2008 21:06:13 +0000
Subject: Re: [lm-sensors] New winbond chip: W83667HG
Message-Id: <48C836C5.20101@assembler.cz>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080302010401090302090500"
List-Id: <lm-sensors.vger.kernel.org>
References: <200807072054.10321.phhusson@free.fr>
In-Reply-To: <200807072054.10321.phhusson@free.fr>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------080302010401090302090500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Please can you try the patch for sensors-detect? It should detect the chip.

Thanks,
Rudolf

--------------080302010401090302090500
Content-Type: text/x-diff;
 name="detect-w83667hg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="detect-w83667hg.patch"

Index: sensors-detect
===================================================================
--- sensors-detect	(revision 5336)
+++ sensors-detect	(working copy)
@@ -852,6 +852,12 @@
        i2c_detect => sub { w83781d_detect(10, @_); },
      },
      {
+       name => "Nuvoton W83667HG",
+       driver => "use-isa-instead",
+       i2c_addrs => [0x28..0x2f],
+       i2c_detect => sub { w83781d_detect(11, @_); },
+     },
+     {
        name => "Asus AS99127F (rev.1)",
        driver => "w83781d",
        i2c_addrs => [0x28..0x2f],
@@ -1984,6 +1990,14 @@
 	alias_detect => sub { winbond_alias_detect(0x2b, 0x3e, @_); },
       },
       {
+	name => "Nuvoton W83667HG Super IO Sensors",
+	driver => "w83627ehf",
+	devid => 0xA510,
+	devid_mask => 0xFFF0,
+	logdev => 0x0b,
+	alias_detect => sub { winbond_alias_detect(0x2b, 0x3e, @_); },
+      },
+      {
 	name => "Winbond W83L517D Super IO",
 	driver => "not-a-sensor",
 	devid => 0x61,
@@ -4559,7 +4573,8 @@
 # $_[0]: Chip to detect (0 = W83781D, 1 = W83782D, 2 = W83783S,
 #                        3 = W83627HF, 4 = AS99127F (rev.1),
 #                        5 = AS99127F (rev.2), 6 = ASB100, 7 = W83791D,
-#                        8 = W83792D, 9 = W83627EHF 10 = W83627DHG)
+#                        8 = W83792D, 9 = W83627EHF 10 = W83627DHG,
+#                       11 = W83667HG)
 # $_[1]: A reference to the file descriptor to access this chip.
 # $_[2]: Address
 # Returns: undef if not detected, (8, addr1, addr2) if detected, but only
@@ -4610,6 +4625,7 @@
   return if $chip == 8 and  $reg1 != 0x7a;
   return if $chip == 9 and  $reg1 != 0xa1;
   return if $chip == 10 and  $reg1 != 0xa2;
+  return if $chip == 11 and  $reg1 != 0xc1;
   # Default address is 0x2d
   @res = ($addr != 0x2d) ? (7) : (8);
   return @res if $chip >= 9; # No subclients

--------------080302010401090302090500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------080302010401090302090500--
