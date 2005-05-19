From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: Request for I2C IDs
Message-Id: <20040118175528.66a9d01a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I hope you're the right person to contact about this. I sent this to
> the I2C mailing list a few months ago, but got no response.

That was the correct address. I see your previous post. Sorry we had no
time to answer then. Greg KH must know about it too.

> I'd like to request the following I2C IDs for the OVCam driver project
> 
> <http://alpha.dyndns.org/ov511/>:
> 
> I2C_DRIVERID_OVCAMCHIP
>   Chips: OmniVision OV6130, OV6630, OV7110, OV7610, OV76BE, OV7120,
>          OV7620, and OV7620AE CMOS image sensors
>   Address: 0x60 (OV6xxx), 0x21 (OV7xxx)
>   Driver: ovcamchip (formerly ovsensor)
>   Driver status: Preparing for 2.4 and 2.6 kernel inclusion
> 
> I2C_DRIVERID_TDA7313
>   Chips: SGS-Thomson TDA7313 and Princeton Technology PT2313L audio
>          processors
>   Address: 0x44
>   Driver: tda7313
>   Driver status: Minimally functional
> 
> I2C_HW_SMBUS_OV511
>   Chips: OmniVision OV511 and OV511+ USB 1.1 webcam ICs
>   Driver: ov511
>   Driver status: In 2.4/2.6 kernel (I2C support under development)
> 
> I2C_HW_SMBUS_OV518
>   Chips: OmniVision OV518 and OV518+ USB 1.1 webcam ICs
>   Driver: ov511 (not a typo; the drivers are in the same module)
>   Driver status: In 2.4/2.6 kernel (I2C support under development)
> 
> I2C_HW_SMBUS_OV519
>   Chips: OmniVision OV519 USB 1.1 webcam IC
>   Driver: ov519
>   Driver status: Under development
> 
> I2C_HW_SMBUS_OVFX2
>   Chips: Cypress Ez-USB FX2 with OmniVision USB 2.0 webcam firmware
>   Driver: ovfx2
>   Driver status: Experimental

One preliminary note: our authority on I2C IDs isn't unquestionable.
Sometimes people submit patches to the Linux kernel and use whatever ID
they want. It's a shame but it works. So, if someone is quicker than you
to use the following IDs, we may have to concede and have you change
your IDs.

Another note: you shouldn't expect to see any of your drivers accepted
into Linux 2.4 anymore.

Here we go anyway:

#define I2C_DRIVERID_OVCAMCHIP	61	/* OmniVision CMOS image sens.	*/
#define I2C_DRIVERID_TDA7313	62	/* TDA7313 audio processor	*/

#define I2C_HW_SMBUS_OV511	0x0e	/* OV511(+) USB 1.1 webcam ICs	*/
#define I2C_HW_SMBUS_OV518	0x0f	/* OV518(+) USB 1.1 webcam ICs	*/
#define I2C_HW_SMBUS_OV519	0x10	/* OV519 USB 1.1 webcam IC	*/
#define I2C_HW_SMBUS_OVFX2	0x11	/* Cypress Ez-USB FX2 USB 2.0	*/

Greg, should I send a patch to you with these?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
