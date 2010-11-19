From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 19 Nov 2010 15:57:47 +0000
Subject: Re: [lm-sensors] Build warning in i5k_amb.c
Message-Id: <20101119165747.7afd6446@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101119144831.GB17616@ericsson.com>
In-Reply-To: <20101119144831.GB17616@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Fri, 19 Nov 2010 06:48:31 -0800, Guenter Roeck wrote:
> the following build warning is reported in the "Build regressions/improvements in v2.6.37-rc2"
> post sent to lkml.
> 
> drivers/hwmon/i5k_amb.c:500: warning: 'i5k_amb_ids' defined but not used: 1 warnings in 1 logs
>         v2.6.37-rc2/powerpc/powerpc-allyesconfig
> 
> Any idea how to fix it ? I am a bit at loss about what is going on.

MODULE_DEVICE_TABLE() resolves to nothing if the driver is built into
the kernel (as opposed to built as a module). Other drivers don't get a
warning because the IDs are also used by the driver itself, but for a
reason unknown to me [1], this driver registers itself as a platform
driver rather than a PCI driver, and thus can't point to PCI IDs.

You can reproduce the warning by building your kernel with:
CONFIG_SENSORS_I5K_AMB=y

The fix should be as easy as embracing the declaration of i5k_amb_ids
with a #ifdef MODULE/#endif pair.

[1] Might as well be that I knew it but forgot by now.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
