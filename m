From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Date: Sat, 27 Jun 2015 11:34:30 +0000
Subject: Re: [lm-sensors] [PATCH v3 2/2] hwmon: Allow to compile dell-smm-hwmon driver without /proc/i8k
Message-Id: <3228158.O80YglnvCi@xps13>
List-Id: <lm-sensors.vger.kernel.org>
References: <20150428123850.GA8855@kroah.com> <1430307686-1734-1-git-send-email-pali.rohar@gmail.com> <1430307686-1734-2-git-send-email-pali.rohar@gmail.com>
In-Reply-To: <1430307686-1734-2-git-send-email-pali.rohar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>, Jean Delvare <jdelvare@suse.de>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Pali,

I've just noticed an issue with this patch. See the comment here below.

Gabriele

On Wednesday 29 April 2015 13:41:26 Pali Roh=E1r wrote:
> This patch splits CONFIG_I8K compile option to SENSORS_DELL_SMM and CONFI=
G_I8K.
> Option SENSORS_DELL_SMM is now used to enable compilation of dell-smm-hwm=
on
> driver and old CONFIG_I8K option to enable /proc/i8k interface in driver.
>=20
> So this change allows to compile dell-smm-hwmon driver without legacy /pr=
oc/i8k
> interface which is needed only for old Dell Inspirion models or for users=
pace
> i8kutils package.
>=20
> For backward compatibility when CONFIG_I8K is enabled then also SENSORS_D=
ELL_SMM
> is enabled and so driver dell-smm-hwmon (with /proc/i8k) is compiled.
>=20
> Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>
> ---
>  arch/x86/Kconfig               |   25 +++----
>  drivers/hwmon/Kconfig          |   11 +++
>  drivers/hwmon/Makefile         |    2 +-
>  drivers/hwmon/dell-smm-hwmon.c |  150 ++++++++++++++++++++++------------=
------
>  4 files changed, 106 insertions(+), 82 deletions(-)
>=20
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 226d569..7b756b3 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1055,24 +1055,19 @@ config TOSHIBA
>  	  Say N otherwise.
> =20
>  config I8K
> -	tristate "Dell laptop support"
> +	tristate "Dell i8k legacy laptop support"
>  	select HWMON
> +	select SENSORS_DELL_SMM
>  	---help---
> -	  This adds a driver to safely access the System Management Mode
> -	  of the CPU on the Dell Inspiron 8000. The System Management Mode
> -	  is used to read cpu temperature and cooling fan status and to
> -	  control the fans on the I8K portables.
> +	  This option enables legacy /proc/i8k userspace interface in hwmon
> +	  dell-smm-hwmon driver. Character file /proc/i8k reports bios version,
> +	  temperature and allows controlling fan speeds of Dell laptops via
> +	  System Management Mode. For old Dell laptops (like Dell Inspiron 8000)
> +	  it reports also power and hotkey status. For fan speed control is
> +	  needed userspace package i8kutils.
> =20
> -	  This driver has been tested only on the Inspiron 8000 but it may
> -	  also work with other Dell laptops. You can force loading on other
> -	  models by passing the parameter `force=3D1' to the module. Use at
> -	  your own risk.
> -
> -	  For information on utilities to make use of this driver see the
> -	  I8K Linux utilities web site at:
> -	  <http://people.debian.org/~dz/i8k/>
> -
> -	  Say Y if you intend to run this kernel on a Dell Inspiron 8000.
> +	  Say Y if you intend to run this kernel on old Dell laptops or want to
> +	  use userspace package i8kutils.
>  	  Say N otherwise.
> =20
>  config X86_REBOOTFIXUPS
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 25d9e72..714f92a 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -371,6 +371,17 @@ config SENSORS_DS1621
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called ds1621.
> =20
> +config SENSORS_DELL_SMM
> +	tristate "Dell laptop SMM BIOS hwmon driver"
> +	depends on X86 && DMI
> +	help
> +	  This hwmon driver adds support for reporting temperature of different
> +	  sensors and controls the fans on Dell laptops via System Management
> +	  Mode provided by Dell BIOS.
> +
> +	  When option I8K is also enabled this driver provides legacy /proc/i8k
> +	  userspace interface for i8kutils package.
> +
>  config SENSORS_DA9052_ADC
>  	tristate "Dialog DA9052/DA9053 ADC"
>  	depends on PMIC_DA9052
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 51533ac..6cacd0f 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -49,6 +49,7 @@ obj-$(CONFIG_SENSORS_ATXP1)	+=3D atxp1.o
>  obj-$(CONFIG_SENSORS_CORETEMP)	+=3D coretemp.o
>  obj-$(CONFIG_SENSORS_DA9052_ADC)+=3D da9052-hwmon.o
>  obj-$(CONFIG_SENSORS_DA9055)+=3D da9055-hwmon.o
> +obj-$(CONFIG_SENSORS_DELL_SMM)	+=3D dell-smm-hwmon.o
>  obj-$(CONFIG_SENSORS_DME1737)	+=3D dme1737.o
>  obj-$(CONFIG_SENSORS_DS620)	+=3D ds620.o
>  obj-$(CONFIG_SENSORS_DS1621)	+=3D ds1621.o
> @@ -156,7 +157,6 @@ obj-$(CONFIG_SENSORS_W83L785TS)	+=3D w83l785ts.o
>  obj-$(CONFIG_SENSORS_W83L786NG)	+=3D w83l786ng.o
>  obj-$(CONFIG_SENSORS_WM831X)	+=3D wm831x-hwmon.o
>  obj-$(CONFIG_SENSORS_WM8350)	+=3D wm8350-hwmon.o
> -obj-$(CONFIG_I8K)		+=3D dell-smm-hwmon.o
> =20
>  obj-$(CONFIG_PMBUS)		+=3D pmbus/
> =20
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmo=
n.c
> index 65d314b..2a80882 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -81,7 +81,7 @@ static uint i8k_fan_max =3D I8K_FAN_HIGH;
> =20
>  MODULE_AUTHOR("Massimo Dal Zotto (dz@debian.org)");
>  MODULE_AUTHOR("Pali Roh=E1r <pali.rohar@gmail.com>");
> -MODULE_DESCRIPTION("Driver for accessing SMM BIOS on Dell laptops");
> +MODULE_DESCRIPTION("Dell laptop SMM BIOS hwmon driver");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS("i8k");
> =20
> @@ -93,6 +93,7 @@ static bool ignore_dmi;
>  module_param(ignore_dmi, bool, 0);
>  MODULE_PARM_DESC(ignore_dmi, "Continue probing hardware even if DMI data=
 does not match");
> =20
> +#if IS_ENABLED(CONFIG_I8K)
>  static bool restricted;
>  module_param(restricted, bool, 0);
>  MODULE_PARM_DESC(restricted, "Allow fan control if SYS_ADMIN capability =
set");
> @@ -100,6 +101,7 @@ MODULE_PARM_DESC(restricted, "Allow fan control if SY=
S_ADMIN capability set");
>  static bool power_status;
>  module_param(power_status, bool, 0600);
>  MODULE_PARM_DESC(power_status, "Report power status in /proc/i8k");
> +#endif
> =20
>  static uint fan_mult;
>  module_param(fan_mult, uint, 0);
> @@ -109,18 +111,6 @@ static uint fan_max;
>  module_param(fan_max, uint, 0);
>  MODULE_PARM_DESC(fan_max, "Maximum configurable fan speed (default: auto=
detect)");
> =20
> -static int i8k_open_fs(struct inode *inode, struct file *file);
> -static long i8k_ioctl(struct file *, unsigned int, unsigned long);
> -
> -static const struct file_operations i8k_fops =3D {
> -	.owner		=3D THIS_MODULE,
> -	.open		=3D i8k_open_fs,
> -	.read		=3D seq_read,
> -	.llseek		=3D seq_lseek,
> -	.release	=3D single_release,
> -	.unlocked_ioctl	=3D i8k_ioctl,
> -};
> -
>  struct smm_regs {
>  	unsigned int eax;
>  	unsigned int ebx __packed;
> @@ -221,45 +211,6 @@ out:
>  }
> =20
>  /*
> - * Read the Fn key status.
> - */
> -static int i8k_get_fn_status(void)
> -{
> -	struct smm_regs regs =3D { .eax =3D I8K_SMM_FN_STATUS, };
> -	int rc;
> -
> -	rc =3D i8k_smm(&regs);
> -	if (rc < 0)
> -		return rc;
> -
> -	switch ((regs.eax >> I8K_FN_SHIFT) & I8K_FN_MASK) {
> -	case I8K_FN_UP:
> -		return I8K_VOL_UP;
> -	case I8K_FN_DOWN:
> -		return I8K_VOL_DOWN;
> -	case I8K_FN_MUTE:
> -		return I8K_VOL_MUTE;
> -	default:
> -		return 0;
> -	}
> -}
> -
> -/*
> - * Read the power status.
> - */
> -static int i8k_get_power_status(void)
> -{
> -	struct smm_regs regs =3D { .eax =3D I8K_SMM_POWER_STATUS, };
> -	int rc;
> -
> -	rc =3D i8k_smm(&regs);
> -	if (rc < 0)
> -		return rc;
> -
> -	return (regs.eax & 0xff) =3D=3D I8K_POWER_AC ? I8K_AC : I8K_BATTERY;
> -}
> -
> -/*
>   * Read the fan status.
>   */
>  static int i8k_get_fan_status(int fan)
> @@ -378,6 +329,51 @@ static int i8k_get_dell_signature(int req_fn)
>  	return regs.eax =3D=3D 1145651527 && regs.edx =3D=3D 1145392204 ? 0 : -=
1;
>  }
> =20
> +#if IS_ENABLED(CONFIG_I8K)
> +
> +/*
> + * Read the Fn key status.
> + */
> +static int i8k_get_fn_status(void)
> +{
> +	struct smm_regs regs =3D { .eax =3D I8K_SMM_FN_STATUS, };
> +	int rc;
> +
> +	rc =3D i8k_smm(&regs);
> +	if (rc < 0)
> +		return rc;
> +
> +	switch ((regs.eax >> I8K_FN_SHIFT) & I8K_FN_MASK) {
> +	case I8K_FN_UP:
> +		return I8K_VOL_UP;
> +	case I8K_FN_DOWN:
> +		return I8K_VOL_DOWN;
> +	case I8K_FN_MUTE:
> +		return I8K_VOL_MUTE;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +/*
> + * Read the power status.
> + */
> +static int i8k_get_power_status(void)
> +{
> +	struct smm_regs regs =3D { .eax =3D I8K_SMM_POWER_STATUS, };
> +	int rc;
> +
> +	rc =3D i8k_smm(&regs);
> +	if (rc < 0)
> +		return rc;
> +
> +	return (regs.eax & 0xff) =3D=3D I8K_POWER_AC ? I8K_AC : I8K_BATTERY;
> +}
> +
> +/*
> + * Procfs interface
> + */
> +
>  static int
>  i8k_ioctl_unlocked(struct file *fp, unsigned int cmd, unsigned long arg)
>  {
> @@ -528,6 +524,37 @@ static int i8k_open_fs(struct inode *inode, struct f=
ile *file)
>  	return single_open(file, i8k_proc_show, NULL);
>  }
> =20
> +static const struct file_operations i8k_fops =3D {
> +	.owner		=3D THIS_MODULE,
> +	.open		=3D i8k_open_fs,
> +	.read		=3D seq_read,
> +	.llseek		=3D seq_lseek,
> +	.release	=3D single_release,
> +	.unlocked_ioctl	=3D i8k_ioctl,
> +};
> +
> +static void __init i8k_init_procfs(void)
> +{
> +	/* Register the proc entry */
> +	proc_create("i8k", 0, NULL, &i8k_fops);
> +}
> +
> +static void __exit i8k_exit_procfs(void)
> +{
> +	remove_proc_entry("i8k", NULL);
> +}
> +
> +#else
> +
> +static inline void __init i8k_init_procfs(void)
> +{
> +}
> +
> +static inline void __exit i8k_exit_procfs(void)
> +{
> +}
> +
> +#endif
> =20
>  /*
>   * Hwmon interface
> @@ -750,8 +777,8 @@ static int __init i8k_init_hwmon(void)
>  	if (err >=3D 0)
>  		i8k_hwmon_flags |=3D I8K_HWMON_HAVE_FAN2;
> =20
> -	i8k_hwmon_dev =3D hwmon_device_register_with_groups(NULL, "i8k", NULL,
> -							  i8k_groups);
> +	i8k_hwmon_dev =3D hwmon_device_register_with_groups(NULL, "dell-smm",
> +							  NULL, i8k_groups);

dell-smm is not a valid name, see hwmon_device_register_with_groups() for
more info (dash not allowed). Because of this, the driver can't be loaded.

>  	if (IS_ERR(i8k_hwmon_dev)) {
>  		err =3D PTR_ERR(i8k_hwmon_dev);
>  		i8k_hwmon_dev =3D NULL;
> @@ -976,33 +1003,24 @@ static int __init i8k_probe(void)
> =20
>  static int __init i8k_init(void)
>  {
> -	struct proc_dir_entry *proc_i8k;
>  	int err;
> =20
>  	/* Are we running on an supported laptop? */
>  	if (i8k_probe())
>  		return -ENODEV;
> =20
> -	/* Register the proc entry */
> -	proc_i8k =3D proc_create("i8k", 0, NULL, &i8k_fops);
> -	if (!proc_i8k)
> -		return -ENOENT;
> -
>  	err =3D i8k_init_hwmon();
>  	if (err)
> -		goto exit_remove_proc;
> +		return err;
> =20
> +	i8k_init_procfs();
>  	return 0;
> -
> - exit_remove_proc:
> -	remove_proc_entry("i8k", NULL);
> -	return err;
>  }
> =20
>  static void __exit i8k_exit(void)
>  {
>  	hwmon_device_unregister(i8k_hwmon_dev);
> -	remove_proc_entry("i8k", NULL);
> +	i8k_exit_procfs();
>  }
> =20
>  module_init(i8k_init);
>=20


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
