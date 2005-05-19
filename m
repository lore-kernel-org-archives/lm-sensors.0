From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: seperate mallocs
Message-Id: <20040403101308.4e089e1d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <406E5CFB.6030309@penguincomputing.com>
In-Reply-To: <406E5CFB.6030309@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> In the patch:
>     
> http://jdelvare.net1.nerim.net/sensors/lm_sensors-CVS-separate-mallocs.diff
> 
> to break the kmalloc's out, why did you remove the
> 
> -	default :
> -		printk("lm85: Internal error, invalid kind (%d)!", kind);
> -		err = -EFAULT ;
> -		goto ERROR1;
> 
> 
> clause from the kind detection switch statement in the ADM1026 and
> LM85 drivers?   Shouldn't we trap any invalid "kind" values?

After taking a closer look at the code it seemed obvious that this case
just couldn't happen. The negative "kind" case is handled by the "if
(kind <= 0)" block right above, and all the other values are handled in
the swicth/case block. So why would we try to catch an error that, by
construction, cannot happen?

Thanks for reviewing my patch, BTW.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
