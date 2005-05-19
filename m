From: lassahn@eup.pandacom.de (Peter Lassahn)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: AW: i2c-2.8.0 : userspace applications using /dev interface
Message-Id: <000a01c37841$66b5e570$154310ac@NBLASSAHN>
List-Id: <lm-sensors.vger.kernel.org>
References: <000901c37841$38703170$154310ac@NBLASSAHN>
In-Reply-To: <000901c37841$38703170$154310ac@NBLASSAHN>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

plain text now

>  -----Urspr?ngliche Nachricht-----
> Von: 	Peter Lassahn [mailto:lassahn@eup.pandacom.de]
> Gesendet:	Donnerstag, 11. September 2003 10:47
> An:	'sensors@stimpy.netroedge.com'
> Betreff:	i2c-2.8.0 : userspace applications using /dev interface
>
> Dear Ladies and Gentlemen,
>
> We lack some understanding on how i2c-2.8.0 userspace applications using
the /dev interface and ioctl()s have to be programmed (we tested with kernel
2.4.22).
>
> It seem to be necessary to include i2c.h in addition to i2c-dev.h in order
to get access to defines like I2C_SLAVE for the ioctl()s.
>
> However, i2c.h can not be included by userspace applications because it
uses kernel space typedefs and declarations.
> This is in agreement with your example in the LM Sensors project
(prog/detect/i2cdetect.c). It uses I2C_SLAVE without including i2c.h.
>
> Is there a way out here ?
>
> Best regards
>
> Peter Lassahn
