From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Sat, 06 Feb 2010 09:42:51 +0000
Subject: Re: [lm-sensors] [PATCH] linux-2.6.32-directemp
Message-Id: <20100206104251.1be31941@neptune.home>
List-Id: <lm-sensors.vger.kernel.org>
References: <68FBE0F3CE97264395875AC1C468F22C24A5BD@mail03.cyberswitching.local>
In-Reply-To: <68FBE0F3CE97264395875AC1C468F22C24A5BD@mail03.cyberswitching.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Verges <chrisv@cyberswitching.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Owings <rowings@thermistor.com>, lm-sensors@lm-sensors.org

On Thu, 04 February 2010 "Chris Verges" wrote:
> Attached is a patch for the QTI DirecTEMP USB thermometer &
> thermometer/hygrometer sensors.  This patch is based on linux-2.6.32.
> Functionality has been verified against both hardware variants listed
> in the driver (0x0002 and 0x0006), as both monolithic and modular.
> 
> When the QTI DirecTEMP sensor is connected to a system, the directemp
> driver adds appropriate sysfs entries for the sensor type(s)
> supported. Examples:
> 
>    # PID 0x0002 (temp only)
>    /sys/bus/usb/devices/.../temp
> 
>    # PID 0x0006 (temp + relative humidity)
>    /sys/bus/usb/devices/.../temp
>    /sys/bus/usb/devices/.../rh
> 
> Using a standard "cat" will display the value.

Wouldn't it make sense to make use of hardware monitoring interfaces so
lm_sensors could handle the sensor information? (added to CC)

This would also be a good reason to have the driver on kernel side
rather than somewhere in userspace.

Bruno

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
