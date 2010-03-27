From: Michael Fuckner <michael@fuckner.net>
Date: Sat, 27 Mar 2010 16:14:41 +0000
Subject: [lm-sensors] 32nm Support vor drivers/hwmon/coretemp.c
Message-Id: <4BAE2EF1.3020600@fuckner.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I just looked into git and saw currently no support for coretemp on 
Intels 32nm CPUs. Currently I just had Xeon 5630 and i5-660 to play with.

Model 25 Westmere
Model 2C Clarkdale

[0.38] molli123@c64:/usr/home/molli123/linux-2.6.33.1/drivers/hwmon > 
diff coretemp.c.old coretemp.c
458c458
<                 0x1e (Lynnfield) */
---
 >                 0x1e (Lynnfield), 0x25 (Clarkdale), 0x2c (Westmere)  */
463c463,464
<                       (c->x86_model = 0x1e))) {
---
 >                       (c->x86_model = 0x1e) || (c->x86_model = 0x25) ||
 >                       (c->x86_model = 0x2C))) {


Regards,
  Michael!

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
