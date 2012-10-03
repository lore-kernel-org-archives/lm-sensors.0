From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 03 Oct 2012 04:48:54 +0000
Subject: Re: [lm-sensors] [PATCH v4 1/2] hwmon: (ads7828) driver cleanup
Message-Id: <20121003044854.GA7491@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1349235207-7517-1-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1349235207-7517-1-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, Steve Hardy <shardy@redhat.com>

On Tue, Oct 02, 2012 at 11:33:26PM -0400, Vivien Didelot wrote:
> * Remove module parameters, add a ads7828_platform_data;
> * Move driver declaration to avoid adding function prototypes;
> * Remove unused macros;
> * Coding Style fixes.
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Hi Vivien,

nice cleanup.

One more comment below. No need to re-send; I'll fix that and apply the patch to
-next.

Guenter

[ ... ]

>  /* Return 0 if detection is successful, -ENODEV otherwise */
>  static int ads7828_detect(struct i2c_client *client,
>  			  struct i2c_board_info *info)
>  {
>  	struct i2c_adapter *adapter = client->adapter;
> +	u8 default_cmd_byte = ADS7828_CMD_SD_SE | ADS7828_CMD_PD3;
>  	int ch;
>  
>  	/* Check we have a valid client */
> @@ -195,9 +161,12 @@ static int ads7828_detect(struct i2c_client *client,
>  	 * - Check the top 4 bits of each result are not set (12 data bits)
>  	 */
>  	for (ch = 0; ch < ADS7828_NCH; ch++) {
> -		u16 in_data;
> -		u8 cmd = channel_cmd_byte(ch);
> -		in_data = i2c_smbus_read_word_swapped(client, cmd);
> +		u8 cmd = ads7828_cmd_byte(default_cmd_byte, ch);
> +		u16 in_data = i2c_smbus_read_word_swapped(client, cmd);

s/u16/int/

Otherwise in_data can never be < 0.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
