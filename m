From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: segfault in sensord (lm_sensors2 2.8.5)
Message-Id: <20040308190140.05d81f4a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200403080911.40544.ttoohey@toowards.com>
In-Reply-To: <200403080911.40544.ttoohey@toowards.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> In prog/sensord/rrd.c (since revision 1.5 I think) there's a null
> pointer dereference when used with the --load-average option. This
> seems to only be a problem when initialing creating the rrd log file
> (though I'm not sure).
> 
> Below is my fix.

I've applied a slightly different one (inlined below). Yours would
arbitrarily apply voltage-like sanity limits to the feature. 

Please confirm that it works OK for you.

Thanks for reporting.


--- lm_sensors2/prog/sensord/rrd.c.orig	2003-08-11 10:29:28.000000000 +0200
+++ lm_sensors2/prog/sensord/rrd.c	2004-03-08 17:33:19.000000000 +0100
@@ -195,7 +195,7 @@
     char *ptr = rrdBuff + data->num * RRD_BUFF;
     const char *min, *max;
     data->argv[data->num ++] = ptr;
-    switch (feature->type) { /* arbitrary sanity limits */
+    switch (feature ? feature->type : DataType_other) { /* arbitrary sanity limits */
       case DataType_voltage:
         min="-25";
         max="25";

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
