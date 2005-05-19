From: henk.vergonet@t-mobile.nl (Vergonet, Henk)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: New i2c bus driver for S3/VIA chipsets
Message-Id: <5488F12E9B54CC4C9FF74BBE0F08959A07E034D7@ben-hqmail01.ben.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Gentlemen (women?), 

I would like to submit a new i2c backend driver (GPL), can you give me a
hint
on how to get this in the standard lm_sensors development tree?

Is there a public mailing list I could send the code as an atachment?

Can you reserve a adaptor ID for this hardware driver? For example:

#define I2C_HW_B_S3VIA	0x13	/* S3VIA ProSavage adapter		*/


Kind Regards,

Henk Vergonet



/*  18-05-2003 - created
 *
 *  This driver interfaces to the I2C bus of the VIA north bridge embedded
 *  ProSavage4/8 devices. Usefull for gaining access to the TV Encoder
chips.
 *
 *  Two serial busses are implemented:
 *   SERIAL1 - I2C serial communications interface
 *   SERIAL2 - DDC2 monitor communications interface
 *
 *  Should work for these graphics cores (and possibly others):
 *   S3/VIA KM266/VT8375 aka ProSavage8
 *   S3/VIA KM133/VT8365 aka Savage4
 *
 *  Only tested on a FX41 mainboard, see http://www.shuttle.com
 * 
 *
 */





N.B.: op (de inhoud van) deze e-mail is een DISCLAIMER met belangrijke
VOORBEHOUDEN van toepassing: zie http://www.t-mobile.nl/disclaimer 

This e-mail and its contents are subject to a DISCLAIMER with important
RESERVATIONS: see http://www.t-mobile.nl/disclaimer 

