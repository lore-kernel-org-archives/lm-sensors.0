From: achim <achim@ag-web.biz>
Date: Fri, 09 May 2008 17:31:44 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Check for 1-register-only
Message-Id: <1210354304.3498.15.camel@debian-9850.ag-home.muc>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080508224145.41cfa3ef@hyperion.delvare>
In-Reply-To: <20080508224145.41cfa3ef@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Freitag, den 09.05.2008, 19:05 +0200 schrieb Jean Delvare:
> 
> > Afterward i tried it with only 0x4c excluded and the smbus chip still
> > works. With no exclusions lm75 detection hangs at 0x4c and afterwards i
> > only get XX's from dumps.
> 
> By "hangs" you mean it takes several seconds, or does it really stop?
> Are you certain that it's the LM75 detection causing problem? We check
> for no less than 33 different devices at address 0x4c...
> 
-------------------------------------------------
Client found at address 0x4c
Probing for `National Semiconductor LM75'...         
-------------------------------------------------
This is where it stops for a few seconds.
i2cdump 0 0x4c w hangs in a way that i must cancle it with Ctrl-C and
afterwards i need a reboot to get correct dumps.

> Anyway, most certainly the problem is with word transactions on this
> device you have at 0x4c. That won't be easy to work around, but I'll
> take a look anyway, maybe I'll have an idea. If I do, I'll ask you -
> again - to help with testing. 

As i noted in an other mail the interface can be accessed via the pci
registers F3x1E80 (address) and F3x1EC0 (data).
Bit 3 of pci register F3x1E40 indicates that this way of access is
possible if unset (0b). But those addresses can not be accessed
via /proc/bus/pci atm. 

> Thanks *a lot* for all the help you are
> providing in this respect.
> 
Glad I can help. I was curious for a long time how this i2c/smbus stuff
works in detail, so that is a good situation to find out more about.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
