From: Rudolf Marek <r.marek@assembler.cz>
Date: Sun, 09 Nov 2008 19:56:54 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] k8temp warn about errata
Message-Id: <49174086.1050106@assembler.cz>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050800070407060708070008"
List-Id: <lm-sensors.vger.kernel.org>
References: <48E3F505.40401@assembler.cz>
In-Reply-To: <48E3F505.40401@assembler.cz>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------050800070407060708070008
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Jean

Thanks for the review. I'm attaching fixed version.

Following patch adds warning about wrong CPU temperature readouts on all fam f
rev f revision of CPUs.

Used switch statement, more code changes follows.

Signed-off-by: Rudolf Marek <r.marek@assembler.cz>

> If all revision F and later CPUs are affected by the errata and the
> temperature reported is never correct, we should simply blacklist these
> CPUs. I guess this isn't the case, otherwise you'd have proposed that
> we do that long ago.

Yes.

> If most but not all of these CPUs are affected, then it would make
> sense to disable them by default but give the user a chance to still
> enable them (using a module parameter.)

I tried hard to get this info from AMD. All versions are affected, but some may
be fixed/not tested.

> If there are more revision F and later CPUs with working thermal
> diodes, and working ones can be told from non-working ones based on the
> exact revision, we could implement blacklisting and/or whitelisting
> base on the revision.

The errata is for all revs.

> Does anyone have an idea about the ratio of working/broken revision F
> and later CPU models?

Dont sorry.

> Does the status (broken or not) of the thermal diode depend on the
> exact CPU revision, or is it purely random?

Perhaps random.

> Alternatively, or additionally, we could use a heuristic to detect
> broken diodes. I don't much like this in general, as monitoring should
> normally not assume anything on what it is monitoring, but in this
> specific case I think it makes some sense because the thermal sensor in
> question is not a generic chip and brokenness is so widely spread.

I agree. This could work. However I would like to first get the fam 10h and fam
11h support in, because otherwise I would need to rewrite the patches again and
changing lot of at the same time is no good.

So please can you accept the patch as it is now and have a look on second one
too? I fixed the case indent and we need to write some docs too, but first check
code.

Andreas can you test please the second patch too? I'm especially curious if you
see  the high limit when running sensors command.

Once second patch is in, I would like to rewrite the driver with the help of
heuristic and put there more generic logic for "place/core" selectors and temp1_
etc sysfs files creation logic.

Thanks,
Rudolf


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkkXQIYACgkQ3J9wPJqZRNVYYQCfdonOHvRKV8guroQtPq6VA6ZF
/W0AniSg/LYun9ZfsF2lnVlWjrVIY/6P
=qoH1
-----END PGP SIGNATURE-----

--------------050800070407060708070008
Content-Type: text/x-diff;
 name="k8temp_add_warning.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="k8temp_add_warning.patch"

Index: linux-2.6.27-rc7/drivers/hwmon/k8temp.c
===================================================================
--- linux-2.6.27-rc7.orig/drivers/hwmon/k8temp.c	2008-09-28 11:01:45.000000000 +0200
+++ linux-2.6.27-rc7/drivers/hwmon/k8temp.c	2008-11-02 12:05:58.125785703 +0100
@@ -34,6 +34,7 @@
 
 #define TEMP_FROM_REG(val)	(((((val) >> 16) & 0xff) - 49) * 1000)
 #define REG_TEMP	0xe4
+#define REG_CPUID	0xfc
 #define SEL_PLACE	0x40
 #define SEL_CORE	0x04
 
@@ -47,6 +48,7 @@
 	/* registers values */
 	u8 sensorsp;		/* sensor presence bits - SEL_CORE & SEL_PLACE */
 	u32 temp[2][2];		/* core, place */
+	u8 fam;
 };
 
 static struct k8temp_data *k8temp_update_device(struct device *dev)
@@ -155,6 +157,18 @@
 		goto exit;
 	}
 
+	/* get real PCI based cpuid, prior revF of fam 0Fh, this reg is 0 */
+	pci_read_config_dword(pdev, REG_CPUID, &cpuid);
+
+	data->fam = (cpuid & 0x00000f00) >> 8;
+	data->fam += (cpuid & 0x0ff00000) >> 20;
+
+	switch (data->fam) {
+	case 0xf:
+		dev_warn(&pdev->dev, "Temperature readouts might be wrong"
+					" - check errata #141\n");
+	}
+
 	pci_read_config_byte(pdev, REG_TEMP, &scfg);
 	scfg &= ~(SEL_PLACE | SEL_CORE);		/* Select sensor 0, core0 */
 	pci_write_config_byte(pdev, REG_TEMP, scfg);

--------------050800070407060708070008
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------050800070407060708070008--
