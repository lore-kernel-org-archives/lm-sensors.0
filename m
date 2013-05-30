From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 30 May 2013 13:20:01 +0000
Subject: [lm-sensors] [PATCH 1/2] sensors-detect: Use modules.builtin instead of /sys/module
Message-Id: <20130530152001.4f0b2554@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

/sys/module doesn't actually contain all built-in modules, only the
ones which have a version or at least one parameter. Better use file
modules.builtin which is generated since kernel 2.6.33, it is complete
and this will let us handle built-in modules properly.
---
 prog/detect/sensors-detect |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- lm-sensors.orig/prog/detect/sensors-detect	2013-05-28 13:51:44.964830827 +0200
+++ lm-sensors/prog/detect/sensors-detect	2013-05-30 14:29:07.580744646 +0200
@@ -2616,11 +2616,12 @@ sub initialize_conf
 # [2] -> SUBLEVEL
 # [3] -> EXTRAVERSION
 #
-use vars qw(@kernel_version $kernel_arch);
+use vars qw($kernel_version @kernel_version $kernel_arch);
 
 sub initialize_kernel_version
 {
-	`uname -r` =~ /(\d+)\.(\d+)\.(\d+)(.*)/;
+	chomp($kernel_version = `uname -r`);
+	$kernel_version =~ /(\d+)\.(\d+)\.(\d+)(.*)/;
 	@kernel_version = ($1, $2, $3, $4);
 	chomp($kernel_arch = `uname -m`);
 
@@ -2792,20 +2793,19 @@ use vars qw(%modules_list %modules_suppo
 
 sub initialize_modules_list
 {
-	local $_;
+	local ($_, *INPUTFILE);
 
-	# /sys/module contains built-in drivers too, but doesn't exist on
-	# older kernels (added in kernel 2.6.7)
-	if (opendir(local *MODULES, "$sysfs_root/module")) {
-		while (defined($_ = readdir(MODULES))) {
-			next if m/^\./;
-			$modules_list{$1} = 1 if m/^(\S*)/;
+	# Starting with kernel 2.6.33, a list of built-in modules is available
+	if (open(*INPUTFILE, "/lib/modules/$kernel_version/modules.builtin")) {
+		while (<INPUTFILE>) {
+			tr/-/_/;
+			$modules_list{$1} = 1 if m/\/([^\/]+)\.ko$/;
 		}
-		return;
+		close(INPUTFILE);
 	}
 
-	# Fall back to /proc/modules as it is always available
-	open(local *INPUTFILE, "/proc/modules") or return;
+	# List all loaded modules
+	open(*INPUTFILE, "/proc/modules") or return;
 	while (<INPUTFILE>) {
 		$modules_list{$1} = 1 if m/^(\S*)/;
 	}


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
