From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: Support question:  segault in sensors
Message-Id: <20040813200716.1d87d177.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <013901c480a8$af2fc120$4400000a@phil>
In-Reply-To: <013901c480a8$af2fc120$4400000a@phil>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> How are you concluding my version mismatch?

Because that's the most frequent case for 2.4 kernels. But...
> 
> Here is my dmesg output:
> i2c-core.o: i2c core module version 2.8.7 (20040611)
> i2c-i801 version 2.8.7 (20040611)
> i2c-isa.o version 2.8.7 (20040611)
> i2c-proc.o version 2.8.7 (20040611)
> adm1025.o version 2.8.7 (20040611)
> eeprom.o version 2.8.7 (20040611)
> smsc47m1.o version 2.8.7 (20040611)

.. that's not your case. At least not at first sight.

> I installed i2c v2.8.7 with lm_sensors 2.8.7, could there be a
> mismatch from something already present in the Kernel source?  I don't
> understand where the mismatch is....
> 
> I can't recompile my kernel, as it is patched to run some proprietary
> hardware, and the patch is not available for anything newer.  I didn't
> have i2c support enabled in the kernel, so I used "method 1" to build
> i2c & lm_sensors.  Where did I go wrong?

Nowhere as far as I can tell, looks OK.

So we can now guess that the problem is in userspace only. Please
compile lm_sensors with DEBUG=1 (so that -g is set on compilation), then
run "sensors -s" through gdb. When it crashes, type "bt" to get the
backtrace, and post it here. Maybe it'll help.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
