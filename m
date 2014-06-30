From: Luca Tettamanti <kronos.it@gmail.com>
Date: Mon, 30 Jun 2014 13:34:31 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] fs: asus_atk0110: Fix DEFINE_SIMPLE_ATTRIBUTE semicolon definition and 
Message-Id: <CAKPcRGpKuGsGvZ--3oVFGEpWwBg3RajAVzr3Hiz3bcmdbZR2=w@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1403999769.git.joe@perches.com>
	<530fc2e19919f12996227b27645be7e8f911a7ba.1403999769.git.joe@perches.com>
In-Reply-To: <530fc2e19919f12996227b27645be7e8f911a7ba.1403999769.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Jeff Layton <jlayton@poochiereds.net>, "J. Bruce Fields" <bfields@fieldses.org>, LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org

On Sun, Jun 29, 2014 at 1:20 AM, Joe Perches <joe@perches.com> wrote:
> The DEFINE_SIMPLE_ATTRIBUTE macro should not end in a ;
> Fix the one use in the kernel tree that did not have a semicolon.
>
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Luca Tettamanti <kronos.it@gmail.com>

For my driver only ;-)

Luca

> ---
>  drivers/hwmon/asus_atk0110.c | 2 +-
>  include/linux/fs.h           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
> index ae208f6..cccef87 100644
> --- a/drivers/hwmon/asus_atk0110.c
> +++ b/drivers/hwmon/asus_atk0110.c
> @@ -688,7 +688,7 @@ static int atk_debugfs_gitm_get(void *p, u64 *val)
>  DEFINE_SIMPLE_ATTRIBUTE(atk_debugfs_gitm,
>                         atk_debugfs_gitm_get,
>                         NULL,
> -                       "0x%08llx\n")
> +                       "0x%08llx\n");
>
>  static int atk_acpi_print(char *buf, size_t sz, union acpi_object *obj)
>  {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 8a9e7f8..e78e9ac 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2701,7 +2701,7 @@ static const struct file_operations __fops = {                            \
>         .read    = simple_attr_read,                                    \
>         .write   = simple_attr_write,                                   \
>         .llseek  = generic_file_llseek,                                 \
> -};
> +}
>
>  static inline __printf(1, 2)
>  void __simple_attr_check_format(const char *fmt, ...)
> --
> 1.8.1.2.459.gbcd45b4.dirty
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
