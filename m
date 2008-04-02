From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Apr 2008 12:03:29 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] libsensors: Detect OpenFirmware hwmon
Message-Id: <20080402140329.1073f853@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080331234931.GE7191@tree.beaverton.ibm.com>
In-Reply-To: <20080331234931.GE7191@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Darrick,

On Mon, 31 Mar 2008 16:49:32 -0700, Darrick J. Wong wrote:
> On a QS22 blade, the BMC containing the (ibmpex) power meters is enumerated
> via Open Firmware.  Check for "of_platform" to handle this case.
> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
> 
> Index: lm-sensors-3.0.0/lib/sysfs.c
> =================================> --- lm-sensors-3.0.0.orig/lib/sysfs.c	2008-03-31 16:08:07.000000000 -0700
> +++ lm-sensors-3.0.0/lib/sysfs.c	2008-03-31 16:08:14.000000000 -0700
> @@ -532,7 +532,8 @@
>  		entry.chip.bus.type = SENSORS_BUS_TYPE_PCI;
>  		entry.chip.bus.nr = 0;
>  	} else
> -	if ((!subsys || !strcmp(subsys, "platform"))) {
> +	if ((!subsys || !strcmp(subsys, "platform") ||
> +			!strcmp(subsys, "of_platform"))) {
>  		/* must be new ISA (platform driver) */
>  		if (sscanf(dev_name, "%*[a-z0-9_].%d", &entry.chip.addr) != 1)
>  			entry.chip.addr = 0;

We can of course apply this but I am wondering if this is needed in the
long run... I seem to recall a discussion about of_platform being soon
deprecated and Open Firmware-based devices would just use platform. Ah,
here it is:

http://lists.lm-sensors.org/pipermail/i2c/2007-December/002548.html

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
