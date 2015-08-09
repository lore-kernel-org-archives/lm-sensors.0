From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sun, 09 Aug 2015 10:00:48 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: restrict Super I/O probing to x86
Message-Id: <20150809100048.GA8036@aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The current sensors-detect avoid Super I/O chips probing on
PowerPC machines. However I have also been reported that this code
can also crash ARM machines. I therefore believe the probing should
be done only on x86 machines. The patch below changes that.

--- a/prog/detect/sensors-detect
+++ b/prog/detect/sensors-detect
@@ -6889,9 +6889,9 @@
 	print "\n";
 
 	$superio_features = 0;
-	# Skip "random" I/O port probing on PPC
-	if ($kernel_arch ne 'ppc'
-	 && $kernel_arch ne 'ppc64') {
+	# Skip "random" I/O port probing on non x86 machines
+	if ($kernel_arch =~ /i?86/
+	 || $kernel_arch eq 'x86_64') {
 		print "Some Super I/O chips contain embedded sensors. We have to write to\n".
 		      "standard I/O ports to probe them. This is usually safe.\n";
 		print "Do you want to scan for Super I/O sensors? (YES/no): ";

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
