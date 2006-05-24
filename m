From: rod@morison.biz (Rod Morison)
Date: Wed, 24 May 2006 14:13:13 +0000
Subject: [lm-sensors] w83792d works under 2.6 kernel, but not 2.4 kernel
Message-Id: <447469F9.6000503@morison.biz>
List-Id: <lm-sensors.vger.kernel.org>
References: <44730D34.4080802@morison.biz>
In-Reply-To: <44730D34.4080802@morison.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Yuan Mu wrote:
>
> Is there Any information about w83792d in "/proc/sys/dev/sensors" ?
> Any messages when load the driver?
>

No, nothing in /proc, but the driver load message appears 
relavent...What does the w83792d load error mean, ("Subclients have same 
address") and how do I figure out the address for the force_subclients 
param?

(What is a "subclient", anyway? Any docs on that anywhere?)

May 24 07:06:54 ImageServer kernel: dmi_scan.o version 2.10.0 (20060214)
May 24 07:06:54 ImageServer kernel: dmi_scan.o: SM BIOS found
May 24 07:06:54 ImageServer kernel: i2c-piix4.o version 2.10.0 (20060214)
May 24 07:06:54 ImageServer kernel: i2c-i801 version 2.10.0 (20060214)
May 24 07:06:54 ImageServer kernel: i2c-isa.o version 2.10.0 (20060214)
May 24 07:06:54 ImageServer kernel: w83781d.o version 2.10.0 (20060214)
May 24 07:06:55 ImageServer kernel: w83792d version 2.10.0 (20060214)
May 24 07:06:55 ImageServer kernel: w83792d: Subclients have the same 
address (0x48)! Use force_subclients.
May 24 07:06:55 ImageServer kernel: w83792d.o: Subclient 1 registration 
at address 0x48 failed.
May 24 07:06:55 ImageServer kernel: w83627hf.o version 2.10.0 (20060214)





