From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 31 May 2006 12:47:15 +0000
Subject: [lm-sensors] Two issues: sysfs and smsc47m1 error
Message-Id: <20060531144715.4ebc197b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000601c684a8$fdb00020$6fc8a8c0@WSMARCO>
In-Reply-To: <000601c684a8$fdb00020$6fc8a8c0@WSMARCO>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Marco,

> HP ML310T2G2 Server , 1Gb Memory, 70Gb SCSI HD. Intel Xeon 3.2Ghz
>
> Installed SuSE 9.3 architecture: x86_64, kernel: 2.6.11.4-21.12-smp

> Probing for `SMSC 47M15x/192/997 Super IO Fan Sensors'
> 
>   Success... found at address 0x0400

> # modprobe smsc47m1
> 
> FATAL: Error inserting smsc47m1
> (/lib/modules/2.6.11.4-21.12-smp/kernel/drivers/i2c/chips/smsc47m1.ko): No
> such device

> Ok, so the one module I need, I cannot get loaded. Some help appreciated.

Support for the SMSC 47M15x/192/997 was only added to this driver in
Linux 2.6.13.

> Just continued with normal steps, and found the following error, which
> completely eludes me as well:
> 
> # sensors -s
> Can't access procfs/sysfs file
> Unable to find i2c bus information;
> For 2.6 kernels, make sure you have mounted sysfs and libsensors
> was compiled with sysfs support!
> For older kernels, make sure you have done 'modprobe i2c-proc'!

Don't worry about this, the message may be a bit misleading, but it
really only complains that no hardware monitoring driver was found.

-- 
Jean Delvare

