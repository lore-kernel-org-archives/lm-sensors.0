From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 27 Jul 2006 18:20:53 +0000
Subject: [lm-sensors] [PATCH] atxp1: signed/unsigned char bug
Message-Id: <20060727202053.2e9e18e3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060724083118.GB6815@martell.zuzino.mipt.ru>
In-Reply-To: <20060724083118.GB6815@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alexey,

> vid_to_reg() can return -1 and char can be unsigned.

What does it take for char be unsigned? Never seen that.

> Signed-off-by: Alexey Dobriyan <adobriyan at gmail.com>
> ---
> 
>  drivers/hwmon/atxp1.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> --- a/drivers/hwmon/atxp1.c
> +++ b/drivers/hwmon/atxp1.c
> @@ -116,8 +116,7 @@ static ssize_t atxp1_storevcore(struct d
>  {
>  	struct atxp1_data *data;
>  	struct i2c_client *client;
> -	char vid;
> -	char cvid;
> +	int vid, cvid;
>  	unsigned int vcore;
>  
>  	client = to_i2c_client(dev);

Whatever, this looks better with ints, I agree. I'll take that patch,
unless Sebastian objects.

-- 
Jean Delvare

