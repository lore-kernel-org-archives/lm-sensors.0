From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 19 Oct 2010 18:19:44 +0000
Subject: [lm-sensors] [PATCH v2] lm-sensors: Fix error seen with
Message-Id: <20101019181944.GA17399@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The following patch fixes an error seen in sensors-detect if i2c bus numbering
is not sequential. Problem is that in this case, $i2c_adapters[] does not exist
for all index values, causing an error message whenever one of the non-existing
objects is accessed.

The error message is:
        Use of uninitialized value in string eq at ./sensors-detect line 5941.

v2: Keep foreach loop. Check if loop object is defined in each iteration.

--
Index: prog/detect/sensors-detect
=================================--- prog/detect/sensors-detect	(revision 5868)
+++ prog/detect/sensors-detect	(working copy)
@@ -5937,6 +5937,7 @@
 	# the adapter drivers so that the numbers will be the same. If not, then
 	# we only load the adapter drivers which are useful.
 	foreach $adap (@i2c_adapters) {
+		next unless defined $adap;
 		next if $adap->{autoload};
 		next if $adap->{driver} eq 'UNKNOWN';
 		next if not defined $configfile and not $adap->{used};

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
