From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: sensord now installed, but --rrd-file argument is fatal
Message-Id: <20040403210738.52cd850b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040403161916.GA22622@neu.nirvana>
In-Reply-To: <20040403161916.GA22622@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I investigated this and sensord seems to not like using -a and -r
> together (logging average load and logging to rrd). Try removing the
> -a from the init.d script.
> 
> Is this a known problem? Any cure? :)

We had a report about segfault in sensord (2.8.5) some times ago:
http://archives.andrew.net.au/lm-sensors/msg06918.html

This was triggered by --load-average, so I wouldn't be surprised that
this is the same problem here.

A fix has been commited to CVS (dated 8 Mar 2004) and was reported to
work. I insert it here so that you can give it a try:

Index: rrd.c
=================================RCS file: /home/cvs/lm_sensors2/prog/sensord/rrd.c,v
retrieving revision 1.7
retrieving revision 1.8
diff -u -r1.7 -r1.8
--- rrd.c	11 Aug 2003 08:47:15 -0000	1.7
+++ rrd.c	8 Mar 2004 18:03:42 -0000	1.8
@@ -195,7 +195,7 @@
     char *ptr = rrdBuff + data->num * RRD_BUFF;
     const char *min, *max;
     data->argv[data->num ++] = ptr;
-    switch (feature->type) { /* arbitrary sanity limits */
+    switch (feature ? feature->type : DataType_other) { /* arbitrary sanity limits */
       case DataType_voltage:
         min="-25";
         max="25";


Let us know if it doesn't fix it, and we'll investigate.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
