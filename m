From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 22 May 2005 17:18:42 +0000
Subject: [lm-sensors] [PATCH] i2c: Race fix for i2c-mpc.c
Message-Id: <20050522171828.0411332b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <0.20050518_204412.tnt@patchsend.246tNt.com>
In-Reply-To: <0.20050518_204412.tnt@patchsend.246tNt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sylvain,

> i2c: Race fix for i2c-mpc.c
> 
> The problem was that the clock speed and driver data is
> initialized after the i2c adapter was added. This caused
> the i2c bus to start working at a wrong speed. (Mostly
> noticable on the second bus on mpc5200)
> 
> With this patch we've tried to keep the i2c adapter
> working perfectly all the time it is included in the system.
> Initialize before added, Remove garbage after deleleted.

The patch looks sane to me. Adrian, no objection?

> --- linux-2.6/drivers/i2c/busses/i2c-mpc.c	2005-05-16 09:47:10.000000000 +0200
> +++ linux-2.6-mpc52xx/drivers/i2c/busses/i2c-mpc.c	2005-05-16 17:50:18.000000000 +0200
> @@ -333,6 +333,9 @@
>  	} else
>  		i2c->irq = 0;
>  
> +	mpc_i2c_setclock(i2c);
> +	ocp_set_drvdata(ocp, i2c);
> +
>  	i2c->adap = mpc_ops;
>  	i2c_set_adapdata(&i2c->adap, i2c);
>  
> @@ -341,8 +344,6 @@
>  		goto fail_add;
>  	}
>  
> -	mpc_i2c_setclock(i2c);
> -	ocp_set_drvdata(ocp, i2c);
>  	return result;
>  
>        fail_add:
> @@ -358,8 +359,8 @@
>  static void __devexit mpc_i2c_remove(struct ocp_device *ocp)
>  {
>  	struct mpc_i2c *i2c = ocp_get_drvdata(ocp);
> -	ocp_set_drvdata(ocp, NULL);
>  	i2c_del_adapter(&i2c->adap);
> +	ocp_set_drvdata(ocp, NULL);
>  
>  	if (ocp->def->irq != OCP_IRQ_NA)
>  		free_irq(i2c->irq, i2c);
> @@ -430,6 +431,9 @@
>  			goto fail_irq;
>  		}
>  
> +	mpc_i2c_setclock(i2c);
> +	dev_set_drvdata(device, i2c);
> +
>  	i2c->adap = mpc_ops;
>  	i2c_set_adapdata(&i2c->adap, i2c);
>  	i2c->adap.dev.parent = &pdev->dev;
> @@ -438,8 +442,6 @@
>  		goto fail_add;
>  	}
>  
> -	mpc_i2c_setclock(i2c);
> -	dev_set_drvdata(device, i2c);
>  	return result;
>  
>        fail_add:
> @@ -456,8 +458,8 @@
>  {
>  	struct mpc_i2c *i2c = dev_get_drvdata(device);
>  
> -	dev_set_drvdata(device, NULL);
>  	i2c_del_adapter(&i2c->adap);
> +	dev_set_drvdata(device, NULL);
>  
>  	if (i2c->irq != 0)
>  		free_irq(i2c->irq, i2c);
> 


-- 
Jean Delvare
