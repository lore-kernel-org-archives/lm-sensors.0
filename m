From: Kelly Anderson <kelly@silka.with-linux.com>
Date: Fri, 07 Sep 2012 05:52:24 +0000
Subject: [lm-sensors] [PATCH]: Asus E35M1-I deluxe sensor support
Message-Id: <50498B98.60502@silka.with-linux.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080707070505040704040208"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------080707070505040704040208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I've put a patch for linux 3.5.3 together to support the it8771f on the 
e35m1-i deluxe motherboard.  It may not be perfect due to the fact that 
it is a custom Asus chip without technical doc available but it does 
seem to give proper results.  This may also work on the e45m1-i deluxe 
as well, but i'm not sure.

I've attached the patch as well as inlined it.

--- ./drivers/hwmon/it87.c.orig    2012-08-25 20:32:13.000000000 -0600
+++ ./drivers/hwmon/it87.c    2012-08-29 02:32:16.613908298 -0600
@@ -61,7 +61,7 @@

  #define DRVNAME "it87"

-enum chips { it87, it8712, it8716, it8718, it8720, it8721, it8728, it8782,
+enum chips { it87, it8712, it8716, it8718, it8720, it8721, it8728, 
it8771, it8782,
           it8783 };

  static unsigned short force_id;
@@ -140,6 +140,7 @@ static inline void superio_exit(void)
  #define IT8721F_DEVID 0x8721
  #define IT8726F_DEVID 0x8726
  #define IT8728F_DEVID 0x8728
+#define IT8771F_DEVID 0x8771
  #define IT8782F_DEVID 0x8782
  #define IT8783E_DEVID 0x8783
  #define IT87_ACT_REG  0x30
@@ -303,7 +304,8 @@ static inline int has_12mv_adc(const str
       * on selected inputs.
       */
      return data->type == it8721
-        || data->type == it8728;
+        || data->type == it8728
+        || data->type == it8771;
  }

  static inline int has_newer_autopwm(const struct it87_data *data)
@@ -313,7 +315,8 @@ static inline int has_newer_autopwm(cons
       * mapping and the manual duty cycle.
       */
      return data->type == it8721
-        || data->type == it8728;
+        || data->type == it8728
+        || data->type == it8771;
  }

  static int adc_lsb(const struct it87_data *data, int nr)
@@ -412,6 +415,7 @@ static inline int has_16bit_fans(const s
          || data->type == it8720
          || data->type == it8721
          || data->type == it8728
+        || data->type == it8771
          || data->type == it8782
          || data->type == it8783;
  }
@@ -1701,6 +1705,9 @@ static int __init it87_find(unsigned sho
      case IT8728F_DEVID:
          sio_data->type = it8728;
          break;
+    case IT8771F_DEVID:
+        sio_data->type = it8771;
+        break;
      case IT8782F_DEVID:
          sio_data->type = it8782;
          break;
@@ -1818,7 +1825,7 @@ static int __init it87_find(unsigned sho

          reg = superio_inb(IT87_SIO_GPIO3_REG);
          if (sio_data->type == it8721 || sio_data->type == it8728 ||
-            sio_data->type == it8782) {
+            sio_data->type == it8771 || sio_data->type == it8782) {
              /*
               * IT8721F/IT8758E, and IT8782F don't have VID pins
               * at all, not sure about the IT8728F.
@@ -1875,7 +1882,8 @@ static int __init it87_find(unsigned sho
          if (reg & (1 << 0))
              sio_data->internal |= (1 << 0);
          if ((reg & (1 << 1)) || sio_data->type == it8721 ||
-            sio_data->type == it8728)
+            sio_data->type == it8728 ||
+            sio_data->type == it8771)
              sio_data->internal |= (1 << 1);

          /*
@@ -1984,6 +1992,7 @@ static int __devinit it87_probe(struct p
          "it8720",
          "it8721",
          "it8728",
+        "it8771",
          "it8782",
          "it8783",
      };



--------------080707070505040704040208
Content-Type: text/plain; charset=ISO-8859-1;
 name="Kernel-3.5.3-it8771f.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Kernel-3.5.3-it8771f.patch"

--- ./drivers/hwmon/it87.c.orig	2012-08-25 20:32:13.000000000 -0600
+++ ./drivers/hwmon/it87.c	2012-08-29 02:32:16.613908298 -0600
@@ -61,7 +61,7 @@
 
 #define DRVNAME "it87"
 
-enum chips { it87, it8712, it8716, it8718, it8720, it8721, it8728, it8782,
+enum chips { it87, it8712, it8716, it8718, it8720, it8721, it8728, it8771, it8782,
 	     it8783 };
 
 static unsigned short force_id;
@@ -140,6 +140,7 @@ static inline void superio_exit(void)
 #define IT8721F_DEVID 0x8721
 #define IT8726F_DEVID 0x8726
 #define IT8728F_DEVID 0x8728
+#define IT8771F_DEVID 0x8771
 #define IT8782F_DEVID 0x8782
 #define IT8783E_DEVID 0x8783
 #define IT87_ACT_REG  0x30
@@ -303,7 +304,8 @@ static inline int has_12mv_adc(const str
 	 * on selected inputs.
 	 */
 	return data->type == it8721
-	    || data->type == it8728;
+	    || data->type == it8728
+	    || data->type == it8771;
 }
 
 static inline int has_newer_autopwm(const struct it87_data *data)
@@ -313,7 +315,8 @@ static inline int has_newer_autopwm(cons
 	 * mapping and the manual duty cycle.
 	 */
 	return data->type == it8721
-	    || data->type == it8728;
+	    || data->type == it8728
+	    || data->type == it8771;
 }
 
 static int adc_lsb(const struct it87_data *data, int nr)
@@ -412,6 +415,7 @@ static inline int has_16bit_fans(const s
 	    || data->type == it8720
 	    || data->type == it8721
 	    || data->type == it8728
+	    || data->type == it8771
 	    || data->type == it8782
 	    || data->type == it8783;
 }
@@ -1701,6 +1705,9 @@ static int __init it87_find(unsigned sho
 	case IT8728F_DEVID:
 		sio_data->type = it8728;
 		break;
+	case IT8771F_DEVID:
+		sio_data->type = it8771;
+		break;
 	case IT8782F_DEVID:
 		sio_data->type = it8782;
 		break;
@@ -1818,7 +1825,7 @@ static int __init it87_find(unsigned sho
 
 		reg = superio_inb(IT87_SIO_GPIO3_REG);
 		if (sio_data->type == it8721 || sio_data->type == it8728 ||
-		    sio_data->type == it8782) {
+		    sio_data->type == it8771 || sio_data->type == it8782) {
 			/*
 			 * IT8721F/IT8758E, and IT8782F don't have VID pins
 			 * at all, not sure about the IT8728F.
@@ -1875,7 +1882,8 @@ static int __init it87_find(unsigned sho
 		if (reg & (1 << 0))
 			sio_data->internal |= (1 << 0);
 		if ((reg & (1 << 1)) || sio_data->type == it8721 ||
-		    sio_data->type == it8728)
+		    sio_data->type == it8728 ||
+		    sio_data->type == it8771)
 			sio_data->internal |= (1 << 1);
 
 		/*
@@ -1984,6 +1992,7 @@ static int __devinit it87_probe(struct p
 		"it8720",
 		"it8721",
 		"it8728",
+		"it8771",
 		"it8782",
 		"it8783",
 	};

--------------080707070505040704040208
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------080707070505040704040208--
