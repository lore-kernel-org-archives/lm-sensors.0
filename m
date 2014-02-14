From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Date: Fri, 14 Feb 2014 08:11:26 +0000
Subject: [lm-sensors] [PATCH v2 45/52] hwmon, via-cputemp: Fix CPU hotplug callback registration
Message-Id: <20140214075925.22701.69267.stgit@srivatsabhat.in.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: paulus@samba.org, oleg@redhat.com, mingo@kernel.org, rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de, akpm@linux-foundation.org
Cc: paulmck@linux.vnet.ibm.com, tj@kernel.org, walken@google.com, ego@linux.vnet.ibm.com, linux@arm.linux.org.uk, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, Jean Delvare <jdelvare@suse.de>, lm-sensors@lm-sensors.org, Guenter Roeck <linux@roeck-us.net>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>

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

	cpu_notifier_register_begin();

	for_each_online_cpu(cpu)
		init_cpu(cpu);

	/* Note the use of the double underscored version of the API */
	__register_cpu_notifier(&foobar_cpu_notifier);

	cpu_notifier_register_done();


Fix the hwmon via-cputemp code by using this latter form of callback
registration.

Cc: Jean Delvare <jdelvare@suse.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: lm-sensors@lm-sensors.org
Acked-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 drivers/hwmon/via-cputemp.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/via-cputemp.c b/drivers/hwmon/via-cputemp.c
index 38944e9..8df43c5 100644
--- a/drivers/hwmon/via-cputemp.c
+++ b/drivers/hwmon/via-cputemp.c
@@ -319,7 +319,7 @@ static int __init via_cputemp_init(void)
 	if (err)
 		goto exit;
 
-	get_online_cpus();
+	cpu_notifier_register_begin();
 	for_each_online_cpu(i) {
 		struct cpuinfo_x86 *c = &cpu_data(i);
 
@@ -339,14 +339,14 @@ static int __init via_cputemp_init(void)
 
 #ifndef CONFIG_HOTPLUG_CPU
 	if (list_empty(&pdev_list)) {
-		put_online_cpus();
+		cpu_notifier_register_done();
 		err = -ENODEV;
 		goto exit_driver_unreg;
 	}
 #endif
 
-	register_hotcpu_notifier(&via_cputemp_cpu_notifier);
-	put_online_cpus();
+	__register_hotcpu_notifier(&via_cputemp_cpu_notifier);
+	cpu_notifier_register_done();
 	return 0;
 
 #ifndef CONFIG_HOTPLUG_CPU
@@ -361,8 +361,8 @@ static void __exit via_cputemp_exit(void)
 {
 	struct pdev_entry *p, *n;
 
-	get_online_cpus();
-	unregister_hotcpu_notifier(&via_cputemp_cpu_notifier);
+	cpu_notifier_register_begin();
+	__unregister_hotcpu_notifier(&via_cputemp_cpu_notifier);
 	mutex_lock(&pdev_list_mutex);
 	list_for_each_entry_safe(p, n, &pdev_list, list) {
 		platform_device_unregister(p->pdev);
@@ -370,7 +370,7 @@ static void __exit via_cputemp_exit(void)
 		kfree(p);
 	}
 	mutex_unlock(&pdev_list_mutex);
-	put_online_cpus();
+	cpu_notifier_register_done();
 	platform_driver_unregister(&via_cputemp_driver);
 }
 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
