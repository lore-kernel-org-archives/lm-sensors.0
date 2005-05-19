From: drewie@freemail.hu (Andras BALI)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: lm77 on national sc1100
Message-Id: <1088808306.21805.18.camel@null>
List-Id: <lm-sensors.vger.kernel.org>
References: <1088690691.2862.25.camel@null>
In-Reply-To: <1088690691.2862.25.camel@null>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2004-07-02 at 23:55, Jean Delvare wrote:

> OK, I reworked both the LM75 and the LM77 detection routines to take
> benefit of that singularity. It should make detection of these chips
> quite reliable now.

> Andras, Mark, can you please test again? Confidence 6 is expected.

It's still confidence 3 there, you forgot this:

--- sensors-detect.old  2004-07-03 00:40:51.000000000 +0200
+++ sensors-detect      2004-07-03 00:42:32.000000000 +0200
@@ -2922,10 +2922,15 @@
     or (($low >> 12) != 0 && ($low >> 12) != 0xf)
     or (($high >> 12) != 0 && ($high >> 12) != 0xf);

+  $cur /= 16;
+  $hyst /= 16;
+  $os /= 16;
+  $high /= 16;
+  $low /= 16;

   # Most probable value ranges
   return 6 if $cur <= 100 and $hyst <= 40
-    and ($os >= 20 && $os <= 127) and ($high >= 20 && $os <= 127);
+    and ($os >= 20 && $os <= 127) and ($high >= 20 && $high <= 127);
   return 3;
 }

I'll be off for the weekend so I won't be able for a while.

Thanks,
Andras

