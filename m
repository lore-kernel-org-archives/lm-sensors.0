From: mark@alpha.dyndns.org (Mark McClelland)
Date: Thu, 19 May 2005 06:23:55 +0000
Subject: Request for IDs for ovcam and w9967cf drivers
Message-Id: <3EAE7227.3030008@alpha.dyndns.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello everybody,

I'd like to request the following I2C IDs for the OVCam driver project 
<http://alpha.dyndns.org/ov511/>

I2C_DRIVERID_OVCAMCHIP
   Chips: OmniVision OV6130, OV6630, OV7110, OV7610, OV76BE, OV7120,
          OV7620, and OV7620AE CMOS image sensors
   Address: 0x60 (OV6xxx), 0x21 (OV7xxx)
   Driver: ovcamchip (formerly ovsensor)
   Driver status: Preparing for 2.5 kernel inclusion

I2C_DRIVERID_TDA7313
   Chips: SGS-Thomson TDA7313 and Princeton Technology PT2313L audio 

          processors
   Address: 0x44
   Driver: tda7313
   Driver status: Minimally functional

I2C_HW_SMBUS_OV511
   Chips: OmniVision OV511 and OV511+ USB 1.1 webcam ICs
   Driver: ov511
   Driver status: In 2.4/2.5 kernel (I2C support under development)

I2C_HW_SMBUS_OV518
   Chips: OmniVision OV518 and OV518+ USB 1.1 webcam ICs
   Driver: ov511 (not a typo; the drivers are in the same module)
   Driver status: In 2.4/2.5 kernel (I2C support under development)

I2C_HW_SMBUS_OV519
   Chips: OmniVision OV519 USB 1.1 webcam IC
   Driver: ov519
   Driver status: Under development

I2C_HW_SMBUS_OVFX2
   Chips: Cypress Ez-USB FX2 with OmniVision USB 2.0 webcam firmware
   Driver: ovfx2
   Driver status: Experimental

At the request of Luca <luca_ing@libero.it> of the W9968CF camera driver 
project <http://go.lamarinapunto.com/>, I would also like to request the 
following ID:

I2C_HW_SMBUS_W9968CF
   Chips: Winbond W9967CF and W9968CF, and OmniVision OV681, dual-mode 

          USB camera ICs
   Driver: w9968cf
   Driver status: Ready for 2.5 kernel inclusion

You may add this info to your webpage if you like.

I would like to take this opportunity to thank all the members of the 
Lm_sensors project for your excellent driver framework and thorough 
documentation. Keep up the great work!

Best regards to all,
-- 
Mark McClelland
mark@alpha.dyndns.org
