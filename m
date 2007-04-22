From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Sun, 22 Apr 2007 15:23:57 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/w83627ehf: Don't redefine
Message-Id: <4dfa50520704220823i14143cbahdf30de104ee55b5c@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, Andrew,

On 4/22/07, Jean Delvare <khali@linux-fr.org> wrote:
> On ia64, kernel headers define REGION_OFFSET so we can't use that.
> Reported by Andrew Morton.
>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: David Hubbard <david.c.hubbard@gmail.com>

If you would like to add a Signed-off-by for me, that would be fine. :-)

> ---
>  drivers/hwmon/w83627ehf.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> --- linux-2.6.21-rc7.orig/drivers/hwmon/w83627ehf.c     2007-04-21 22:18:56.000000000 +0200
> +++ linux-2.6.21-rc7/drivers/hwmon/w83627ehf.c  2007-04-22 11:11:43.000000000 +0200
> @@ -121,9 +121,9 @@ superio_exit(void)
>   * ISA constants
>   */
>
> -#define REGION_ALIGNMENT       ~7
> -#define REGION_OFFSET          5
> -#define REGION_LENGTH          2
> +#define IOREGION_ALIGNMENT     ~7
> +#define IOREGION_OFFSET                5
> +#define IOREGION_LENGTH                2
>  #define ADDR_REG_OFFSET                5
>  #define DATA_REG_OFFSET                6
>
> @@ -1194,7 +1194,7 @@ static int w83627ehf_detect(struct i2c_a
>         u8 fan4pin, fan5pin;
>         int i, err = 0;
>
> -       if (!request_region(address + REGION_OFFSET, REGION_LENGTH,
> +       if (!request_region(address + IOREGION_OFFSET, IOREGION_LENGTH,
>                             w83627ehf_driver.driver.name)) {
>                 err = -EBUSY;
>                 goto exit;
> @@ -1322,7 +1322,7 @@ exit_remove:
>  exit_free:
>         kfree(data);
>  exit_release:
> -       release_region(address + REGION_OFFSET, REGION_LENGTH);
> +       release_region(address + IOREGION_OFFSET, IOREGION_LENGTH);
>  exit:
>         return err;
>  }
> @@ -1337,7 +1337,7 @@ static int w83627ehf_detach_client(struc
>
>         if ((err = i2c_detach_client(client)))
>                 return err;
> -       release_region(client->addr + REGION_OFFSET, REGION_LENGTH);
> +       release_region(client->addr + IOREGION_OFFSET, IOREGION_LENGTH);
>         kfree(data);
>
>         return 0;
> @@ -1380,7 +1380,7 @@ static int __init w83627ehf_find(int sio
>         superio_select(W83627EHF_LD_HWM);
>         val = (superio_inb(SIO_REG_ADDR) << 8)
>             | superio_inb(SIO_REG_ADDR + 1);
> -       *addr = val & REGION_ALIGNMENT;
> +       *addr = val & IOREGION_ALIGNMENT;
>         if (*addr = 0) {
>                 superio_exit();
>                 return -ENODEV;
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
