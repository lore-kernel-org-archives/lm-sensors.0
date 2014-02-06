From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 06 Feb 2014 00:44:12 +0000
Subject: Re: [lm-sensors] [PATCH 42/51] hwmon, coretemp: Fix CPU hotplug callback registration
Message-Id: <20140206004412.GA1308@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140205220251.19080.92336.stgit@srivatsabhat.in.ibm.com>
 <20140205221205.19080.15108.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140205221205.19080.15108.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: paulus@samba.org, oleg@redhat.com, rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de, akpm@linux-foundation.org, mingo@kernel.org, paulmck@linux.vnet.ibm.com, tj@kernel.org, walken@google.com, ego@linux.vnet.ibm.com, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare <jdelvare@suse.de>, lm-sensors@lm-sensors.org

On Thu, Feb 06, 2014 at 03:42:06AM +0530, Srivatsa S. Bhat wrote:
> Subsystems that want to register CPU hotplug callbacks, as well as perform
> initialization for the CPUs that are already online, often do it as shown
> below:
> 
> 	get_online_cpus();
> 
> 	for_each_online_cpu(cpu)
> 		init_cpu(cpu);
> 
> 	register_cpu_notifier(&foobar_cpu_notifier);
> 
> 	put_online_cpus();
> 
> This is wrong, since it is prone to ABBA deadlocks involving the
> cpu_add_remove_lock and the cpu_hotplug.lock (when running concurrently
> with CPU hotplug operations).
> 
> Instead, the correct and race-free way of performing the callback
> registration is:
> 
> 	cpu_maps_update_begin();
> 
> 	for_each_online_cpu(cpu)
> 		init_cpu(cpu);
> 
> 	/* Note the use of the double underscored version of the API */
> 	__register_cpu_notifier(&foobar_cpu_notifier);
> 
> 	cpu_maps_update_done();
> 
> 
> Fix the hwmon coretemp code by using this latter form of callback
> registration.
> 
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Jean Delvare <jdelvare@suse.de>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: lm-sensors@lm-sensors.org
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Applied.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
