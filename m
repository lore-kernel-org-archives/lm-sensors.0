From: Karsten.Petersen@megware.com (Karsten Petersen)
Date: Fri, 09 Sep 2005 11:53:32 +0000
Subject: [lm-sensors] Patch: Kernel 2.6 and multiple buses
Message-Id: <43215B5F.7050100@megware.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[CC on answers please, I am not on the list.]

Hi,

during the last couple of hours I traced down some lm_sensors problems 
that occured with a Quad Opteron on Tyan 4882 running a kernel 2.6 distro.

My main problem is easily describable as:  Although there was a good 
looking sensors.conf, its options were not used with all chips.  Those 
chips with chip-lines like "bla-*" were ok, but those with lines like 
"bla-i2c-3-*" just showed default labels.

One first problem was, that the "bus" line in sensors.conf needs to have 
another value than when running kernel 2.4 on the same machine.
With kernel 2.4 its like this:
    bus "i2c-4" "SMBus 8111 adapter (CPU3)" "Non-I2C SMBus adapter"
But with kernel 2.6, it must be like this:
    bus "i2c-4" "SMBus 8111 adapter (CPU3)" "Unavailable from sysfs"
It seems to me, that the third argument is redundant these days, so it 
could probably be dropped or made optional.  It took me some time to 
find out about this problem, because the comparison in lib/data.c:233 is 
not helpful at all.  :-/

But this did not solve my problem, more sensor chips showed usefull 
labels but not all.  After a lot of printf debugging it became clear, 
that the sensors_substitute_chip function in lib/data.c assigns wrong 
bus numbers to the configured chips.  This is because the busses in the 
sensors_config_busses array are _not_ sorted, so 
sensors_config_busses[j] does not need to be the bus with id "j".  But 
the function thinks, that this is the case.  It probably was with kernel 
2.4, but not with the kernel 2.6.9 (+lot of patches) I am running.
The attached patch corrects this behavior, it uses the bus id from the 
entry sensors_config_busses[j] instead of "j".

With the patch attached to lm_sensors-2.9.1 and the changes to 
sensors.conf noted above, I can now see correctly labeled output from 
all sensors.

Best wishes
Karsten
-- 
HPC System Engineer

Tel.: +49 3722 528 43
Fax:  +49 3722 528 15
E-Mail: karsten.petersen@megware.com

MEGWARE Computer GmbH
Vertrieb und Service
Nordstra?e 19
09247 Chemnitz/R?hrsdorf
Germany
http://www.megware.com
-------------- next part --------------
diff -urNP lm_sensors-2.9.1-vanilla/lib/data.c lm_sensors-2.9.1/lib/data.c
--- lm_sensors-2.9.1-vanilla/lib/data.c	2004-05-16 16:25:20.000000000 +0200
+++ lm_sensors-2.9.1/lib/data.c	2005-09-09 11:19:49.388603409 +0200
@@ -230,8 +230,10 @@
     if (!strcmp(sensors_config_busses[i].adapter,
                 sensors_proc_bus[j].adapter) &&
         !strcmp(sensors_config_busses[i].algorithm,
-                sensors_proc_bus[j].algorithm)) 
-      break;
+                sensors_proc_bus[j].algorithm)) {
+      name->bus = sensors_proc_bus[j].number;
+      return 0;
+    }
   }
 
   /* Well, if we did not find anything, j = sensors_proc_bus_count; so if
