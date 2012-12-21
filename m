From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 21 Dec 2012 01:33:55 +0000
Subject: Re: [lm-sensors] [PATCH RFC 3/3] hwmon: (coretemp) Report package power end energy consumption
Message-Id: <20121221013355.GA31690@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1355984976-1033-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1355984976-1033-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, Dec 19, 2012 at 10:29:36PM -0800, Guenter Roeck wrote:
> Supported by SandyBridge and newer CPUs.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Tbd:	- labels
> 	- do we want to report other power/energy attributes (cores/dram/gpu) ?
> 	  - if yes - how [ does not fit numbering model ]
>=20
This is working quite nicely. After about one day of runtime on an i7-2600:

coretemp-isa-0000
Adapter: ISA adapter
Physical id 0:  +29.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)
Core 0:         +18.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)
Core 1:         +23.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)
Core 2:         +29.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)
Core 3:         +24.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)
Pkg 0 power:     3.29 W  (max =3D 120.00 W, cap =3D 118.75 W)
Pkg 0 energy:    4.04 MJ

>  Documentation/hwmon/coretemp |    6 ++
>  drivers/hwmon/coretemp.c     |  192 ++++++++++++++++++++++++++++++++++++=
+++++-
>  2 files changed, 195 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/hwmon/coretemp b/Documentation/hwmon/coretemp
> index fec5a9b..fdbd111 100644
> --- a/Documentation/hwmon/coretemp
> +++ b/Documentation/hwmon/coretemp
> @@ -43,6 +43,12 @@ tempX_crit_alarm - Set when Out-of-spec bit is set, ne=
ver clears.
>  tempX_label	 - Contains string "Core X", where X is processor
>  		   number. For Package temp, this will be "Physical id Y",
>  		   where Y is the package number.
> +energyX_input	 - Package energy consumption since driver was loaded
> +powerX_cap	 - Package power limit
> +powerX_cap_max	 - Maximum value for powerX_cap
> +powerX_cap_min	 - Minimum value for powerX_cap
> +powerX_input	 - Package power consumption
> +powerX_max	 - Maximum package power
> =20
>  On CPU models which support it, TjMax is read from a model-specific regi=
ster.
>  On other models, it is set to an arbitrary value based on weak heuristic=
s.
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index 02ac401..63d6cff 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -54,7 +54,7 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius=
");
>  #define NUM_REAL_CORES		32	/* Number of Real cores per cpu */
>  #define CORETEMP_NAME_LENGTH	17	/* String Length of attrs */
>  #define MAX_CORE_ATTRS		4	/* Maximum no of basic attrs */
> -#define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
> +#define TOTAL_ATTRS		(MAX_CORE_ATTRS + 9)
>  #define MAX_CORE_DATA		(NUM_REAL_CORES + BASE_SYSFS_ATTR_NO)
> =20
>  #define TO_PHYS_ID(cpu)		(cpu_data(cpu).phys_proc_id)
> @@ -79,6 +79,15 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsiu=
s");
>   * @is_pkg_data: If this is true, the core_data holds pkgtemp data.
>   *		Otherwise, core_data holds coretemp data.
>   * @valid: If this is true, the current temperature is valid.
> + * @has_rapl:		true if the CPU supports RAPL (power measurement)
> + * @rapl_power_units:	Units of power as reported by the chip
> + * @rapl_energy_units:	Units of energy as reported by the chip
> + * @rapl_energy_raw:	Most recent energy measurement (raw)
> + * @rapl_energy:	cumulative energy (mJ)
> + * @rapl_power:		current power usage (mW)
> + * @rapl_power_max:	maximum power (mW) as reported by the chip
> + * @rapl_power_cap_min:	minimum power limit (mW) as reported by the chip
> + * @rapl_power_cap_max:	maximum power limit (mW) as reported by the chip
>   */
>  struct core_data {
>  	int temp;
> @@ -94,6 +103,17 @@ struct core_data {
>  	struct sensor_device_attribute sd_attrs[TOTAL_ATTRS];
>  	char attr_name[TOTAL_ATTRS][CORETEMP_NAME_LENGTH];
>  	struct mutex update_lock;
> +	/* power values */
> +	bool has_rapl;
> +	u32 rapl_power_units;
> +	u32 rapl_energy_units;
> +	u32 rapl_energy_raw;
> +	u64 rapl_energy;
> +	u32 rapl_power;
> +	u32 rapl_power_max;
> +	u32 rapl_power_cap_min;
> +	u32 rapl_power_cap_max;
> +	struct delayed_work rapl_wq;
>  };
> =20
>  /* Platform Data per Physical CPU */
> @@ -132,6 +152,26 @@ static ssize_t show_label(struct device *dev,
>  	return sprintf(buf, "Core %u\n", tdata->cpu_core_id);
>  }
> =20
> +static ssize_t show_power_label(struct device *dev,
> +				struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> +	struct platform_data *pdata =3D dev_get_drvdata(dev);
> +	struct core_data *tdata =3D pdata->core_data[attr->index];
> +
> +	return sprintf(buf, "Pkg %u power\n", tdata->cpu_core_id);
> +}
> +
> +static ssize_t show_energy_label(struct device *dev,
> +				 struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> +	struct platform_data *pdata =3D dev_get_drvdata(dev);
> +	struct core_data *tdata =3D pdata->core_data[attr->index];
> +
> +	return sprintf(buf, "Pkg %u energy\n", tdata->cpu_core_id);
> +}
> +
>  static ssize_t show_crit_alarm(struct device *dev,
>  				struct device_attribute *devattr, char *buf)
>  {
> @@ -190,6 +230,73 @@ static ssize_t show_temp(struct device *dev,
>  	return tdata->valid ? sprintf(buf, "%d\n", tdata->temp) : -EAGAIN;
>  }
> =20
> +static ssize_t show_power(struct device *dev,
> +			  struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> +	struct platform_data *pdata =3D dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%u\n",
> +		       pdata->core_data[attr->index]->rapl_power * 1000);
> +}
> +
> +static ssize_t show_power_max(struct device *dev,
> +			      struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> +	struct platform_data *pdata =3D dev_get_drvdata(dev);
> +	struct core_data *tdata =3D pdata->core_data[attr->index];
> +
> +	return sprintf(buf, "%u\n", tdata->rapl_power_max * 1000);
> +}
> +
> +static ssize_t show_power_cap(struct device *dev,
> +			      struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> +	struct platform_data *pdata =3D dev_get_drvdata(dev);
> +	struct core_data *tdata =3D pdata->core_data[attr->index];
> +	u32 cap1, cap2, eax, edx;
> +	u64 cap;
> +
> +	rdmsr_on_cpu(tdata->cpu, MSR_PKG_POWER_LIMIT, &eax, &edx);
> +	cap1 =3D (eax & 0x8000) ? (eax & 0x7fff) : 0;
> +	cap2 =3D (edx & 0x8000) ? (edx & 0x7fff) : 0;
> +	cap =3D max(cap1, cap2) * 1000000LL / (1 << tdata->rapl_power_units);
> +
> +	return sprintf(buf, "%llu\n", cap);
> +}
> +
> +static ssize_t show_power_cap_min(struct device *dev,
> +				  struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> +	struct platform_data *pdata =3D dev_get_drvdata(dev);
> +	struct core_data *tdata =3D pdata->core_data[attr->index];
> +
> +	return sprintf(buf, "%u\n", tdata->rapl_power_cap_min * 1000);
> +}
> +
> +static ssize_t show_power_cap_max(struct device *dev,
> +				  struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> +	struct platform_data *pdata =3D dev_get_drvdata(dev);
> +	struct core_data *tdata =3D pdata->core_data[attr->index];
> +
> +	return sprintf(buf, "%u\n", tdata->rapl_power_cap_max * 1000);
> +}
> +
> +static ssize_t show_energy(struct device *dev,
> +			   struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> +	struct platform_data *pdata =3D dev_get_drvdata(dev);
> +	struct core_data *tdata =3D pdata->core_data[attr->index];
> +
> +	return sprintf(buf, "%llu\n", tdata->rapl_energy * 1000ULL);
> +}
> +
>  struct tjmax {
>  	char const *id;
>  	int tjmax;
> @@ -374,11 +481,17 @@ static int __cpuinit create_core_attrs(struct core_=
data *tdata,
>  	static ssize_t (*const rd_ptr[TOTAL_ATTRS]) (struct device *dev,
>  			struct device_attribute *devattr, char *buf) =3D {
>  			show_label, show_crit_alarm, show_temp, show_tjmax,
> -			show_ttarget };
> +			show_ttarget, show_power_label, show_power,
> +			show_power_max, show_power_cap, show_power_cap_min,
> +			show_power_cap_max, show_energy_label, show_energy };
>  	static const char *const names[TOTAL_ATTRS] =3D {
>  					"temp%d_label", "temp%d_crit_alarm",
>  					"temp%d_input", "temp%d_crit",
> -					"temp%d_max" };
> +					"temp%d_max", "power%d_label",
> +					"power%d_input", "power%d_max",
> +					"power%d_cap", "power%d_cap_min",
> +					"power%d_cap_max", "energy%d_label",
> +					"energy%d_input" };
> =20
>  	for (i =3D 0; i < tdata->attr_size; i++) {
>  		snprintf(tdata->attr_name[i], CORETEMP_NAME_LENGTH, names[i],
> @@ -454,6 +567,70 @@ static struct core_data __cpuinit *init_core_data(un=
signed int cpu,
>  	return tdata;
>  }
> =20
> +static u32 coretemp_delta_wrap(u32 new, u32 old)
> +{
> +	if (new > old)
> +		return new - old;
> +	return 0x100000000LL + new - old;
> +}
> +
> +static void coretemp_rapl_work(struct work_struct *work)
> +{
> +	struct core_data *tdata =3D container_of(work, struct core_data,
> +					       rapl_wq.work);
> +	u32 eax, edx;
> +	u32 delta;
> +	u32 power;
> +
> +	rdmsr_on_cpu(tdata->cpu, MSR_PKG_ENERGY_STATUS, &eax, &edx);
> +	delta =3D coretemp_delta_wrap(eax, tdata->rapl_energy_raw);
> +	tdata->rapl_energy_raw =3D eax;
> +
> +	power =3D delta * 1000LL / (1 << tdata->rapl_energy_units);
> +	tdata->rapl_power =3D power;
> +	tdata->rapl_energy +=3D power;
> +
> +	pr_info("cpu %d: energy=3D%llu mJ power=3D%u mW\n",
> +		tdata->cpu,
> +		tdata->rapl_energy, tdata->rapl_power);
> +
> +	schedule_delayed_work(&tdata->rapl_wq, HZ);
> +}
> +
> +static void coretemp_init_rapl(struct platform_device *pdev,
> +			       int cpu, struct core_data *tdata)
> +{
> +	u32 eax, edx;
> +	int err;
> +
> +	/* Test if we can access rapl registers */
> +	err =3D rdmsr_safe_on_cpu(cpu, MSR_RAPL_POWER_UNIT, &eax, &edx);
> +	if (err)
> +		return;
> +
> +	tdata->rapl_power_units =3D eax & 0x000f;
> +	tdata->rapl_energy_units =3D (eax >> 8) & 0x001f;
> +
> +	err =3D rdmsr_safe_on_cpu(cpu, MSR_PKG_POWER_INFO, &eax, &edx);
> +	if (err)
> +		return;
> +
> +	tdata->rapl_power_cap_min =3D
> +	  ((eax >> 16) & 0x7fff) * 1000 / (1 << tdata->rapl_power_units);
> +
> +	tdata->rapl_power_cap_max =3D tdata->rapl_power_max =3D
> +	  (edx & 0x7fff) * 1000 / (1 << tdata->rapl_power_units);
> +
> +	rdmsr_on_cpu(tdata->cpu, MSR_PKG_ENERGY_STATUS, &eax, &edx);
> +	tdata->rapl_energy_raw =3D eax;
> +	tdata->rapl_energy =3D eax * 1000LL / (1 << tdata->rapl_energy_units);
> +
> +	INIT_DELAYED_WORK(&tdata->rapl_wq, coretemp_rapl_work);
> +
> +	tdata->has_rapl =3D true;
> +	tdata->attr_size +=3D 8;
> +}
> +
>  static int __cpuinit create_core_data(struct platform_device *pdev,
>  				unsigned int cpu, bool pkg_flag)
>  {
> @@ -511,6 +688,9 @@ static int __cpuinit create_core_data(struct platform=
_device *pdev,
>  		}
>  	}
> =20
> +	if (pkg_flag)
> +		coretemp_init_rapl(pdev, cpu, tdata);
> +
>  	pdata->core_data[attr_no] =3D tdata;
> =20
>  	/* Create sysfs interfaces */
> @@ -518,6 +698,9 @@ static int __cpuinit create_core_data(struct platform=
_device *pdev,
>  	if (err)
>  		goto exit_free;
> =20
> +	if (tdata->has_rapl)
> +		schedule_delayed_work(&tdata->rapl_wq, HZ);
> +
>  	return 0;
>  exit_free:
>  	pdata->core_data[attr_no] =3D NULL;
> @@ -544,6 +727,9 @@ static void coretemp_remove_core(struct platform_data=
 *pdata,
>  	int i;
>  	struct core_data *tdata =3D pdata->core_data[indx];
> =20
> +	if (tdata->has_rapl)
> +		cancel_delayed_work(&tdata->rapl_wq);
> +
>  	/* Remove the sysfs attributes */
>  	for (i =3D 0; i < tdata->attr_size; i++)
>  		device_remove_file(dev, &tdata->sd_attrs[i].dev_attr);
> --=20
> 1.7.9.7
>=20
>=20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
