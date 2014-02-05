From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Date: Wed, 05 Feb 2014 22:24:06 +0000
Subject: [lm-sensors] [PATCH 42/51] hwmon, coretemp: Fix CPU hotplug callback registration
Message-Id: <20140205221205.19080.15108.stgit@srivatsabhat.in.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140205220251.19080.92336.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140205220251.19080.92336.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: paulus@samba.org, oleg@redhat.com, rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de, akpm@linux-foundation.org
Cc: mingo@kernel.org, paulmck@linux.vnet.ibm.com, tj@kernel.org, walken@google.com, ego@linux.vnet.ibm.com, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>

Subsystems that want to register CPU hotplug callbacks, as well as perform
initialization for the CPUs that are already online, often do it as shown
below:

	get_online_cpus();

	for_each_online_cpu(cpu)
		init_cpu(cpu);

	register_cpu_notifier(&foobar_cpu_notifier);

	put_online_cpus();

This is wrong, since it is prone to ABBA deadlocks involving the
cpu_add_remove_lock and the cpu_hotplug.lock (when running concurrently
with CPU hotplug operations).

Instead, the correct and race-free way of performing the callback
registration is:

	cpu_maps_update_begin();

	for_each_online_cpu(cpu)
		init_cpu(cpu);

	/* Note the use of the double underscored version of the API */
	__register_cpu_notifier(&foobar_cpu_notifier);

	cpu_maps_update_done();


Fix the hwmon coretemp code by using this latter form of callback
registration.

Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Jean Delvare <jdelvare@suse.de>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: lm-sensors@lm-sensors.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 drivers/hwmon/coretemp.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index bbb0b0d..43c436b 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -849,20 +849,20 @@ static int __init coretemp_init(void)
 	if (err)
 		goto exit;
 
-	get_online_cpus();
+	cpu_maps_update_begin();
 	for_each_online_cpu(i)
 		get_core_online(i);
 
 #ifndef CONFIG_HOTPLUG_CPU
 	if (list_empty(&pdev_list)) {
-		put_online_cpus();
+		cpu_maps_update_done();
 		err = -ENODEV;
 		goto exit_driver_unreg;
 	}
 #endif
 
-	register_hotcpu_notifier(&coretemp_cpu_notifier);
-	put_online_cpus();
+	__register_hotcpu_notifier(&coretemp_cpu_notifier);
+	cpu_maps_update_done();
 	return 0;
 
 #ifndef CONFIG_HOTPLUG_CPU
@@ -877,8 +877,8 @@ static void __exit coretemp_exit(void)
 {
 	struct pdev_entry *p, *n;
 
-	get_online_cpus();
-	unregister_hotcpu_notifier(&coretemp_cpu_notifier);
+	cpu_maps_update_begin();
+	__unregister_hotcpu_notifier(&coretemp_cpu_notifier);
 	mutex_lock(&pdev_list_mutex);
 	list_for_each_entry_safe(p, n, &pdev_list, list) {
 		platform_device_unregister(p->pdev);
@@ -886,7 +886,7 @@ static void __exit coretemp_exit(void)
 		kfree(p);
 	}
 	mutex_unlock(&pdev_list_mutex);
-	put_online_cpus();
+	cpu_maps_update_done();
 	platform_driver_unregister(&coretemp_driver);
 }
 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
