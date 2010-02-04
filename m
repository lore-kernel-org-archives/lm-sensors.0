From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 04 Feb 2010 21:26:01 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: driver for TI tmp102 temperature
Message-Id: <20100204132601.4b2d3939.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <201002031723.49976.sfking@fdwdc.com>
	<20100204102203.ecf4bbb5.akpm@linux-foundation.org>
	<201002041317.37574.sfking@fdwdc.com>
In-Reply-To: <201002041317.37574.sfking@fdwdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven King <sfking@fdwdc.com>
Cc: Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Thu, 4 Feb 2010 13:17:37 -0800
Steven King <sfking@fdwdc.com> wrote:

> > checkpatch spits this warning:
> >
> >     WARNING: struct dev_pm_ops should normally be const
> >     #387: FILE: drivers/hwmon/tmp102.c:300:
> >     +static struct dev_pm_ops tmp102_dev_pm_ops = {
> >
> > which seems truthful enough.
> 
> Indeed.   I am, however, somewhat surprised since I ran the patch thru 
> checkpatch before posting it and no errors or warnings were reported.  Is 
> there a version of checkpatch other than the one included in the tree that I 
> should be using?

It was -mm's
checkpatchpl-extend-list-of-expected-to-be-const-structures.patch which
found this.


From: Emese Revfy <re.emese@gmail.com>

Based on Arjan's suggestion, extend the list of ops structures that should
be const.

Signed-off-by: Emese Revfy <re.emese@gmail.com>
Cc: Andy Whitcroft <apw@shadowen.org>
Cc: Arjan van de Ven <arjan@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 scripts/checkpatch.pl |   41 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff -puN scripts/checkpatch.pl~checkpatchpl-extend-list-of-expected-to-be-const-structures scripts/checkpatch.pl
--- a/scripts/checkpatch.pl~checkpatchpl-extend-list-of-expected-to-be-const-structures
+++ a/scripts/checkpatch.pl
@@ -2654,9 +2654,46 @@ sub process {
 		if ($line =~ /^.\s*__initcall\s*\(/) {
 			WARN("please use device_initcall() instead of __initcall()\n" . $herecurr);
 		}
-# check for struct file_operations, ensure they are const.
+# check for various ops structs, ensure they are const.
+		my $struct_ops = qr{acpi_dock_ops|
+				address_space_operations|
+				backlight_ops|
+				block_device_operations|
+				dentry_operations|
+				dev_pm_ops|
+				dma_map_ops|
+				extent_io_ops|
+				file_lock_operations|
+				file_operations|
+				hv_ops|
+				ide_dma_ops|
+				intel_dvo_dev_ops|
+				item_operations|
+				iwl_ops|
+				kgdb_arch|
+				kgdb_io|
+				kset_uevent_ops|
+				lock_manager_operations|
+				microcode_ops|
+				mtrr_ops|
+				neigh_ops|
+				nlmsvc_binding|
+				pci_raw_ops|
+				pipe_buf_operations|
+				platform_hibernation_ops|
+				platform_suspend_ops|
+				proto_ops|
+				rpc_pipe_ops|
+				seq_operations|
+				snd_ac97_build_ops|
+				soc_pcmcia_socket_ops|
+				stacktrace_ops|
+				sysfs_ops|
+				tty_operations|
+				usb_mon_operations|
+				wd_ops}x;
 		if ($line !~ /\bconst\b/ &&
-		    $line =~ /\bstruct\s+(file_operations|seq_operations)\b/) {
+		    $line =~ /\bstruct\s+($struct_ops)\b/) {
 			WARN("struct $1 should normally be const\n" .
 				$herecurr);
 		}
_


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
