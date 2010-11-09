From: Sean MacLennan <smaclennan@pikatech.com>
Date: Tue, 09 Nov 2010 02:41:42 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ad7414) Return proper error code
Message-Id: <20101108214142.6e2556ac@lappy.seanm.ca>
List-Id: <lm-sensors.vger.kernel.org>
References: <1289266834.14461.3.camel@mola>
In-Reply-To: <1289266834.14461.3.camel@mola>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org

On Mon, 8 Nov 2010 20:40:34 -0500
"Axel Lin" <axel.lin@gmail.com> wrote:

> [PATCH] hwmon: (ad7414) Return proper error code for ad7414_probe()
> 
> Return proper error if i2c_check_functionality reports
> the adapter does not support the capability we need.
> 
> Also remove unneeded initialization for err variable.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: Sean MacLennan <smaclennan@pikatech.com>

> ---
>  drivers/hwmon/ad7414.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/ad7414.c b/drivers/hwmon/ad7414.c
> index 1e4c21f..86d822a 100644
> --- a/drivers/hwmon/ad7414.c
> +++ b/drivers/hwmon/ad7414.c
> @@ -178,11 +178,13 @@ static int ad7414_probe(struct i2c_client
> *client, {
>         struct ad7414_data *data;
>         int conf;
> -       int err = 0;
> +       int err;

I wouldn't mind if this was "int conf, err;", but I don't mind the way
it is.

Cheers,
   Sean

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
