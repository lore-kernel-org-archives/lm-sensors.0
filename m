From: Lu Zhihe <tombowfly@gmail.com>
Date: Fri, 09 Oct 2009 14:07:41 +0000
Subject: Re: [lm-sensors] [Module] hwmon: GM/GME965 GM45 and more chips IGP
Message-Id: <73511e6c0910090707x71aa521ar25646d12a02dcdcb@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <73511e6c0907180440p43b81f33x85c4dc70007165b3@mail.gmail.com>
In-Reply-To: <73511e6c0907180440p43b81f33x85c4dc70007165b3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

     Thank you very much for your reply!

2009/10/8 Jean Delvare <khali@linux-fr.org>:
> Hi Lu,
> Can you please elaborate about it? Don't you ever plan to get your
> driver included in the kernel tree?

   I am glad to know you think it maybe worth to merge to the kernel
tree. :-)  Thank you again!
Sure, if it can even be merged, I will try to improve it to meet the
need.  Tobias and I had work on this
aim too.

> If your driver won't ever be merged, I admit I am not interested in
> reviewing it. If the plan is to merge it, then I will review it.
>
> I can't test your code, I do not have any supporter piece of hardware,
> sorry.
>
> I've looked at the intel-agp driver, which binds to the same PCI
> devices. It's way too big and complex to resort to the same hack we
> have in sis5595 and i2c-sis5595 for example. The intel-agp driver must
> remain a "real" pci driver which binds to its devices, in particular so
> that power management works OK.
>
> This leaves us with 3 alternatives.
>
> 1* Add hwmon support to the intel-agp driver directly. As this driver
> =A0 is already somewhat big (77 kB) it would probably go unnoticed. The
> =A0 hwmon part in your driver is probably about 350 lines of code.
>
> 2* Implement hwmon as a separate module, simply use pci_get_dev()
> =A0 during initialization of that module, and if a device is found,
> =A0 register a platform driver and instantiate a platform device for the
> =A0 hwmon part. This is essentially what your implementation does,
> =A0 except that your module registers the platform driver and device
> =A0 regardless of the presence of a supported chip, which is bad.
>
> 3* Let intel-agp instantiate the platform device for hwmon, and only
> =A0 register the driver in the separate module. This avoid some code
> =A0 duplication, and we can have the hwmon module auto-load. Maybe the
> =A0 best compromise code-wise, but possibly somewhat more difficult to
> =A0 maintain.
>
> Note that driver auto-loading should also work with option #2, although
> your implementation doesn't do it. It shouldn't be too hard to add.

   Excuse me, I don''t quite catch about "driver auto-loading". Do you
meet gm965temp build-in,
while not as a module?
   Can you give me more hint? And I will try to improve gm965temp. Thanks a=
 lot!

> I don't have a strong opinion between these 3 choices, but I want the
> driver to auto-load as needed.
>
> --
> Jean Delvare
>

The updated sensor-detect patch based on svn code is as following:
---

From: Lu Zhihe <tombowfly@gmail.com>

Subject: [PATCH] sensors-detect add gm965temp detected for lm-sensors

Signed-off-by: Lu Zhihe <tombowfly@gmail.com>

---

--- prog/detect/sensors-detect.orig	2009-10-09 21:43:12.000000000 +0000
+++ prog/detect/sensors-detect	2009-10-09 21:50:13.000000000 +0000
@@ -147,6 +147,16 @@ $revision =3D~ s/ \([^()]*\)//;
 		procid	=3D> "Intel SCH",
 		driver	=3D> "i2c-isch",
 	}, {
+		vendid	=3D> 0x8086,
+		devid	=3D> 0x2a00,
+		procid	=3D> "Intel GM965",
+		driver	=3D> "gm965temp",
+	}, {
+		vendid	=3D> 0x8086,
+		devid	=3D> 0x2a10,
+		procid	=3D> "Intel GME965",
+		driver	=3D> "gm965temp",
+	}, {
 		vendid	=3D> 0x1106,
 		devid	=3D> 0x3040,
 		procid	=3D> "VIA Technologies VT82C586B Apollo ACPI",
@@ -1860,6 +1870,10 @@ use vars qw(@cpu_ids);
 		driver =3D> "i5k_amb",
 		detect =3D> \&intel_amb_detect,
 	}, {
+		name =3D> "Intel GM/GME965 thermal sensor",
+		driver =3D> "gm965temp",
+		detect =3D> \&intel_gm965_detect,
+	}, {
 		name =3D> "VIA C7 thermal and voltage sensors",
 		driver =3D> "c7temp",
 		detect =3D> \&c7temp_detect,
@@ -5301,6 +5315,15 @@ sub intel_amb_detect
 	return;
 }

+sub intel_gm965_detect
+{
+        if ((exists $pci_list{'8086:2a00'}) ||  # Intel GM965
+            (exists $pci_list{'8086:2a10'})) {  # Intel GME965
+                return 9;
+        }
+        return;
+}
+
 sub coretemp_detect
 {
 	my $probecpu;

---
Thx

Lu Zhihe

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
