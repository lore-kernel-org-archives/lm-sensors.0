From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Date: Thu, 06 Feb 2014 10:15:12 +0000
Subject: Re: [lm-sensors] [PATCH 42/51] hwmon, coretemp: Fix CPU hotplug callback registration
Message-Id: <52F35DE0.3040402@linux.vnet.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140205220251.19080.92336.stgit@srivatsabhat.in.ibm.com> <20140205221205.19080.15108.stgit@srivatsabhat.in.ibm.com> <20140206004412.GA1308@roeck-us.net> <20140206012531.GA3887@roeck-us.net>
In-Reply-To: <20140206012531.GA3887@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: paulus@samba.org, oleg@redhat.com, rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de, akpm@linux-foundation.org, mingo@kernel.org, paulmck@linux.vnet.ibm.com, tj@kernel.org, walken@google.com, ego@linux.vnet.ibm.com, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare <jdelvare@suse.de>, lm-sensors@lm-sensors.org

On 02/06/2014 06:55 AM, Guenter Roeck wrote:
> On Wed, Feb 05, 2014 at 04:44:12PM -0800, Guenter Roeck wrote:
>> On Thu, Feb 06, 2014 at 03:42:06AM +0530, Srivatsa S. Bhat wrote:
>>> Subsystems that want to register CPU hotplug callbacks, as well as perform
>>> initialization for the CPUs that are already online, often do it as shown
>>> below:
[...]
>>> Fix the hwmon coretemp code by using this latter form of callback
>>> registration.
>>>
>>> Cc: Fenghua Yu <fenghua.yu@intel.com>
>>> Cc: Jean Delvare <jdelvare@suse.de>
>>> Cc: Guenter Roeck <linux@roeck-us.net>
>>> Cc: lm-sensors@lm-sensors.org
>>> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
>>
>> Applied.
>>
> That obviously doesn't build ;-). Replace with 
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> 

Thanks a lot for the Ack! This patch has a dependency on Patch 1,
hence the trouble with applying it individually :(

Link to Patch 1:
http://article.gmane.org/gmane.linux.kernel/1641640

Regards,
Srivatsa S. Bhat


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
