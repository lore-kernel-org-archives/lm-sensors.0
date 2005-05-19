From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: Problems compiling bmcsensors.c
Message-Id: <3EDAF5E1.8060606@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm still trying to compile the most recent CVS code on that Red Hat Beta kernel.

kernel/chips/bmcsensors.c has some logic problems resulting from the sensors.h 
and i2c changes.  bmcsensors_initialized got removed, but it seems to have 
been more than just a on/off flag as several places in the code test for >=2, 
and >=3 values.  I haven't looked at the code to see if the patch below fixes 
the logic problems, but I do know that it fixes the compiler errors.

MDS, can you look at the use of bmcsensors_initialized in bmcsensors.c and see 
what else might need to be changed to make this module work since you wrote it?

Note, this patch also fixes a mis-matched paren's problem...

Thanks,
:v)

Index: kernel/chips/bmcsensors.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/chips/bmcsensors.c,v
retrieving revision 1.11
diff -u -r1.11 bmcsensors.c
--- kernel/chips/bmcsensors.c	17 Mar 2003 01:32:56 -0000	1.11
+++ kernel/chips/bmcsensors.c	2 Jun 2003 06:55:39 -0000
@@ -102,6 +102,8 @@
  	0
  };

+static int bmcsensors_initialized = 0;
+
  #define MAX_SDR_ENTRIES 50
  #define SDR_LIMITS 8
  #define SDR_MAX_ID_LENGTH 16
@@ -389,7 +391,7 @@
  	bmcsensors_dir_table[sdrd_count].ctl_name = 0;

  	if ((i = i2c_register_entry(&bmc_client, "bmc",
- 
			    bmcsensors_dir_table) < 0) {
+ 
			    bmcsensors_dir_table)) < 0) {
  		printk(KERN_INFO "bmcsensors.o: i2c registration failed.\n");
  		kfree(bmcsensors_dir_table);
  		kfree(bmcsensors_proc_name_pool);
