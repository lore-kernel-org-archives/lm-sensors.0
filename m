From: Manfred.Knick@T-Online.de (Manfred Knick)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: SOLVED: I2C and lm-sensors : gentoo-sources 2.4.25 and your
Message-Id: <200405040052.18853.Manfred.Knick@T-Online.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200405031037.51601.Manfred.Knick@T-Online.de>
In-Reply-To: <200405031037.51601.Manfred.Knick@T-Online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, Jean,

one (hopefully last) question to you:

Running
		# sensors -s
I get
		w83781d-i2c-0-2d: Can't access procfs/sysfs file for writing;
		Run as root?
Info:
	# uname -a
	Linux jumbo 2.4.25-gentoo-r2-sensors #15 SMP ... 
	i686 Pentium III (Coppermine) GenuineIntel 
	GNU/Linux
Info:
	# grep PROC /usr/src/linux/.config

		CONFIG_I2O_PROC=m
		CONFIG_I2C_PROC=m
		CONFIG_VIDEO_PROC_FS=y

		CONFIG_PROC_FS=y

		CONFIG_PROC_CONFIG=m
		CONFIG_FB_MATROX_PROC=y
Info:
	# grep SYS /usr/src/linux/.config

		CONFIG_SYSVIPC=y
		CONFIG_SYSCTL=y
		CONFIG_ACPI_SYSTEM=y
		# CONFIG_SCSI_ADVANSYS is not set
		# CONFIG_SYSV_FS is not set
Info:
	# ll /proc/sys/fs
	total 0
	dr-xr-xr-x    2 root     root            0 May  4 00:29 binfmt_misc
	-r--r--r--    1 root     root            0 May  4 00:29 dentry-state
	-rw-r--r--    1 root     root            0 May  4 00:29 dir-notify-enable
	-rw-r--r--    1 root     root            0 May  4 00:29 file-max
	-r--r--r--    1 root     root            0 May  4 00:29 file-nr
	-r--r--r--    1 root     root            0 May  4 00:29 inode-nr
	-r--r--r--    1 root     root            0 May  4 00:29 inode-state
	-rw-r--r--    1 root     root            0 May  4 00:29 lease-break-time
	-rw-r--r--    1 root     root            0 May  4 00:29 leases-enable
	-rw-r--r--    1 root     root            0 May  4 00:29 overflowgid
	-rw-r--r--    1 root     root            0 May  4 00:29 overflowuid
Info:
	# lsmod
	Module                  Size  Used by    Not tainted
	...
	eeprom                  4020   0  (unused)
	w83781d                21204   0  (unused)
	i2c-proc                6804   0  [ddcmon eeprom w83781d]
	i2c-dev                 4640   0
	i2c-matroxfb            2772   0
	i2c-algo-bit            7624   0  [i2c-matroxfb]
	i2c-piix4               4182   0
	dmi_scan                1636   0  [i2c-piix4]
	i2c-core               15972   0  
	[ddcmon eeprom w83781d i2c-proc i2c-dev 	i2c-algo-bit i2c-piix4]	
	...

I checked lm_sensors-2.8.6/doc/lm_sensors-FAQ.html Section 4.20 regarding 
Linux 2.4.
	
Looks like 
	- for 2.4, lm-sensors-2.8.4 is expected, 
	- for 2.6, lm-sensors-2.8.6 is expected   ???

But with lm-sensors-2.8.4, I did not get the whole thing to work ... grrr...
and I thought I were through, at least for the time being ...

- Manfred
