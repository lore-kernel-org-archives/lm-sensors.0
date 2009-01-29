From: Andre Prendel <andre_prendel@gmx.de>
Date: Thu, 29 Jan 2009 09:09:45 +0000
Subject: [lm-sensors] [Patch] libsensors: Introduce error string - Unknown
Message-Id: <20090129090945.GB4410@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

sensors_error() returns NULL if errnum is not valid. Returning
"Unknown error" in this case, makes output clearer than:

foo: (null)

and prevents error output/logging from segmentation faults.

What do you think?

Andre

Signed-off-by: Andre Prendel <andre_prendel@gmx.de>
---

--- lm-sensors-dev/lib/error.c	2009-01-26 17:43:43.000000000 +0100
+++ my-lm-sensors/lib/error.c	2009-01-28 22:49:53.000000000 +0100
@@ -33,7 +33,7 @@ void (*sensors_fatal_error) (const char 
 						sensors_default_fatal_error;
 
 static const char *errorlist[] = {
-	/* Invalid error code    */ NULL,
+	/* Invalid error code    */ "Unknown error",
 	/* SENSORS_ERR_WILDCARDS */ "Wildcard found in chip name",
 	/* SENSORS_ERR_NO_ENTRY  */ "No such subfeature known",
 	/* SENSORS_ERR_ACCESS_R  */ "Can't read",

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
