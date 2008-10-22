From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 22 Oct 2008 11:42:24 +0000
Subject: Re: [lm-sensors] How the lm-sensors communicate with the device
Message-Id: <20081022134224.4914ed84@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CF6163088BDE8747873ADAA4AF922BF258D530@zmy16exm21.fsl.freescale.net>
In-Reply-To: <CF6163088BDE8747873ADAA4AF922BF258D530@zmy16exm21.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Vincent,

On Tue, 21 Oct 2008 19:23:58 +0800, Hu Mingkai-B21284 wrote:
> Hi All,
>  
> I wrote a MCP3021's driver using the new I2C device model under Linux
> 2.6.26.
> The chip MCP3021 is connected to Freescale's I2C controller.
> Now it works well, the following is the log info:
>  
> -sh-2.05b# ls /sys/bus/i2c/drivers/mcp3021/
> 0-004d  1-004d  bind  module  uevent  unbind
> -sh-2.05b#
>  
> -sh-2.05b# cat /sys/bus/i2c/drivers/mcp3021/0-004d/name
> mcp3021
> -sh-2.05b# cat /sys/bus/i2c/drivers/mcp3021/0-004d/in0_input
> 213
> -sh-2.05b# cat /sys/bus/i2c/drivers/mcp3021/0-004d/in0_max
> 213
> -sh-2.05b# cat /sys/bus/i2c/drivers/mcp3021/0-004d/in0_min
> 192 
> -sh-2.05b# cat /sys/bus/i2c/drivers/mcp3021/0-004d/curr1_input
> 960
> -sh-2.05b# cat /sys/bus/i2c/drivers/mcp3021/0-004d/curr1_max
> 1065
> -sh-2.05b# cat /sys/bus/i2c/drivers/mcp3021/0-004d/curr1_min
> 945
>  
> -sh-2.05b# sensors
> mcp3021-i2c-0-4d
> 
> Adapter: MPC adapter
> in0:         +0.21 V  (min =  +0.19 V, max =  +0.22 V)
>  
> mcp3021-i2c-1-4d
> Adapter: MPC adapter
> in0:         +0.41 V  (min =  +0.41 V, max =  +0.41 V)
> 
> Q:
> 1. How the lm-sensors communicate with the device driver?

sensors relies on libsensors (see man libsensors(3) for the
implementation details), libsensors relies on a standardized sysfs
interface (see Documentation/hwmon/sysfs-interface in the kernel source
tree), and kernel drivers do the actual hardware I/O and expose sysfs
attributes.

> 2. How the lm-sensors get the attribute info?

libsensors reads the values from sysfs, just like you did. I'm not
going to explain in details how it works, that would take more time
than I have, and the source code is available for you to read. I can
answer precise questions though.

> 2. Why the current info, i.e. curr1_x, doesn't list ?

Because both libsensors and sensors currently lack support for current
sensors. It happens that I just added support for that this morning,
I'm going to send the patches to the list, please try them and report.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
