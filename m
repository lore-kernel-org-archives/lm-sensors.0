From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 10 Sep 2014 08:48:41 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: Print kernel version and processor info
Message-Id: <20140910104841.25a5dda9@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Print the kernel version and the processor information, to make user
support easier.
---
Guenter, what do you think? These are questions we often end up asking
to the user, so gathering the answers early should save us some time.
If you think any other piece of information should be included too,
please let me know.

 prog/detect/sensors-detect |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- lm-sensors.orig/prog/detect/sensors-detect	2014-07-20 13:03:04.826633228 +0200
+++ lm-sensors/prog/detect/sensors-detect	2014-09-10 09:20:54.530273884 +0200
@@ -2731,6 +2731,11 @@ sub initialize_kernel_version
 	}
 }
 
+sub print_kernel_version
+{
+	printf "# Kernel: \%d.\%d.\%d\%s \%s\n", @kernel_version, $kernel_arch;
+}
+
 sub kernel_version_at_least
 {
 	my ($vers, $plvl, $slvl) = @_;
@@ -2775,6 +2780,12 @@ sub initialize_cpu_list
 	push @cpu, $entry if scalar keys(%{$entry}); # Last entry
 }
 
+sub print_cpu_info
+{
+	my $cpu = $cpu[0];
+	print "# Processor: $cpu->{'model name'} ($cpu->{'cpu family'}/$cpu->{model}/$cpu->{stepping})\n";
+}
+
 # @i2c_adapters is a list of references to hashes, one hash per I2C/SMBus
 # adapter present on the system. Each entry has the following keys: path,
 # parent, name (directly taken from sysfs), driver and autoload.
@@ -7027,6 +7038,8 @@ sub main
 	print "# sensors-detect revision $revision\n";
 	initialize_dmi_data();
 	print_dmi_summary();
+	print_kernel_version();
+	print_cpu_info();
 	print "\n";
 
 	if ($opt{auto}) {


-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
