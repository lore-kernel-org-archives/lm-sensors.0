From: Marc Hulsman <m.hulsman@tudelft.nl>
Date: Wed, 21 Sep 2011 11:41:29 +0000
Subject: Re: [lm-sensors] [PATCH] drivers/hwmon/w83791d.c: rename prototype
Message-Id: <201109211341.30074.m.hulsman@tudelft.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1316068246-3275-1-git-send-email-cpeterso@cpeterso.com>
In-Reply-To: <1316068246-3275-1-git-send-email-cpeterso@cpeterso.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: kernel-janitors@vger.kernel.org

Hi Chris,

(lm-sensors CC-ed) 

On Thursday 15 September 2011 08:30:46 Chris Peterson wrote:
> gcc -Wextra warns "‘register’ is not at beginning of declaration" because
> the compiler thinks the parameter has been marked as a 'register'
> variable, but the function prototype intended to name the parameter
> "register" (which is a reserved keyword).
> 
> Signed-off-by: Chris Peterson <cpeterso@cpeterso.com>
> ---
>  drivers/hwmon/w83791d.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
> index 17cf1ab..8c2844e 100644
> --- a/drivers/hwmon/w83791d.c
> +++ b/drivers/hwmon/w83791d.c
> @@ -329,8 +329,8 @@ static int w83791d_detect(struct i2c_client *client,
>  			  struct i2c_board_info *info);
>  static int w83791d_remove(struct i2c_client *client);
> 
> -static int w83791d_read(struct i2c_client *client, u8 register);
> -static int w83791d_write(struct i2c_client *client, u8 register, u8 value);
> +static int w83791d_read(struct i2c_client *client, u8 reg);
> +static int w83791d_write(struct i2c_client *client, u8 reg, u8 value);
>  static struct w83791d_data *w83791d_update_device(struct device *dev);
> 
>  #ifdef DEBUG

Thanks! Patch looks (and works) fine. 

Acked-by: Marc Hulsman <m.hulsman@tudelft.nl>

Guenter or Jean, can you pick up this patch? Original mail was not posted to lm_sensors,
but can be found here: 
http://www.spinics.net/lists/linux-kernel-janitors/msg09690.html 
or see below for a copy of the patch without the >.

Cheers,
Marc


gcc -Wextra warns "‘register’ is not at beginning of declaration" because the
compiler thinks the parameter has been marked as a 'register' variable, but
the function prototype intended to name the parameter "register" (which is a
reserved keyword).

Signed-off-by: Chris Peterson <cpeterso@cpeterso.com>
---
 drivers/hwmon/w83791d.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
index 17cf1ab..8c2844e 100644
--- a/drivers/hwmon/w83791d.c
+++ b/drivers/hwmon/w83791d.c
@@ -329,8 +329,8 @@ static int w83791d_detect(struct i2c_client *client,
                          struct i2c_board_info *info);
 static int w83791d_remove(struct i2c_client *client);
 
-static int w83791d_read(struct i2c_client *client, u8 register);
-static int w83791d_write(struct i2c_client *client, u8 register, u8 value);
+static int w83791d_read(struct i2c_client *client, u8 reg);
+static int w83791d_write(struct i2c_client *client, u8 reg, u8 value);
 static struct w83791d_data *w83791d_update_device(struct device *dev);
 
 #ifdef DEBUG
-- 
1.7.4.1

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
