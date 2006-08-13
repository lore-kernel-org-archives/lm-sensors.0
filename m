From: bunk@stusta.de (Adrian Bunk)
Date: Sun, 13 Aug 2006 21:00:12 +0000
Subject: [lm-sensors] [-mm patch] make
Message-Id: <20060813210012.GK3543@stusta.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060813012454.f1d52189.akpm@osdl.org>
In-Reply-To: <20060813012454.f1d52189.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>, Shem Multinymous <multinymous@gmail.com>
Cc: linux-kernel@vger.kernel.org, khali@linux-fr.org, lm-sensors@lm-sensors.org

On Sun, Aug 13, 2006 at 01:24:54AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc3-mm2:
>...
> +hdaps-unify-and-cache-hdaps-readouts.patch
>...
>  HDAPS driver updates

transform_axes() isn't a good name for a global function.

Thankfully, it can simply made static.

Signed-off-by: Adrian Bunk <bunk at stusta.de>

--- linux-2.6.18-rc4-mm1/drivers/hwmon/hdaps.c.old	2006-08-13 17:45:34.000000000 +0200
+++ linux-2.6.18-rc4-mm1/drivers/hwmon/hdaps.c	2006-08-13 17:45:50.000000000 +0200
@@ -85,7 +85,7 @@
 static u64 last_mouse_jiffies = INITIAL_JIFFIES;
 
 /* Some models require an axis transformation to the standard reprsentation */
-void transform_axes(int *x, int *y)
+static void transform_axes(int *x, int *y)
 {
 	if (hdaps_invert) {
 		*x = -*x;


