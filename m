From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: Kernel 2.6.9 & adm1021 & i2c_piix4 temperature monitoring
Message-Id: <20041109191844.112a04cb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <UfARNKk2.1099926156.4923140.khali@gcu.info>
	<Pine.LNX.4.61.0411091216120.3869@p500>
In-Reply-To: <Pine.LNX.4.61.0411091216120.3869@p500>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

> How has it been re-worked, is the option no longer valid?

The option is still valid, but the init process is way less aggressive.
Chip isn't arbitrarily reset/reconfigured anymore, and temperature
limits are preserved. Thus what the option was trying to prevent is
probably not happening anymore in the first place.

> I believe it was along early 2.6.x and possibly 2.6.5-2.6.6 that I
> tried it without the option and the machine will shut itself off (due
> to lm-sensors/etc writing "their" values for what is too hot, forcing
> the machine to shutdown).
>
> $ sensors
> max1617-i2c-0-1a
> Adapter: SMBus PIIX4 adapter at 0850
> Board:       +45 C  (low  =   -55 C, high =  +127 C)
> CPU:         +41 C  (low  =   -55 C, high =  +110 C)
> 
> If I run without the option, the values change to something like -20 C
> to 50 or 60C, hence, when you compile a kernel it heats up and the box
> shuts itself off, with no warning at all, just powers off.

That part of the init process was actually removed in 2.6.6. Believe me,
you are not the only one to have complained about that nasty behavior.

-- 
Jean Delvare
http://khali.linux-fr.org/
