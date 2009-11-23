From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 23 Nov 2009 09:28:57 +0000
Subject: Re: [lm-sensors] Support for Family 10h CPUs - Not all sensors are
Message-Id: <20091123102857.638335e7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <232a75d96e552164f4c7073154b36172.squirrel@unimail.uni-dortmund.de>
In-Reply-To: <232a75d96e552164f4c7073154b36172.squirrel@unimail.uni-dortmund.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, 23 Nov 2009 08:58:37 +0100, Clemens Ladisch wrote:
> Jean Delvare wrote:
> > On Sat, 21 Nov 2009 18:28:25 +0100, Jan Bessai wrote:
> > > according to AMD (
> > > http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_do=
cs/41322.pdf
> > > ) not all AMD K10 CPUs have defect sensors. In fact only DR-* revisio=
ns
> > > are affected. All CPUs with Socket AM3 as well as all Phenom II Proce=
ssors
> > > and some Opterons are unaffected (DA-*, RB-*, HY-*).
> > > Please reconsider the statement "Embedded sensors are known to be
> > > unreliable, and won't be supported ever.".
> > =20
> > We can do that. But how does this translate into CPUID numbers?
>=20
> Family 0xF, extended family 1, model 2.
>=20
> Or, to quote a certain driver that happend to be posted on this list
> recently:
>=20
> static bool __devinit has_erratum_319(void)
> {
> 	/*
> 	 * Erratum 319: The thermal sensor of older Family 10h processors
> 	 *              (B steppings) may be unreliable.
> 	 */
> 	return boot_cpu_data.x86 =3D 0x10 && boot_cpu_data.x86_model <=3D 2;
> }

OK, this would lead to the following patch for sensors-detect. Can you
please test it?

Index: CHANGES
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- CHANGES	(r=E9vision 5799)
+++ CHANGES	(copie de travail)
@@ -25,7 +25,7 @@
                   The SMSC LPC47M233 isn't currently supported
                   Support upcoming sysfs path to i2c adapters
                   Rename the modprobe configuration file to lm_sensors.conf
-                  Drop AMD K10 detection (unreliable sensors)
+                  Only report AMD Family 10h CPU with model > 2
                   Add detection for AMD Family 11h thermal sensors
                   Add detection for Intel Atom thermal sensors
                   Add detection for National Semiconductor LM73
Index: prog/detect/sensors-detect
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/detect/sensors-detect	(r=E9vision 5799)
+++ prog/detect/sensors-detect	(copie de travail)
@@ -1878,6 +1878,10 @@
 		driver =3D> "k8temp",
 		detect =3D> \&k8temp_pci_detect,
 	}, {
+		name =3D> "AMD Family 10h thermal sensors",
+		driver =3D> "to-be-written",
+		detect =3D> \&fam10h_pci_detect,
+	}, {
 		name =3D> "AMD Family 11h thermal sensors",
 		driver =3D> "to-be-written",
 		detect =3D> \&fam11h_pci_detect,
@@ -5334,6 +5338,25 @@
 	return 9;
 }
=20
+sub fam10h_pci_detect
+{
+	return unless exists $pci_list{'1022:1203'};
+
+	# Errata 319 (Inaccurate Temperature Measurement) affects
+	# revisions DR-BA, DR-B2 and DR-B3, all have model number =3D 2.
+	# So we only pick CPU with model number > 2.
+	my $probecpu;
+	foreach $probecpu (@cpu) {
+		if ($probecpu->{vendor_id} eq 'AuthenticAMC' &&
+				$probecpu->{'cpu family'} =3D 0x10 &&
+				$probecpu->{model} > 2) {
+			return 9;
+		}
+	}
+=09
+	return;
+}
+
 sub fam11h_pci_detect
 {
 	return unless exists $pci_list{'1022:1303'};

I have also updated wiki/Devices.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
