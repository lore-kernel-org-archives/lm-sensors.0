From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: [PATCH] I2C update for 2.6.10-rc1
Message-Id: <10999778574012@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1099977857196@kroah.com>
References: <10999778552595@kroah.com>
In-Reply-To: <10999778552595@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.2014.1.20, 2004/11/08 16:45:03-08:00, jthiessen@penguincomputing.com

[PATCH] I2C: fix lm85.c build warnings

Signed-off-by: Justin Thiessen <jthiessen@penguincomputing.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/lm85.c |   32 --------------------------------
 1 files changed, 32 deletions(-)


diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	2004-11-08 18:54:44 -08:00
+++ b/drivers/i2c/chips/lm85.c	2004-11-08 18:54:44 -08:00
@@ -210,38 +210,6 @@
  *       MSB (bit 3, value 8).  If the enable bit is 0, the encoded value
  *       is ignored, or set to 0.
  */
-static int lm85_smooth_map[] = {  /* .1 sec */
-		350, 176, 118,  70,  44,   30,   16,    8
-/*    35.4 *    1/1, 1/2, 1/3, 1/5, 1/8, 1/12, 1/24, 1/48  */
-	};
-static int SMOOTH_TO_REG( int smooth )
-{
-	int i;
-
-	if( smooth <= 0 ) { return 0 ; }  /* Disabled */
-	for( i = 0 ; i < 7 ; ++i )
-		if( smooth >= lm85_smooth_map[i] )
-			break ;
-	return( (i & 0x07) | 0x08 );
-}
-#define SMOOTH_FROM_REG(val) ((val)&0x08?lm85_smooth_map[(val)&0x07]:0)
-
-/* These are the fan spinup delay time encodings */
-static int lm85_spinup_map[] = {  /* .1 sec */
-		0, 1, 2, 4, 7, 10, 20, 40
-	};
-static int SPINUP_TO_REG( int spinup )
-{
-	int i;
-
-	if( spinup >= lm85_spinup_map[7] ) { return 7 ; }
-	for( i = 0 ; i < 7 ; ++i )
-		if( spinup <= lm85_spinup_map[i] )
-			break ;
-	return( i & 0x07 );
-}
-#define SPINUP_FROM_REG(val) (lm85_spinup_map[(val)&0x07])
-
 /* These are the PWM frequency encodings */
 static int lm85_freq_map[] = { /* .1 Hz */
 		100, 150, 230, 300, 380, 470, 620, 940

