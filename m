From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: seperate mallocs
Message-Id: <406E5CFB.6030309@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In the patch:

    
http://jdelvare.net1.nerim.net/sensors/lm_sensors-CVS-separate-mallocs.diff

to break the kmalloc's out, why did you remove the

-	default :
-		printk("lm85: Internal error, invalid kind (%d)!", kind);
-		err = -EFAULT ;
-		goto ERROR1;


clause from the kind detection switch statement in the ADM1026 and LM85 drivers?   Shouldn't we trap any invalid "kind" values?

:v)


