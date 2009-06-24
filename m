From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 24 Jun 2009 10:05:46 +0000
Subject: Re: [lm-sensors] dme1737 sensors force_start
Message-Id: <20090624120546.542e2d80@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <SNT106-W242B7EE77BE87384F8FE15BA3D0@phx.gbl>
In-Reply-To: <SNT106-W242B7EE77BE87384F8FE15BA3D0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Kushal,

On Thu, 18 Jun 2009 10:09:33 -0700, Kushal Koolwal wrote:
> I am using Debian 5.0 with 2.6.30 kernel and my board has SCH3114 chip. Upon booting I get the following messages in the dmesg:
> [   70.012233] dme1737 dme1737.3184: Found a SCH311x chip at 0x0c70
> [   70.012326] dme1737 dme1737.3184: Device is not monitoring. Use the force_start load parameter to override.
> [   70.013552] dme1737 dme1737.3184: Failed to initialize device.
> [   70.013653] dme1737: probe of dme1737.3184 failed with error -14
> 
> So naturally the sensors-detect and sensors did not work.

Actually sensors-detect doesn't care at all.

> Upon loading the module the following way:
> modprobe dme1737 force_start
> 
> it started working fine.
> 
> Any ideas why I need to give force_start? Is this a chip /BIOS/OS issues?

BIOS issue. It's up to the BIOS to enable monitoring after the chip is
properly set up. That being said, some of our drivers silently enable
parts if they were disabled. I'm not so sure why the dme1737 driver
asks for the user to pass an extra parameter. But I can't really
complain, maybe I'm the one who asked for it, I just can't remember.
Juerg?

> In the past I have other boards which used the same chipset but in those I never had to give the force_start option.

Probably the BIOS of these boards were doing the right thing. You may
look for an updated BIOS for your new board, this might help.

> I am using sensors version 3.0.2 with libsensors version 3.0.2

This is a pure (BIOS and) kernel issue, version of lm-sensors doesn't
matter.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
