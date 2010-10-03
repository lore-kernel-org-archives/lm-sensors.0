From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 03 Oct 2010 15:31:26 +0000
Subject: Re: [lm-sensors] W38795ADG sensors.conf for SuperMicro C7X58/X8SAX
Message-Id: <20101003173126.045a2381@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101002024101.GA6862@khazad-dum.debian.net>
In-Reply-To: <20101002024101.GA6862@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Henrique,

On Fri, 1 Oct 2010 23:41:01 -0300, Henrique de Moraes Holschuh wrote:
> Please add this to the lm-sensors wiki, and any relevant userspace config
> files being shipped in lm-sensors userspace.

Thanks for your contribution.

http://www.lm-sensors.org/wiki/Configurations/SuperMicro/C7X58
http://www.lm-sensors.org/wiki/Configurations/SuperMicro/X8SAX

Just one question: what's the point of having a "w83627dhg-*" section
in the configuration file, given that you don't want to load the
w83627ehf driver in the first place, if it's useless on this board?

> The BIOS does not set the correct limits for VTT, but it is wired.

Why don't you set the limits in the configuration file then?

> I still haven't found how the PWM outputs are wired in this board, though,
> due to my mix of PWM and non-PWM fans I cannot enable fan control.

Note that I did not review that part of the driver yet, and I know
there are a few oddities there. The BIOS-defined automatic control
works OK on my board, but if you attempt to tweak it using the driver,
I can't guarantee it will work OK.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
