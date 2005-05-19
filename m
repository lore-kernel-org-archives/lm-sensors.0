From: Jester01@freemail.hu (Csaba Halasz)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: [PATCH] 2.6 kernel
Message-Id: <9B4E9DA25A3DD41189B000508B5C0CEE21429C@BOMBA>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ok, here you go. I have attached my patch.

Some comments:
I have introduced a new abstraction, namely
sensors_kernel_if:

typedef struct sensors_kernel_if
{
  int (*init) (void);
  void (*cleanup) (void);
  int (*read_feature) (sensors_chip_name name, int feature, double *value);
  int (*write_feature) (sensors_chip_name name, int feature, double value);
} sensors_kernel_if;

This is private to the library, and contains the function
pointers for accessing the kernel drivers. For now, there 
are two implementations, one for procfs and one for sysfs.

The new source file kernel.c handles initialization and
cleanup. It will use the first implementation that
it can successfully initialize.

The only changes to the library are:
  * replaced sensors_{read|write}_proc w/ kernel_if->{read|write}_feature
    in access.c (1 each)
  * slightly modified the startup/cleanup code in init.c
  * updated proc.c to fit the new scheme
  * added sysfs.c to handle sysfs :)
  * updated feature names for _as99127f only_ in chips.c

sensors_proc_chips and sensors_bus should be generalized 
to include only the members used by the library plus a 
private opaque member used by the kernel interface. 
This would be used to store the sysctl id for example. 
However we would need a cleanup hook for it. 
I have not done it yet.

I have tested my patch with 2.4.20 and 2.6.0-test8.
Note that due to changes in naming and value scaling,
the sensors.conf is not the same, it must match the 
running kernel. "sensors" and "sensors -s" both seem
to work. However, under 2.6 "sensors" shows all i2c 
devices, not just hardware sensors. (See my previous mail)

I have not bothered to find out the sysfs mount point,
just assumed /sys. We can take the code from Danny's
patch for mount point lookup if necessary. Also the
case sensitivity problem he has encountered should
be looked into.

Finally, the build system should be changed so that
it doesn't try to compile the kernel drivers only
the library. Or maybe I have overlooked something,
and this is already possible?

Regards,
	Csaba
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm_sensors2-kernel2.6.diff.gz
Type: application/octet-stream
Size: 6014 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031027/448516bf/lm_sensors2-kernel2.6.diff.obj
