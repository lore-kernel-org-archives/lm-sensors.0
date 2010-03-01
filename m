From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 01 Mar 2010 13:19:35 +0000
Subject: Re: [lm-sensors] Activate WD chip on Tyan S7025?
Message-Id: <20100301141935.1bb197fc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201003011345.55821.carsten.aulbert@aei.mpg.de>
In-Reply-To: <201003011345.55821.carsten.aulbert@aei.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo Carsten,

On Mon, 1 Mar 2010 13:45:53 +0100, Carsten Aulbert wrote:
> I would like to try to use lm-sensors (Debian Squeeze version 3.1.2), but I 
> receive the following messages:
> 
> Found `Winbond W83627DHG-P Super IO Sensors' (address 0xa10, but not 
> activated)
> 
> Is there a known way to enable this chip?

Yes there is, but in 99% of the cases, disabled sensors in Super-I/O
chips are disabled because they are not used, so enabling them will no
lead you anywhere. You can load the w83627ehf driver and it will enable
the sensors for you, but chances are that the output of "sensors" will
be full of zeroes or otherwise meaningless values.

> PS: I'm currently trying lm-sensors as the IPMI card does not show sensor 
> information either, thus it might just be that the chip is "off" and needs to 
> be kicked (working with Tyan/Mitac on a solution in parallel)

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
