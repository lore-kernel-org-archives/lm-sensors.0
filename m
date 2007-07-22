From: Gabriel C <nix.or.die@googlemail.com>
Date: Sun, 22 Jul 2007 11:03:33 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add missing __devexit tags in
Message-Id: <46A33985.4060007@googlemail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <46A28920.9060704@googlemail.com> <20070722120948.0609d79b@hyperion.delvare>
In-Reply-To: <20070722120948.0609d79b@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mhoffman@lightlink.com, lm-sensors@lm-sensors.org

Jean Delvare wrote:
> On Sun, 22 Jul 2007 00:30:56 +0200, Gabriel C wrote:
>> I noticed this warnings on current git:
>>
>> drivers/hwmon/pc87360.c:1082: warning: 'pc87360_remove' defined but not used
>> drivers/hwmon/sis5595.c:580: warning: 'sis5595_remove' defined but not used
>> drivers/hwmon/smsc47m1.c:608: warning: 'smsc47m1_remove' defined but not used
>> drivers/hwmon/via686a.c:648: warning: 'via686a_remove' defined but not used
>> drivers/hwmon/vt8231.c:755: warning: 'vt8231_remove' defined but not used


Thx , the patch fixes all this warnings.


> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/it87.c     |    2 +-
>  drivers/hwmon/pc87360.c  |    2 +-
>  drivers/hwmon/sis5595.c  |    2 +-
>  drivers/hwmon/smsc47m1.c |    2 +-
>  drivers/hwmon/via686a.c  |    2 +-
>  drivers/hwmon/vt8231.c   |    4 ++--
>  drivers/hwmon/w83627hf.c |    2 +-
>  7 files changed, 8 insertions(+), 8 deletions(-)
> 
> --- linux-2.6.23-pre.orig/drivers/hwmon/it87.c	2007-07-22 11:51:47.000000000 +0200
> +++ linux-2.6.23-pre/drivers/hwmon/it87.c	2007-07-22 11:56:48.000000000 +0200
> @@ -252,7 +252,7 @@ struct it87_data {
>  
>  
>  static int it87_probe(struct platform_device *pdev);
> -static int it87_remove(struct platform_device *pdev);
> +static int __devexit it87_remove(struct platform_device *pdev);
>  
>  static int it87_read_value(struct it87_data *data, u8 reg);
>  static void it87_write_value(struct it87_data *data, u8 reg, u8 value);
> --- linux-2.6.23-pre.orig/drivers/hwmon/pc87360.c	2007-07-22 09:54:08.000000000 +0200
> +++ linux-2.6.23-pre/drivers/hwmon/pc87360.c	2007-07-22 11:56:48.000000000 +0200
> @@ -220,7 +220,7 @@ struct pc87360_data {
>   */
>  
>  static int pc87360_probe(struct platform_device *pdev);
> -static int pc87360_remove(struct platform_device *pdev);
> +static int __devexit pc87360_remove(struct platform_device *pdev);
>  
>  static int pc87360_read_value(struct pc87360_data *data, u8 ldi, u8 bank,
>  			      u8 reg);
> --- linux-2.6.23-pre.orig/drivers/hwmon/sis5595.c	2007-07-22 09:54:08.000000000 +0200
> +++ linux-2.6.23-pre/drivers/hwmon/sis5595.c	2007-07-22 11:56:48.000000000 +0200
> @@ -187,7 +187,7 @@ struct sis5595_data {
>  static struct pci_dev *s_bridge;	/* pointer to the (only) sis5595 */
>  
>  static int sis5595_probe(struct platform_device *pdev);
> -static int sis5595_remove(struct platform_device *pdev);
> +static int __devexit sis5595_remove(struct platform_device *pdev);
>  
>  static int sis5595_read_value(struct sis5595_data *data, u8 reg);
>  static void sis5595_write_value(struct sis5595_data *data, u8 reg, u8 value);
> --- linux-2.6.23-pre.orig/drivers/hwmon/smsc47m1.c	2007-07-22 09:54:08.000000000 +0200
> +++ linux-2.6.23-pre/drivers/hwmon/smsc47m1.c	2007-07-22 11:56:48.000000000 +0200
> @@ -134,7 +134,7 @@ struct smsc47m1_sio_data {
>  
>  
>  static int smsc47m1_probe(struct platform_device *pdev);
> -static int smsc47m1_remove(struct platform_device *pdev);
> +static int __devexit smsc47m1_remove(struct platform_device *pdev);
>  static struct smsc47m1_data *smsc47m1_update_device(struct device *dev,
>  		int init);
>  
> --- linux-2.6.23-pre.orig/drivers/hwmon/via686a.c	2007-07-22 09:54:08.000000000 +0200
> +++ linux-2.6.23-pre/drivers/hwmon/via686a.c	2007-07-22 11:56:48.000000000 +0200
> @@ -314,7 +314,7 @@ struct via686a_data {
>  static struct pci_dev *s_bridge;	/* pointer to the (only) via686a */
>  
>  static int via686a_probe(struct platform_device *pdev);
> -static int via686a_remove(struct platform_device *pdev);
> +static int __devexit via686a_remove(struct platform_device *pdev);
>  
>  static inline int via686a_read_value(struct via686a_data *data, u8 reg)
>  {
> --- linux-2.6.23-pre.orig/drivers/hwmon/vt8231.c	2007-07-22 09:54:08.000000000 +0200
> +++ linux-2.6.23-pre/drivers/hwmon/vt8231.c	2007-07-22 11:56:48.000000000 +0200
> @@ -167,7 +167,7 @@ struct vt8231_data {
>  
>  static struct pci_dev *s_bridge;
>  static int vt8231_probe(struct platform_device *pdev);
> -static int vt8231_remove(struct platform_device *pdev);
> +static int __devexit vt8231_remove(struct platform_device *pdev);
>  static struct vt8231_data *vt8231_update_device(struct device *dev);
>  static void vt8231_init_device(struct vt8231_data *data);
>  
> @@ -751,7 +751,7 @@ exit_release:
>  	return err;
>  }
>  
> -static int vt8231_remove(struct platform_device *pdev)
> +static int __devexit vt8231_remove(struct platform_device *pdev)
>  {
>  	struct vt8231_data *data = platform_get_drvdata(pdev);
>  	int i;
> --- linux-2.6.23-pre.orig/drivers/hwmon/w83627hf.c	2007-07-22 11:51:49.000000000 +0200
> +++ linux-2.6.23-pre/drivers/hwmon/w83627hf.c	2007-07-22 11:56:48.000000000 +0200
> @@ -384,7 +384,7 @@ struct w83627hf_sio_data {
>  
>  
>  static int w83627hf_probe(struct platform_device *pdev);
> -static int w83627hf_remove(struct platform_device *pdev);
> +static int __devexit w83627hf_remove(struct platform_device *pdev);
>  
>  static int w83627hf_read_value(struct w83627hf_data *data, u16 reg);
>  static int w83627hf_write_value(struct w83627hf_data *data, u16 reg, u16 value);
> 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
