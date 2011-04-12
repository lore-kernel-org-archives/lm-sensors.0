From: "Ian Dobson" <i.dobson@planet-ian.com>
Date: Tue, 12 Apr 2011 17:02:19 +0000
Subject: Re: [lm-sensors] NCT6776 global registers 0x1c=0 and 0x24=0x5c
Message-Id: <EC17F4969A0B41C7ADDFAC0A41007024@portable2>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110410160433.GA22075@localhost>
In-Reply-To: <20110410160433.GA22075@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

--------------------------------------------------
From: "Mike Campin" <lm_sensors@ootsa.homelinux.net>
Sent: Sunday, April 10, 2011 6:04 PM
To: <lm-sensors@lm-sensors.org>
Subject: [lm-sensors] NCT6776 global registers 0x1c=0 and 0x24=0x5c onASRock 
Extreme4

> Hi,
>
> Only 2 of the 5 fans are showing up on my ASRock P67 Extreme4 motherboard.
> It due to the NCT6776 global configuration register 0x1c and 0x24 values.
> The fans work if I modify these registers prior to loading the w83627ehf
> driver.
>
> My question is where are these registers initialized? Should I ask ASRock
> to fix the BIOS?
>
>  isadump -y -k 0x87,0x87 0x2e 0x2f
>
>          0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>     00: ff ff 00 ff ff ff ff 02 ff ff ff ff ff ff ff ff
>     10: ff ff ff ff ff ff ff ff ff ff f8 0e 00 00 ff ff
>     20: c3 33 ff 00 5c 00 00 98 00 ff 20 00 80 00 00 01
>     30: 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>
>  isaset -y -f 0x2e 0x87
>  isaset -y -f 0x2e 0x87
>  isaset -y 0x2e 0x2f 0x1c 0x3
>  isaset -y 0x2e 0x2f 0x24 0x1c
>
> Thanks, Mike
>
> -- 
> Mike Campin
> lm_sensors@ootsa.homelinux.net
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

ASRock designed the board, so they should setup the hardware monitoring chip 
correctly. Allowing users to change the chip configuration is a really bad 
idea, as many of the pins can have different functionality/electrical 
spcifications depending on the config. Setting up a pin incorrectly could 
blow the chip (Configuring a pin so that it's a source that's connected to 
an unprotected/limited sink for example).

So ASRock should fix the BIOS.

Regards
Ian Dobson
 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
