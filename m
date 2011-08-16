From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 16 Aug 2011 16:47:27 +0000
Subject: Re: [lm-sensors] Alix 2D2
Message-Id: <1313513247.3235.9.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <4E4A9BEE.5030108@sysnux.pf>
In-Reply-To: <4E4A9BEE.5030108@sysnux.pf>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Tue, 2011-08-16 at 12:33 -0400, Jean-Denis Girard wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi list,
> 
> I have a small system built around an Alix 2D2 motherboard. lm_sensors
> used to work fine using the scx200_axb and lm90 modules, I was able to
> get this:
> 
> [admin@localhost ~]$ sensors
> lm86-i2c-0-4c
> Adapter: CS5536 ACB0
> temp1:       +40.0°C  (low  =  +0.0°C, high = +70.0°C)
>                       (crit = +85.0°C, hyst = +75.0°C)
> temp2:       +45.9°C  (low  =  +0.0°C, high = +70.0°C)
>                       (crit = +85.0°C, hyst = +75.0°C)
> 
> But for some time now, it no longer works. I load the same modules, but
> it seems like the lm90 is no longer seen, though the module loads fine.
> All I get in the logs is:
> 	scx200_acb: NatSemi SCx200 ACCESS.bus Driver
> 	i2c /dev entries driver
> 
> I'm using lm_sensors-3.3.0, and kernel-3.0.1 (config attached).
> 
> sensors-detect output:
> 
> Do you want to probe the I2C/SMBus adapters now? (YES/no):
> Using driver `scx200_acb' for device 0000:00:0f.0: CS5536 [Geode
> companion] ISA
> Module scx200_acb loaded successfully.
> Module i2c-dev loaded successfully.
> 
> Sorry, no sensors were detected.
> 
> What am I missing ?
> 
Hi,

First question is what you mean with "for some time now". days ? weeks ?
months ? years ? since 3.0 ? 2.6.39 ? 2.4.16 ?

Would be great if you can point to the most recent working kernel.

Second, please provide output of "i2cdetect 0" (i2c-dev needs to be
loaded for this to work). That should show us if the sensor is still
detected on the i2c bus.

If it is, please also provide output of "i2cdump 0 0x4c".

For the lm90 module, please make sure that it is really loaded. You can
verify this with the "lsmod" command.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
