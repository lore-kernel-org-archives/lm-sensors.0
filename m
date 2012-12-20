From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 20 Dec 2012 09:26:46 +0000
Subject: Re: [lm-sensors] [GIT PULL] hwmon updates for Linux 3.8
Message-Id: <20121220102646.04a916ba@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121219223353.7b671d1f@endymion.delvare>
In-Reply-To: <20121219223353.7b671d1f@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Linus,

On Wed, 19 Dec 2012 20:34:01 -0800, Linus Torvalds wrote:
> On Wed, Dec 19, 2012 at 1:33 PM, Jean Delvare <khali@linux-fr.org> wrote:
> >
> >  6 files changed, 674 insertions(+), 440 deletions(-)
> 
> This is not what I get when I pull. What's up?

This is not what I get when I pull from another host either. The file
count is correct, but I get 689 insertions and 455 deletions.

I investigated it and found that this is caused by the differences being
expressed slightly differently. For example:

--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -84,19 +84,21 @@ static void __init hwmon_pci_quirks(void)
 
        /* Open access to 0x295-0x296 on MSI MS-7031 */
        sb = pci_get_device(PCI_VENDOR_ID_ATI, 0x436c, NULL);
-       if (sb &&
-           (sb->subsystem_vendor = 0x1462 &&  /* MSI */
-            sb->subsystem_device = 0x0031)) { /* MS-7031 */
+       if (sb) {
+               if (sb->subsystem_vendor = 0x1462 &&   /* MSI */
+                   sb->subsystem_device = 0x0031) {   /* MS-7031 */
+                       pci_read_config_byte(sb, 0x48, &enable);
+                       pci_read_config_word(sb, 0x64, &base);
 
-               pci_read_config_byte(sb, 0x48, &enable);
-               pci_read_config_word(sb, 0x64, &base);
-
-               if (base = 0 && !(enable & BIT(2))) {
-                       dev_info(&sb->dev,
-                                "Opening wide generic port at 0x295\n");
-                       pci_write_config_word(sb, 0x64, 0x295);
-                       pci_write_config_byte(sb, 0x48, enable | BIT(2));
+                       if (base = 0 && !(enable & BIT(2))) {
+                               dev_info(&sb->dev,
+                                        "Opening wide generic port at 0x295\n");
+                               pci_write_config_word(sb, 0x64, 0x295);
+                               pci_write_config_byte(sb, 0x48,
+                                                     enable | BIT(2));
+                       }
                }
+               pci_dev_put(sb);
        }
 #endif
 }

on my side, became:

--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -84,19 +84,21 @@ static void __init hwmon_pci_quirks(void)

        /* Open access to 0x295-0x296 on MSI MS-7031 */
        sb = pci_get_device(PCI_VENDOR_ID_ATI, 0x436c, NULL);
-       if (sb &&
-           (sb->subsystem_vendor = 0x1462 &&  /* MSI */
-            sb->subsystem_device = 0x0031)) { /* MS-7031 */
-
-               pci_read_config_byte(sb, 0x48, &enable);
-               pci_read_config_word(sb, 0x64, &base);
-
-               if (base = 0 && !(enable & BIT(2))) {
-                       dev_info(&sb->dev,
-                                "Opening wide generic port at 0x295\n");
-                       pci_write_config_word(sb, 0x64, 0x295);
-                       pci_write_config_byte(sb, 0x48, enable | BIT(2));
+       if (sb) {
+               if (sb->subsystem_vendor = 0x1462 &&   /* MSI */
+                   sb->subsystem_device = 0x0031) {   /* MS-7031 */
+                       pci_read_config_byte(sb, 0x48, &enable);
+                       pci_read_config_word(sb, 0x64, &base);
+
+                       if (base = 0 && !(enable & BIT(2))) {
+                               dev_info(&sb->dev,
+                                        "Opening wide generic port at 0x295\n");
+                               pci_write_config_word(sb, 0x64, 0x295);
+                               pci_write_config_byte(sb, 0x48,
+                                                     enable | BIT(2));
+                       }
                }
+               pci_dev_put(sb);
        }
 #endif
 }

on the far side. So the diffstat difference comes from an extra blank
line being deleted and reinserted.

You'll notice that 674 - 440 = 689 - 455 so I presume the different
numbers for it87.c have the same explanation and the end result would
be correct.

At first I thought that this was caused by me using diff option -d when
generating the patch originally. However dropping it did change the
output but still did not lead to what I get when pulling from git.

So I can only suspect that the differences were somehow reformatted by
the git instance on kernel.org. Maybe different versions of git have a
different diffing algorithm? I don't even know if git has its own diff
implementation or if it relies on the system diff command. For what
it's worth, I am running the following:

git version 1.7.7
GNU diff version 3.1

Also note that the patches went into git with quiltimport, if that
makes a difference.

If you have suggestions, I'm all ears, but I think you can just take
this pull request as is.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
