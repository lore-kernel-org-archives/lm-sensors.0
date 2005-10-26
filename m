From: mchehab@brturbo.com.br (Mauro Carvalho Chehab)
Date: Wed, 26 Oct 2005 22:17:12 +0000
Subject: [lm-sensors]
Message-Id: <1130357744.23547.21.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greg,

	Please don't send this patch to Andrew or mainstream. I'll apply it on
my tree and I will send it at the end my patchset series, for not
breaking these.

	I have several patches that are including newer IDs on
linux/media/i2c-id.h and I'm just preparing a patch, on V4L tree, to
remove this file from kernel.

	If this is applied, it may break dozens of patches I've already
prepared (at
http://wwwlinuxtv.org/download/video4linux/patches/2.6.14-rc5)

	Maybe it would be wiser if patches that touches drivers/media devices
maintained on V4L go first to me, and I send to Andrew. This way, it
would help us not to redo an entire patchset for fixing broken stuff
because they would be included on a wrong order.

Cheers,
Mauro.


Em Qua, 2005-10-26 ?s 21:17 +0200, Jean Delvare escreveu:
> Content-Disposition: inline; filename=i2c-id-clean-redefinitions-2.patch
> 
> Second round of i2c IDs redefinition cleanup.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> CC: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
> CC: John Klar <linpvr@projectplasma.com>
> 
> ---
>  drivers/media/video/bt832.c             |    1 -
>  drivers/media/video/msp3400.c           |    1 -
>  drivers/media/video/saa6588.c           |    2 --
>  drivers/media/video/saa7134/saa6752hs.c |    2 --
>  drivers/media/video/saa7134/saa7134.h   |    1 -
>  drivers/media/video/tda7432.c           |    1 -
>  drivers/media/video/tda9875.c           |    1 -
>  drivers/media/video/tda9887.c           |    1 -
>  drivers/media/video/tvaudio.c           |    3 +--
>  drivers/media/video/tveeprom.c          |    4 ----
>  include/linux/i2c-id.h                  |    3 +++
>  include/media/id.h                      |   35 -------------------------------
>  12 files changed, 4 insertions(+), 51 deletions(-)
> 
> --- linux-2.6.14-rc5.orig/drivers/media/video/tvaudio.c	2005-10-23 17:42:05.000000000 +0200
> +++ linux-2.6.14-rc5/drivers/media/video/tvaudio.c	2005-10-24 19:43:05.000000000 +0200
> @@ -31,7 +31,6 @@
>  #include <linux/smp_lock.h>
>  
>  #include <media/audiochip.h>
> -#include <media/id.h>
>  
>  #include "tvaudio.h"
>  
> @@ -1438,7 +1437,7 @@
>  	},
>  	{
>  		.name       = "pic16c54 (PV951)",
> -		.id         = I2C_DRIVERID_PIC16C54_PV951,
> +		.id         = I2C_DRIVERID_PIC16C54_PV9,
>  		.insmodopt  = &pic16c54,
>  		.addr_lo    = I2C_PIC16C54 >> 1,
>  		.addr_hi    = I2C_PIC16C54>> 1,
> --- linux-2.6.14-rc5.orig/include/linux/i2c-id.h	2005-10-24 19:38:22.000000000 +0200
> +++ linux-2.6.14-rc5/include/linux/i2c-id.h	2005-10-24 19:43:05.000000000 +0200
> @@ -99,6 +99,9 @@
>  #define I2C_DRIVERID_MAX6900	63	/* MAX6900 real-time clock	*/
>  #define I2C_DRIVERID_SAA7114H	64	/* video decoder		*/
>  #define I2C_DRIVERID_DS1374	65	/* DS1374 real time clock	*/
> +#define I2C_DRIVERID_TDA9874	66	/* TV sound decoder		*/
> +#define I2C_DRIVERID_SAA6752HS	67	/* MPEG2 encoder		*/
> +#define I2C_DRIVERID_TVEEPROM	68	/* TV EEPROM			*/
>  
> 
>  #define I2C_DRIVERID_EXP0	0xF0	/* experimental use id's	*/
> --- linux-2.6.14-rc5.orig/include/media/id.h	2005-09-13 21:21:25.000000000 +0200
> +++ /dev/null	1970-01-01 00:00:00.000000000 +0000
> @@ -1,35 +0,0 @@
> -/*
> - */
> -
> -/* FIXME: this temporarely, until these are included in linux/i2c-id.h */
> -
> -/* drivers */
> -#ifndef  I2C_DRIVERID_TVMIXER
> -# define I2C_DRIVERID_TVMIXER I2C_DRIVERID_EXP0
> -#endif
> -#ifndef  I2C_DRIVERID_TVAUDIO
> -# define I2C_DRIVERID_TVAUDIO I2C_DRIVERID_EXP1
> -#endif
> -
> -/* chips */
> -#ifndef  I2C_DRIVERID_DPL3518
> -# define I2C_DRIVERID_DPL3518 I2C_DRIVERID_EXP2
> -#endif
> -#ifndef  I2C_DRIVERID_TDA9873
> -# define I2C_DRIVERID_TDA9873 I2C_DRIVERID_EXP3
> -#endif
> -#ifndef  I2C_DRIVERID_TDA9875
> -# define I2C_DRIVERID_TDA9875 I2C_DRIVERID_EXP0+4
> -#endif
> -#ifndef  I2C_DRIVERID_PIC16C54_PV951
> -# define I2C_DRIVERID_PIC16C54_PV951 I2C_DRIVERID_EXP0+5
> -#endif
> -#ifndef  I2C_DRIVERID_TDA7432
> -# define I2C_DRIVERID_TDA7432 I2C_DRIVERID_EXP0+6
> -#endif
> -#ifndef  I2C_DRIVERID_TDA9874
> -# define I2C_DRIVERID_TDA9874 I2C_DRIVERID_EXP0+7
> -#endif
> -#ifndef  I2C_DRIVERID_SAA6752HS
> -# define I2C_DRIVERID_SAA6752HS I2C_DRIVERID_EXP0+8
> -#endif
> --- linux-2.6.14-rc5.orig/drivers/media/video/tveeprom.c	2005-10-23 17:42:05.000000000 +0200
> +++ linux-2.6.14-rc5/drivers/media/video/tveeprom.c	2005-10-24 19:43:05.000000000 +0200
> @@ -590,10 +590,6 @@
>  /* run, just call the exported tveeprom_* directly, there is no point in   */
>  /* using the indirect way via i2c_driver->command()                        */
>  
> -#ifndef I2C_DRIVERID_TVEEPROM
> -# define I2C_DRIVERID_TVEEPROM I2C_DRIVERID_EXP2
> -#endif
> -
>  static unsigned short normal_i2c[] = {
>  	0xa0 >> 1,
>  	I2C_CLIENT_END,
> --- linux-2.6.14-rc5.orig/drivers/media/video/bt832.c	2005-10-23 17:42:05.000000000 +0200
> +++ linux-2.6.14-rc5/drivers/media/video/bt832.c	2005-10-24 19:43:05.000000000 +0200
> @@ -32,7 +32,6 @@
>  #include <linux/slab.h>
>  
>  #include <media/audiochip.h>
> -#include <media/id.h>
>  #include "bttv.h"
>  #include "bt832.h"
>  
> --- linux-2.6.14-rc5.orig/drivers/media/video/msp3400.c	2005-10-23 17:42:05.000000000 +0200
> +++ linux-2.6.14-rc5/drivers/media/video/msp3400.c	2005-10-24 19:43:05.000000000 +0200
> @@ -54,7 +54,6 @@
>  #include <asm/pgtable.h>
>  
>  #include <media/audiochip.h>
> -#include <media/id.h>
>  #include "msp3400.h"
>  
>  #define OPMODE_AUTO    -1
> --- linux-2.6.14-rc5.orig/drivers/media/video/saa6588.c	2005-10-23 17:42:05.000000000 +0200
> +++ linux-2.6.14-rc5/drivers/media/video/saa6588.c	2005-10-24 19:43:05.000000000 +0200
> @@ -31,8 +31,6 @@
>  #include <linux/wait.h>
>  #include <asm/uaccess.h>
>  
> -#include <media/id.h>
> -
>  #include "rds.h"
>  
>  /* Addresses to scan */
> --- linux-2.6.14-rc5.orig/drivers/media/video/saa7134/saa6752hs.c	2005-10-23 17:42:05.000000000 +0200
> +++ linux-2.6.14-rc5/drivers/media/video/saa7134/saa6752hs.c	2005-10-24 19:43:05.000000000 +0200
> @@ -13,8 +13,6 @@
>  #include <linux/init.h>
>  #include <linux/crc32.h>
>  
> -#include <media/id.h>
> -
>  #define MPEG_VIDEO_TARGET_BITRATE_MAX  27000
>  #define MPEG_VIDEO_MAX_BITRATE_MAX     27000
>  #define MPEG_TOTAL_TARGET_BITRATE_MAX  27000
> --- linux-2.6.14-rc5.orig/drivers/media/video/saa7134/saa7134.h	2005-09-13 21:21:09.000000000 +0200
> +++ linux-2.6.14-rc5/drivers/media/video/saa7134/saa7134.h	2005-10-24 19:43:05.000000000 +0200
> @@ -32,7 +32,6 @@
>  
>  #include <media/tuner.h>
>  #include <media/audiochip.h>
> -#include <media/id.h>
>  #include <media/ir-common.h>
>  #include <media/video-buf.h>
>  #include <media/video-buf-dvb.h>
> --- linux-2.6.14-rc5.orig/drivers/media/video/tda7432.c	2005-10-23 17:42:05.000000000 +0200
> +++ linux-2.6.14-rc5/drivers/media/video/tda7432.c	2005-10-24 19:43:05.000000000 +0200
> @@ -50,7 +50,6 @@
>  
>  #include "bttv.h"
>  #include <media/audiochip.h>
> -#include <media/id.h>
>  
>  #ifndef VIDEO_AUDIO_BALANCE
>  # define VIDEO_AUDIO_BALANCE 32
> --- linux-2.6.14-rc5.orig/drivers/media/video/tda9875.c	2005-10-23 17:42:05.000000000 +0200
> +++ linux-2.6.14-rc5/drivers/media/video/tda9875.c	2005-10-24 19:43:05.000000000 +0200
> @@ -32,7 +32,6 @@
>  
>  #include "bttv.h"
>  #include <media/audiochip.h>
> -#include <media/id.h>
>  
>  static int debug; /* insmod parameter */
>  module_param(debug, int, S_IRUGO | S_IWUSR);
> --- linux-2.6.14-rc5.orig/drivers/media/video/tda9887.c	2005-10-23 17:42:05.000000000 +0200
> +++ linux-2.6.14-rc5/drivers/media/video/tda9887.c	2005-10-24 19:43:05.000000000 +0200
> @@ -11,7 +11,6 @@
>  
>  #include <media/audiochip.h>
>  #include <media/tuner.h>
> -#include <media/id.h>
>  
>  /* Chips:
>     TDA9885 (PAL, NTSC)
> 
Cheers, 
Mauro.

