From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 29 Jul 2010 19:34:56 +0000
Subject: Re: [lm-sensors] [PATCH V3 3/3] hwmon: (coretemp) documentation
Message-Id: <20100729123456.4c1193ff.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1279850968-12154-4-git-send-email-gong.chen@linux.intel.com>
In-Reply-To: <1279850968-12154-4-git-send-email-gong.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 23 Jul 2010 10:09:28 +0800
Chen Gong <gong.chen@linux.intel.com> wrote:

> update coretemp supported CPU TjMax lists and some cleanup work.

Patches #1 and #2 are unaltered.  Below are the alterations which you
made to patch #3.  No explanation of these changes has been provided.



 Documentation/hwmon/coretemp |    9 +++++----
 drivers/hwmon/coretemp.c     |    4 ++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff -puN Documentation/hwmon/coretemp~hwmon-coretemp-documentation-update-and-cleanup-update Documentation/hwmon/coretemp
--- a/Documentation/hwmon/coretemp~hwmon-coretemp-documentation-update-and-cleanup-update
+++ a/Documentation/hwmon/coretemp
@@ -21,8 +21,8 @@ Temperature is measured in degrees Celsi
 1 degree C. Valid temperatures are from 0 to TjMax degrees C, because
 the actual value of temperature register is in fact a delta from TjMax.
 
-Temperature known as TjMax is the maximum junction temperature of processor.
-Intel defines this temperature as 80C or 105C. At this temperature, protection
+Temperature known as TjMax is the maximum junction temperature of processor,
+which depends on the CPU model. See table below. At this temperature, protection
 mechanism will perform actions to forcibly cool down the processor. Alarm
 may be raised, if the temperature grows enough (more than TjMax) to trigger
 the Out-Of-Spec bit. Following table summarizes the exported sysfs files:
@@ -65,8 +65,8 @@ Process		Processor					TjMax(C)
 
 45nm		Xeon Processors 5200 Dual-Core
 		X5282, X5272, X5270, X5260			90
-		E5240, E5220, E5205				90
-		E5205, E5220					70
+		E5240						90
+		E5205, E5220					70, 90
 		L5240						70
 		L5238, L5215					95
 
@@ -76,6 +76,7 @@ Process		Processor					TjMax(C)
 		Z510/500					90
 		N475/470/455/450				100
 		N280/270					90
+		330/230						125
 
 45nm		Core2 Processors
 		Solo ULV SU3500/3300				100
diff -puN drivers/hwmon/coretemp.c~hwmon-coretemp-documentation-update-and-cleanup-update drivers/hwmon/coretemp.c
--- a/drivers/hwmon/coretemp.c~hwmon-coretemp-documentation-update-and-cleanup-update
+++ a/drivers/hwmon/coretemp.c
@@ -54,12 +54,12 @@ struct coretemp_data {
 	const char *name;
 	u32 id;
 	u16 core_id;
-	u8 alarm;
 	char valid;		/* zero until following fields are valid */
 	unsigned long last_updated;	/* in jiffies */
 	int temp;
 	int tjmax;
 	int ttarget;
+	u8 alarm;
 };
 
 /*
@@ -308,7 +308,7 @@ static int __devinit coretemp_probe(stru
 #ifdef CONFIG_SMP
 	data->core_id = c->cpu_core_id;
 #endif
-	data->name = DRVNAME;
+	data->name = "coretemp";
 	mutex_init(&data->update_lock);
 
 	/* test if we can access the THERM_STATUS MSR */
_


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
