From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 24 May 2013 06:59:27 +0000
Subject: Re: [lm-sensors] W83L786G not detected on vx800
Message-Id: <20130524085927.6f646a4d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Richard,

On Fri, 24 May 2013 03:21:29 -0700, rh wrote:
> On the MB there is a winbond W83L786G but it is not detected
> by sensors-detect.  The  kernel is monolithic (i.e. no modules)
> and it is linux3.9.2.

Running sensors-detect on a monolithic kernel is rather pointless. The
whole purpose of sensors-detect is to tell you which kernel modules
should be loaded. If you built a monolithic kernel you must already
know that.

> It seems that lmsensors is unable to see this device but it is there.

"lmsensors" is a set of tools. Which tool(s) are you claiming can't see
the device? sensors-detect? sensors? Both? Something else?

What does "sensors" return?

> cat /sys/class/hwmon/hwmon1/device/name
> w83l786ng

It is there indeed.

> As I said the actual device is a w83l786g

Should't matter, while the chips aren't 100% compatible they have the
same chip ID so the same driver supports both.

> # sensors-detect revision 6085 (2012-10-30 18:18:45 +0100)
> # System: VIA Technologies Ltd. VX800 [1.0]
> (...)
> Next adapter: SMBus Via Pro adapter at 0500 (i2c-3)
> Do you want to scan it? (YES/no/selectively): 
> Client at address 0x2f can not be probed - unload all client drivers first!

This is your W83L786G chip. sensors-detect would tell you if the driver
was built as a module rather than embedded in the kernel.

I have improved sensors-detect so that it can handle monolithic kernels
better. Please give it a try and report the output:
  http://khali.linux-fr.org/devel/lm-sensors/sensors-detect

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
