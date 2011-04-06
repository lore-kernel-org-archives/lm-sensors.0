From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 06 Apr 2011 13:17:36 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: Refactor AMD CPU sensor
Message-Id: <20110406151736.6c439c80@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Except for the Family 10h case which is more complex, AMD CPU sensor
detection is straightforward, so we don't really need a dedicated
function for each CPU family. By passing the expected F3 PCI device ID
as a parameter, we can use the same function for all families.

Objection anyone? This could be seen as moving some of the detection
code into @cpu_ids itself, but OTOH it saves quite a few lines of
redundant code.

---
 prog/detect/sensors-detect |   31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

Index: prog/detect/sensors-detect
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/detect/sensors-detect	(r=E9vision 5955)
+++ prog/detect/sensors-detect	(copie de travail)
@@ -2172,7 +2172,7 @@
 	}, {
 		name =3D> "AMD K8 thermal sensors",
 		driver =3D> "k8temp",
-		detect =3D> \&k8temp_pci_detect,
+		detect =3D> sub { amd_pci_detect('1103') },
 	}, {
 		name =3D> "AMD Family 10h thermal sensors",
 		driver =3D> "k10temp",
@@ -2180,15 +2180,15 @@
 	}, {
 		name =3D> "AMD Family 11h thermal sensors",
 		driver =3D> "k10temp",
-		detect =3D> \&fam11h_pci_detect,
+		detect =3D> sub { amd_pci_detect('1303') },
 	}, {
 		name =3D> "AMD Family 12h and 14h thermal sensors",
 		driver =3D> "k10temp",
-		detect =3D> \&fam12h_14h_pci_detect,
+		detect =3D> sub { amd_pci_detect('1703') },
 	}, {
 		name =3D> "AMD Family 15h thermal sensors",
 		driver =3D> "k10temp",
-		detect =3D> \&fam15h_pci_detect,
+		detect =3D> sub { amd_pci_detect('1603') },
 	}, {
 		name =3D> "Intel digital thermal sensor",
 		driver =3D> "coretemp",
@@ -6098,9 +6098,10 @@
 	return 9;
 }
=20
-sub k8temp_pci_detect
+sub amd_pci_detect
 {
-	return unless exists $pci_list{'1022:1103'};
+	my $f3_id =3D shift;
+	return unless exists $pci_list{"1022:$f3_id"};
 	return 9;
 }
=20
@@ -6130,24 +6131,6 @@
 	return;
 }
=20
-sub fam11h_pci_detect
-{
-	return unless exists $pci_list{'1022:1303'};
-	return 9;
-}
-
-sub fam12h_14h_pci_detect
-{
-	return unless exists $pci_list{'1022:1703'};
-	return 9;
-}
-
-sub fam15h_pci_detect
-{
-	return unless exists $pci_list{'1022:1603'};
-	return 9;
-}
-
 sub intel_amb_detect
 {
 	if ((exists $pci_list{'8086:25f0'}) ||	# Intel 5000

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
