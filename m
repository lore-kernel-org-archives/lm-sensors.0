From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 24 Sep 2010 20:27:31 +0000
Subject: Re: [lm-sensors] [2/2] lis3: Set device owner
Message-Id: <20100924202731.GA20908@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <f7f75208147a0655eda1ac402f07e98d745fc178.1282647258.git.ext-yuri.kululin@nokia.com>
In-Reply-To: <f7f75208147a0655eda1ac402f07e98d745fc178.1282647258.git.ext-yuri.kululin@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yuri Ershov <ext-yuri.ershov@nokia.com>
Cc: eric.piel@tremplin-utc.net, samu.p.onkalo@nokia.com, akpm@linux-foundation.org, daniel@caiaq.de, ext-yuri.kululin@nokia.com, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Fri, Aug 27, 2010 at 02:33:21PM -0000, Yuri Ershov wrote:
> Set device owner for i2c part.
> 
> Signed-off-by: Yuri Kululin <ext-yuri.kululin@nokia.com>
> 
> ---
> drivers/hwmon/lis3lv02d_i2c.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hwmon/lis3lv02d_i2c.c b/drivers/hwmon/lis3lv02d_i2c.c
> index b2f8bae..1a55bb3 100644
> --- a/drivers/hwmon/lis3lv02d_i2c.c
> +++ b/drivers/hwmon/lis3lv02d_i2c.c
> @@ -129,6 +129,7 @@ static int __devinit lis3lv02d_i2c_probe(struct i2c_client *client,
>  	lis3_dev.reg_ctrl = lis3_reg_ctrl;
>  	lis3_dev.irq	  = client->irq;
>  	lis3_dev.ac	  = lis3lv02d_axis_map;
> +	lis3_dev.owner	  = THIS_MODULE;
>  
>  	i2c_set_clientdata(client, &lis3_dev);
>  
> @@ -149,6 +150,7 @@ static int __devexit lis3lv02d_i2c_remove(struct i2c_client *client)
>  
>  	lis3lv02d_joystick_disable();
>  	lis3lv02d_remove_fs(&lis3_dev);
> +	lis3_dev.owner = NULL;
>  
Should not be necessary, since you are about to unload the driver.
Unless I am missing something, of course.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
