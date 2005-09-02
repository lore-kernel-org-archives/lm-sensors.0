From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 02 Sep 2005 21:26:12 +0000
Subject: [lm-sensors] [PATCH 2.6.13-mm1] i2c: bug fix for
Message-Id: <20050902212547.21f0057c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050902010549.GD10106@mag.az.mvista.com>
In-Reply-To: <20050902010549.GD10106@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

> When an i2c transfer is successful, an incorrect value may be
> returned. This patch fixes that.

I would make this "is returned", as I can't think of a non-degenerated
successful case where a correct value would be returned.

> diff -Nur linux-2.6.13-mm1/drivers/i2c/busses/i2c-mv64xxx.c linux-2.6.13-mm1-mag/drivers/i2c/busses/i2c-mv64xxx.c
> --- linux-2.6.13-mm1/drivers/i2c/busses/i2c-mv64xxx.c	2005-09-01 16:26:21.000000000 -0700
> +++ linux-2.6.13-mm1-mag/drivers/i2c/busses/i2c-mv64xxx.c	2005-09-01 17:00:58.000000000 -0700
> @@ -429,7 +429,7 @@
>  		if ((rc = mv64xxx_i2c_execute_msg(drv_data, &msgs[i])) != 0)
>  			break;
>  
> -	return rc;
> +	return (rc < 0) ? rc : num;
>  }
>  
>  static struct i2c_algorithm mv64xxx_i2c_algo = {

Looks less than optimal to me. What about:

When an i2c transfer is successful, an incorrect value is returned.
This patch fixes that.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/busses/i2c-mv64xxx.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.13.orig/drivers/i2c/busses/i2c-mv64xxx.c	2005-09-02 20:44:25.000000000 +0200
+++ linux-2.6.13/drivers/i2c/busses/i2c-mv64xxx.c	2005-09-02 20:49:16.000000000 +0200
@@ -423,13 +423,13 @@
 mv64xxx_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 {
 	struct mv64xxx_i2c_data *drv_data = i2c_get_adapdata(adap);
-	int	i, rc = 0;
+	int	i, rc;
 
 	for (i=0; i<num; i++)
-		if ((rc = mv64xxx_i2c_execute_msg(drv_data, &msgs[i])) != 0)
-			break;
+		if ((rc = mv64xxx_i2c_execute_msg(drv_data, &msgs[i])) < 0)
+			return rc;
 
-	return rc;
+	return num;
 }
 
 static struct i2c_algorithm mv64xxx_i2c_algo = {


Note that the change from "!= 0" to "< 0" is purely for safety, as
mv64xxx_i2c_execute_msg is not supposed to return stricly positive
values anyway.

I found that i2c-algo-sgi is incorrect and returns 0 on success too.
I'll send a patch.

Also, i2c-algo-ite is too broken to comment on but is certainly not
correct; is anyone really using this thing?

As a last note, I really wonder why this strange return convention was
chosen in the first place. I can't think of a case where maxter_xfer
would transfer less messages that it was asked to, and would still not
want to return an error.

Thanks,
-- 
Jean Delvare
