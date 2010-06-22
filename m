From: Andreas Herrmann <herrmann.der.user@googlemail.com>
Date: Tue, 22 Jun 2010 08:45:57 +0000
Subject: [lm-sensors] [PATCH] hwmon,
Message-Id: <20100622084557.GA4524@loge.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

From: Andreas Herrmann <andreas.herrmann3@amd.com>

Reported temperature for ASB1 CPUs is too high.
Add ASB1 CPU revisions (these are also non-desktop variants) to the
list of CPUs for which the temperature fixup is not required.

Example: (from LENOVO ThinkPad Edge 13, 01972NG, system was idle)

  Current kernel reports

  $ sensors
  k8temp-pci-00c3
  Adapter: PCI adapter
  Core0 Temp:  +74.0=B0C
  Core0 Temp:  +70.0=B0C
  Core1 Temp:  +69.0=B0C
  Core1 Temp:  +70.0=B0C

  With this patch I have

  $ sensors
  k8temp-pci-00c3
  Adapter: PCI adapter
  Core0 Temp:  +54.0=B0C
  Core0 Temp:  +51.0=B0C
  Core1 Temp:  +48.0=B0C
  Core1 Temp:  +49.0=B0C

Cc: <stable@kernel.org> # .32.x .33.x, .34.x
Cc: Rudolf Marek <r.marek@assembler.cz>
Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
---
 drivers/hwmon/k8temp.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

I think this patch should go into .35.
Patch was built against Linus' git v2.6.35-rc3-3-g9a3cde2.
(Hope that there is no conflict with your recent fix for single core
CPUs.)


Thanks,

Andreas


diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
index 0ceb6d6..1fdd63e 100644
--- a/drivers/hwmon/k8temp.c
+++ b/drivers/hwmon/k8temp.c
@@ -180,11 +180,13 @@ static int __devinit k8temp_probe(struct pci_dev *pde=
v,
 		}
=20
 		if ((model >=3D 0x69) &&
-		    !(model =3D 0xc1 || model =3D 0x6c || model =3D 0x7c)) {
+		    !(model =3D 0xc1 || model =3D 0x6c || model =3D 0x7c ||
+		      model =3D 0x6b || model =3D 0x6f || model =3D 0x7f)) {
 			/*
-			 * RevG desktop CPUs (i.e. no socket S1G1 parts)
-			 * need additional offset, otherwise reported
-			 * temperature is below ambient temperature
+			 * RevG desktop CPUs (i.e. no socket S1G1 or
+			 * ASB1 parts) need additional offset,
+			 * otherwise reported temperature is below
+			 * ambient temperature
 			 */
 			data->temp_offset =3D 21000;
 		}
--=20
1.7.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
