From: "J, KEERTHY" <j-keerthy@ti.com>
Date: Tue, 06 Sep 2011 17:53:18 +0000
Subject: Re: [lm-sensors] [PATCH 6/6 V4] hwmon: OMAP4: On die temperature
Message-Id: <CAJ6a13bmwwGLyYs3X-znp1SNTWmEZ2mwrEFrmhgSSHT=W4N1cA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314811510-15595-1-git-send-email-j-keerthy@ti.com>
	<1314811510-15595-7-git-send-email-j-keerthy@ti.com>
	<alpine.DEB.2.00.1108311810280.26173@utopia.booyaka.com>
In-Reply-To: <alpine.DEB.2.00.1108311810280.26173@utopia.booyaka.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org

On Thu, Sep 1, 2011 at 6:06 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> Some comments.
>
> On Wed, 31 Aug 2011, Keerthy wrote:
>
>> diff --git a/drivers/hwmon/omap_temp_sensor.c b/drivers/hwmon/omap_temp_=
sensor.c
>> new file mode 100644
>> index 0000000..67fa424
>> --- /dev/null
>> +++ b/drivers/hwmon/omap_temp_sensor.c
>> @@ -0,0 +1,881 @@
>
> You've done almost all the hard work to create kerneldoc-NANO compliant
> structure documentation, which is good. =A0But a few important things are
> missing. =A0Please review Documentation/kernel-doc-nano-HOWTO.txt.

Ok

>
>> +/*
>
> Should be /** to indicate kerneldoc.

Ok

>
>> + * omap_temp_sensor structure
>
> Should be "struct omap_temp_sensor" and should include a short
> description.

Ok

>
>> + * @hwmon_dev - hwmon device pointer
>> + * @pdev_dev - platform device pointer
>> + * @clock - Clock pointer
>> + * @registers - Pointer to structure with register offsets and bitfields
>> + * @sensor_mutex - Mutex for sysfs, irq and PM
>> + * @irq - MPU Irq number for thermal alert
>> + * @phy_base - Physical base of the temp I/O
>> + * @clk_rate - Holds current clock rate
>> + * @temp_sensor_ctrl - temp sensor control register value
>> + * @bg_ctrl - bandgap ctrl register value
>> + * @bg_counter - bandgap counter value
>> + * @bg_threshold - bandgap threshold register value
>> + * @temp_sensor_tshut_threshold - bandgap tshut register value
>> + * @clk_on - Manages the current clock state
>> + */
>
>> +struct omap_temp_sensor {
>> + =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 *hwmon_dev;
>> + =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 *pdev_dev;
>> + =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*clock;
>> + =A0 =A0 struct omap_temp_sensor_registers *registers;
>> + =A0 =A0 struct mutex =A0 =A0 =A0 =A0 =A0 =A0sensor_mutex; /* Mutex for=
 sysfs, irq and PM */
>> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0irq;
>> + =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*phy_base;
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_rate;
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor_ctrl;
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bg_ctrl;
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bg_counter;
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bg_threshold;
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor_tshut_=
threshold;
>> + =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_on;
>> +};
>> +
>> +/*
>> + * Temperature values in milli degree celsius
>> + * ADC code values from 530 to 923
>> + */
>> +static int adc_to_temp[394] =3D {
>> + =A0 =A0 -40000, -40000, -40000, -40000, -39800, -39400, -39000, -38600=
, -38200,
>> + =A0 =A0 -37800, -37300, -36800, -36400, -36000, -35600, -35200, -34800,
>> + =A0 =A0 -34300, -33800, -33400, -33000, -32600, -32200, -31800, -31300,
>> + =A0 =A0 -30800, -30400, -30000, -29600, -29200, -28700, -28200, -27800,
>> + =A0 =A0 -27400, -27000, -26600, -26200, -25700, -25200, -24800, -24400,
>> + =A0 =A0 -24000, -23600, -23200, -22700, -22200, -21800, -21400, -21000,
>> + =A0 =A0 -20600, -20200, -19700, -19200, -18800, -18400, -18000, -17600,
>> + =A0 =A0 -17200, -16700, -16200, -15800, -15400, -15000, -14600, -14200,
>> + =A0 =A0 -13700, -13200, -12800, -12400, -12000, -11600, -11200, -10700,
>> + =A0 =A0 -10200, -9800, -9400, -9000, -8600, -8200, -7700, -7200, -6800,
>> + =A0 =A0 -6400, -6000, -5600, -5200, -4800, -4300, -3800, -3400, -3000,
>> + =A0 =A0 -2600, -2200, -1800, -1300, -800, -400, 0, 400, 800, 1200, 160=
0,
>> + =A0 =A0 2100, 2600, 3000, 3400, 3800, 4200, 4600, 5100, 5600, 6000, 64=
00,
>> + =A0 =A0 6800, 7200, 7600, 8000, 8500, 9000, 9400, 9800, 10200, 10600, =
11000,
>> + =A0 =A0 11400, 11900, 12400, 12800, 13200, 13600, 14000, 14400, 14800,
>> + =A0 =A0 15300, 15800, 16200, 16600, 17000, 17400, 17800, 18200, 18700,
>> + =A0 =A0 19200, 19600, 20000, 20400, 20800, 21200, 21600, 22100, 22600,
>> + =A0 =A0 23000, 23400, 23800, 24200, 24600, 25000, 25400, 25900, 26400,
>> + =A0 =A0 26800, 27200, 27600, 28000, 28400, 28800, 29300, 29800, 30200,
>> + =A0 =A0 30600, 31000, 31400, 31800, 32200, 32600, 33100, 33600, 34000,
>> + =A0 =A0 34400, 34800, 35200, 35600, 36000, 36400, 36800, 37300, 37800,
>> + =A0 =A0 38200, 38600, 39000, 39400, 39800, 40200, 40600, 41100, 41600,
>> + =A0 =A0 42000, 42400, 42800, 43200, 43600, 44000, 44400, 44800, 45300,
>> + =A0 =A0 45800, 46200, 46600, 47000, 47400, 47800, 48200, 48600, 49000,
>> + =A0 =A0 49500, 50000, 50400, 50800, 51200, 51600, 52000, 52400, 52800,
>> + =A0 =A0 53200, 53700, 54200, 54600, 55000, 55400, 55800, 56200, 56600,
>> + =A0 =A0 57000, 57400, 57800, 58200, 58700, 59200, 59600, 60000, 60400,
>> + =A0 =A0 60800, 61200, 61600, 62000, 62400, 62800, 63300, 63800, 64200,
>> + =A0 =A0 64600, 65000, 65400, 65800, 66200, 66600, 67000, 67400, 67800,
>> + =A0 =A0 68200, 68700, 69200, 69600, 70000, 70400, 70800, 71200, 71600,
>> + =A0 =A0 72000, 72400, 72800, 73200, 73600, 74100, 74600, 75000, 75400,
>> + =A0 =A0 75800, 76200, 76600, 77000, 77400, 77800, 78200, 78600, 79000,
>> + =A0 =A0 79400, 79800, 80300, 80800, 81200, 81600, 82000, 82400, 82800,
>> + =A0 =A0 83200, 83600, 84000, 84400, 84800, 85200, 85600, 86000, 86400,
>> + =A0 =A0 86800, 87300, 87800, 88200, 88600, 89000, 89400, 89800, 90200,
>> + =A0 =A0 90600, 91000, 91400, 91800, 92200, 92600, 93000, 93400, 93800,
>> + =A0 =A0 94200, 94600, 95000, 95500, 96000, 96400, 96800, 97200, 97600,
>> + =A0 =A0 98000, 98400, 98800, 99200, 99600, 100000, 100400, 100800, 101=
200,
>> + =A0 =A0 101600, 102000, 102400, 102800, 103200, 103600, 104000, 104400,
>> + =A0 =A0 104800, 105200, 105600, 106100, 106600, 107000, 107400, 107800,
>> + =A0 =A0 108200, 108600, 109000, 109400, 109800, 110200, 110600, 111000,
>> + =A0 =A0 111400, 111800, 112200, 112600, 113000, 113400, 113800, 114200,
>> + =A0 =A0 114600, 115000, 115400, 115800, 116200, 116600, 117000, 117400,
>> + =A0 =A0 117800, 118200, 118600, 119000, 119400, 119800, 120200, 120600,
>> + =A0 =A0 121000, 121400, 121800, 122200, 122600, 123000
>> +};
>> +
>> +static unsigned long omap_temp_sensor_readl(struct omap_temp_sensor
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 *temp_sensor, u32 reg)
>> +{
>> + =A0 =A0 return __raw_readl(temp_sensor->phy_base + reg);
>> +}
>> +
>> +static void omap_temp_sensor_writel(struct omap_temp_sensor *temp_senso=
r,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 va=
l, u32 reg)
>> +{
>> + =A0 =A0 __raw_writel(val, temp_sensor->phy_base + reg);
>> +}
>
> These are all SCM register accesses and need to go through a SCM driver.

Accessing SCM registers using ctrl_ functions?

>
>> +
>> +static int adc_to_temp_conversion(int adc_val)
>> +{
>> + =A0 =A0 return adc_to_temp[adc_val - OMAP_ADC_START_VALUE];
>> +}
>> +
>> +static int temp_to_adc_conversion(long temp)
>> +{
>> + =A0 =A0 int high, low, mid;
>> +
>> + =A0 =A0 if (temp < adc_to_temp[0] ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp > adc_to_temp[OMAP_ADC_END_VALUE - OMAP_A=
DC_START_VALUE])
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 high =3D OMAP_ADC_END_VALUE - OMAP_ADC_START_VALUE;
>> + =A0 =A0 low =3D 0;
>> + =A0 =A0 mid =3D (high + low) / 2;
>> +
>> + =A0 =A0 while (low < high) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (temp < adc_to_temp[mid])
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 high =3D mid - 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 low =3D mid + 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 mid =3D (low + high) / 2;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return OMAP_ADC_START_VALUE + low;
>> +}
>> +
>> +static void omap_configure_temp_sensor_counter(struct omap_temp_sensor
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0*temp_sensor, u32 counter)
>
> It doesn't seem necessary to include 'omap' in all these static function =
names.
>

Ok

>> +{
>> + =A0 =A0 u32 val;
>> +
>> + =A0 =A0 val =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_c=
ounter);
>> + =A0 =A0 val &=3D ~temp_sensor->registers->counter_mask;
>> + =A0 =A0 val |=3D counter << __ffs(temp_sensor->registers->counter_mask=
);
>> + =A0 =A0 omap_temp_sensor_writel(temp_sensor, val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_c=
ounter);
>> +}
>> +
>> +static void omap_enable_continuous_mode(struct omap_temp_sensor *temp_s=
ensor)
>> +{
>> + =A0 =A0 u32 val;
>> +
>> + =A0 =A0 val =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_m=
ode_ctrl);
>> +
>> + =A0 =A0 val |=3D 1 << __ffs(temp_sensor->registers->mode_ctrl_mask);
>> +
>> + =A0 =A0 omap_temp_sensor_writel(temp_sensor, val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_m=
ode_ctrl);
>> +}
>> +
>> +static void omap_temp_sensor_unmask_interrupts(struct omap_temp_sensor
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 *temp_sensor, u8 hot, u8 cold)
>
> Your earlier static function names didn't include 'temp_sensor', but
> this one does. =A0I'd suggest picking a standard function naming scheme
> and sticking to it.

Ok

>
>> +{
>> + =A0 =A0 u32 reg_val;
>> +
>> + =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_m=
ask_ctrl);
>> + =A0 =A0 if (hot)
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers->mask_hot_=
mask;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val &=3D ~temp_sensor->registers->mask_hot=
_mask;
>> +
>> + =A0 =A0 if (cold)
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers->mask_cold=
_mask;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val &=3D ~temp_sensor->registers->mask_col=
d_mask;
>> +
>> + =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->r=
egisters->bgap_mask_ctrl);
>> +}
>> +
>> +static void add_hyst(int adc_val, int hyst_val, int *thresh_val)
>> +{
>> + =A0 =A0 int temp =3D adc_to_temp_conversion(adc_val);
>> +
>> + =A0 =A0 temp +=3D hyst_val;
>> +
>> + =A0 =A0 *thresh_val =3D temp_to_adc_conversion(temp);
>> +}
>> +
>> +static void omap_temp_sensor_configure_thresholds_mask(struct omap_temp=
_sensor
>> + =A0 =A0 *temp_sensor, bool set_hot, bool set_cold, int t_hot, int t_co=
ld)
>
> Is there some reason why you don't just define a
>
> omap_temp_sensor_configure_hot_threshold()
>
> and
>
> omap_temp_sensor_configure_cold_threshold()
>
> ?
>
> Seems like that would be much more straightforward and would allow the
> removal of those set_{hot,cold} arguments.

Kept everything in one function. I can split it into separate functions.

>
>> +{
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 reg_val, cold, hot, temp;
>
> This function is really big and should be split up into several smaller
> functions. =A0Common code should be shared if possible.

Ok

>
>> +
>> + =A0 =A0 if (set_hot) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* obtain the T cold value */
>> + =A0 =A0 =A0 =A0 =A0 =A0 cold =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_t=
hreshold);
>> + =A0 =A0 =A0 =A0 =A0 =A0 cold =3D (cold & temp_sensor->registers->thres=
hold_tcold_mask)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 >> __ffs(temp_sensor->register=
s->threshold_tcold_mask);
>
> This code should be hoisted up above the if statements. =A0Only a single
> device read should be necessary to fetch both the hot and cold values.
> Then the near-duplicate code below to read the hot temperature can be
> removed.
>
> In fact, given that this patch has almost the same code several times,
> you should just put it into a static function or two and remove the
> duplicate code.

Ok. I will remove the duplicate code.

>
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (t_hot < cold) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* change the t_cold to t_hot =
- 5000 millidegrees */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_hyst(t_hot, NEG_HYST_VAL, =
&cold);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* write the new t_cold value =
*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_r=
eadl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->r=
egisters->bgap_threshold);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val &>> + =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ~temp_sensor->registers->threshold_=
tcold_mask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D cold <<
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->registers->=
threshold_tcold_mask);
>
> Looks like there are some indentation problems here. =A0Those are more
> important than 80-column issues.
>

Ok

> Of course, you use temp_sensor->registers so much in this function, that
> many of the line length issues would go away if you used a shorter
> abbreviation at the beginning of this function, like:
>
> =A0 =A0 =A0tsr =3D temp_sensor->registers;

Sure. Makes the code look neat.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_s=
ensor, reg_val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_t=
hreshold);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 t_cold =3D cold;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* write the new t_hot value */
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_t=
hreshold);
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val &=3D ~temp_sensor->registers->threshol=
d_thot_mask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D (t_hot <<
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->registers->=
threshold_thot_mask));
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_t=
hreshold);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (set_cold) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* obtain the T HOT value */
>> + =A0 =A0 =A0 =A0 =A0 =A0 hot =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_t=
hreshold);
>> + =A0 =A0 =A0 =A0 =A0 =A0 hot =3D (hot & temp_sensor->registers->thresho=
ld_thot_mask) >>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__ffs(temp_sensor->register=
s->threshold_thot_mask);
>
> See the earlier comment about hoisting.

Ok

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (t_cold > hot) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* change the t_hot to t_cold =
+ 5000 millidegrees */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_hyst(t_cold, HYST_VAL, &ho=
t);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* write the new t_hot value */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_r=
eadl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->r=
egisters->bgap_threshold);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val &>> + =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ~temp_sensor->registers->threshold_=
thot_mask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D (hot <<
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->registers->=
threshold_thot_mask));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_s=
ensor, reg_val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->r=
egisters->bgap_threshold);
>
> This is a duplicate of earlier code. =A0Please consolidate.

Ok

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 t_hot =3D hot;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* write the new t_cold value */
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->r=
egisters->bgap_threshold);
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val &=3D ~temp_sensor->registers->threshol=
d_tcold_mask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D t_cold <<
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->registers->=
threshold_tcold_mask);
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_t=
hreshold);
>> + =A0 =A0 }
>> + =A0 =A0 =A0/* obtain the T cold value */
>> + =A0 =A0 cold =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_threshold);
>> + =A0 =A0 cold =3D (cold & temp_sensor->registers->threshold_tcold_mask)
>> + =A0 =A0 =A0 =A0 =A0 =A0 >> __ffs(temp_sensor->registers->threshold_tco=
ld_mask);
>> +
>> + =A0 =A0 /* obtain the T HOT value */
>> + =A0 =A0 hot =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_threshold);
>> + =A0 =A0 hot =3D (hot & temp_sensor->registers->threshold_thot_mask) >>
>> + =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->registers->threshold_thot_m=
ask);
>> +
>> + =A0 =A0 /* Read the current temperature */
>> + =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->temp_sensor_ctrl);
>> + =A0 =A0 temp &=3D temp_sensor->registers->bgap_dtemp_mask;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* If current temperature is in-between the hot and cold thr=
esholds
>> + =A0 =A0 =A0* Enable both masks or in the init case enable both masks
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if ((temp > cold && temp < hot) || (set_cold && set_hot))
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_unmask_interrupts(temp_sensor=
, 1, 1);
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* If user sets the HIGH threshold(t_hot) greater than the c=
urrent
>> + =A0 =A0 =A0* temperature(temp) unmask the HOT interrupts
>> + =A0 =A0 =A0*/
>> + =A0 =A0 else if (hot > temp)
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_unmask_interrupts(temp_sensor=
, 1, 0);
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* If user sets the LOW threshold(t_cold) lower than the cur=
rent
>> + =A0 =A0 =A0* temperature(temp) unmask the COLD interrupts
>> + =A0 =A0 =A0*/
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_unmask_interrupts(temp_sensor=
, 0, 1);
>
> This if statement is surely a violation of the spirit of
> Documentation/CodingStyle, if not the text itself.
>
> If you really need an if statement like this, try something like:
>
> =A0 =A0 if ((temp > cold && temp < hot) || (set_cold && set_hot)) {
> =A0 =A0 =A0 =A0 /*
> =A0 =A0 =A0 =A0 =A0* If current temperature is in-between the hot and col=
d thresholds
> =A0 =A0 =A0 =A0 =A0* Enable both masks or in the init case enable both ma=
sks
> =A0 =A0 =A0 =A0 =A0*/
>
> =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_unmask_interrupts(temp_sensor, 1=
, 1);
> =A0 =A0 } else if (hot > temp) {
> =A0 =A0 =A0 =A0 /*
> =A0 =A0 =A0 =A0 =A0* If user sets the HIGH threshold(t_hot) greater than =
the current
> =A0 =A0 =A0 =A0 =A0* temperature(temp) unmask the HOT interrupts
> =A0 =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_unmask_interrupts(temp_sensor, 1=
, 0);
> =A0 =A0 } else {
> =A0 =A0 =A0 =A0 /*
> =A0 =A0 =A0 =A0 =A0* If user sets the LOW threshold(t_cold) lower than th=
e current
> =A0 =A0 =A0 =A0 =A0* temperature(temp) unmask the COLD interrupts
> =A0 =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_unmask_interrupts(temp_sensor, 0=
, 1);
> =A0 =A0 }
>

Ok

>
>> +}
>> +
>> +/* Sysfs hook functions */
>
> These should be conditionally compiled out if sysfs isn't compiled in.
>
>> +
>> +static ssize_t show_temp_max(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *devat=
tr, char *buf)
>> +{
>> + =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(dev);
>> + =A0 =A0 int temp;
>> +
>> + =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_t=
hreshold);
>> + =A0 =A0 temp =3D (temp & temp_sensor->registers->threshold_thot_mask)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 >> __ffs(temp_sensor->register=
s->threshold_thot_mask);
>> + =A0 =A0 temp =3D adc_to_temp_conversion(temp);
>> +
>> + =A0 =A0 return snprintf(buf, 16, "%d\n", temp);
>> +}
>> +
>> +static ssize_t set_temp_max(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribut=
e *devattr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *buf, size_=
t count)
>> +{
>> + =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(dev);
>> + =A0 =A0 long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val;
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 t_hot;
>> +
>> + =A0 =A0 if (strict_strtol(buf, 10, &val))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 if (val < MIN_TEMP - HYST_VAL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 t_hot =3D temp_to_adc_conversion(val);
>> + =A0 =A0 if (t_hot < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return t_hot;
>> +
>> + =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> + =A0 =A0 omap_temp_sensor_configure_thresholds_mask(temp_sensor, 1, 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 t_hot, 0);
>> + =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> +
>> + =A0 =A0 return count;
>> +}
>> +
>> +static ssize_t show_temp_max_hyst(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *devattr, char *buf)
>> +{
>> + =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(dev);
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp;
>> +
>> + =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_threshold);
>> + =A0 =A0 temp =3D (temp & temp_sensor->registers->threshold_tcold_mask)=
 >>
>> + =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->registers->threshold_tcold_=
mask);
>> +
>> + =A0 =A0 if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_END_VALUE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "invalid value\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 temp =3D adc_to_temp_conversion(temp);
>> +
>> + =A0 =A0 return snprintf(buf, 16, "%d\n", temp);
>> +}
>> +
>> +static ssize_t set_temp_max_hyst(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct devi=
ce_attribute *devattr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char =
*buf, size_t count)
>> +{
>> + =A0 =A0 struct omap_temp_sensor =A0 =A0 =A0 =A0 *temp_sensor =3D dev_g=
et_drvdata(dev);
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 t_=
cold;
>> + =A0 =A0 long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0va=
l;
>> +
>> + =A0 =A0 if (strict_strtol(buf, 10, &val)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (val > MAX_TEMP - HYST_VAL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 t_cold =3D temp_to_adc_conversion(val);
>> + =A0 =A0 if (t_cold < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return t_cold;
>> +
>> +
>> + =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> + =A0 =A0 omap_temp_sensor_configure_thresholds_mask(temp_sensor, 0, 1, =
0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 t_cold);
>> + =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> +
>> +out:
>> + =A0 =A0 return count;
>> +}
>> +
>> +static ssize_t show_update_interval(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *devat=
tr, char *buf)
>> +{
>> + =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(dev);
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp;
>> +
>> + =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_c=
ounter);
>> + =A0 =A0 temp =3D (temp & temp_sensor->registers->counter_mask) >>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->registers->=
counter_mask);
>> + =A0 =A0 temp =3D temp * 1000 / temp_sensor->clk_rate;
>> +
>> + =A0 =A0 return sprintf(buf, "%d\n", temp);
>> +}
>> +
>> +static ssize_t set_update_interval(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device_a=
ttribute *devattr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *buf=
, size_t count)
>> +{
>> + =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(dev);
>> + =A0 =A0 long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val;
>> +
>> + =A0 =A0 if (strict_strtol(buf, 10, &val)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (val < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 val *=3D temp_sensor->clk_rate / 1000;
>> + =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> + =A0 =A0 omap_configure_temp_sensor_counter(temp_sensor, val);
>> + =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> +out:
>> + =A0 =A0 return count;
>> +}
>> +
>> +static int omap_temp_sensor_read_temp(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 st=
ruct device_attribute *devattr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ch=
ar *buf)
>> +{
>> + =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(dev);
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp;
>> +
>> + =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->temp_sensor_ctrl);
>> + =A0 =A0 temp &=3D temp_sensor->registers->bgap_dtemp_mask;
>> +
>> + =A0 =A0 /* look up for temperature in the table and return the tempera=
ture */
>> + =A0 =A0 if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_END_VALUE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>> +
>> + =A0 =A0 temp =3D adc_to_temp[temp - OMAP_ADC_START_VALUE];
>> +
>> + =A0 =A0 return sprintf(buf, "%d\n", temp);
>> +}
>> +
>> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, omap_temp_sensor_read_t=
emp,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL, 0);
>> +static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_temp_max, 0);
>> +static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO, show_temp_=
max_hyst,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_temp_max_hyst, 0);
>> +static SENSOR_DEVICE_ATTR(update_interval, S_IWUSR | S_IRUGO,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 show_update_interval, set_upda=
te_interval, 0);
>> +
>> +static struct attribute *omap_temp_sensor_attributes[] =3D {
>> + =A0 =A0 &sensor_dev_attr_temp1_input.dev_attr.attr,
>> + =A0 =A0 &sensor_dev_attr_temp1_max.dev_attr.attr,
>> + =A0 =A0 &sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
>> + =A0 =A0 &sensor_dev_attr_update_interval.dev_attr.attr,
>> + =A0 =A0 NULL
>> +};
>> +
>> +static const struct attribute_group omap_temp_sensor_group =3D {
>> + =A0 =A0 .attrs =3D omap_temp_sensor_attributes,
>> +};
>> +
>> +static int omap_temp_sensor_clk_enable(struct omap_temp_sensor *temp_se=
nsor)
>> +{
>> + =A0 =A0 u32 ret =3D 0;
>> +
>> + =A0 =A0 if (temp_sensor->clk_on) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->pdev_dev, "clock already =
on\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D pm_runtime_get_sync(temp_sensor->pdev_dev);
>> + =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->pdev_dev, "get sync faile=
d\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 temp_sensor->clk_on =3D 1;
>> +
>> +out:
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static void omap_temp_sensor_clk_disable(struct omap_temp_sensor *temp_=
sensor)
>> +{
>> + =A0 =A0 /* Gate the clock */
>> + =A0 =A0 pm_runtime_put_sync(temp_sensor->hwmon_dev);
>> + =A0 =A0 temp_sensor->clk_on =3D 0;
>> +}
>> +
>> +static irqreturn_t omap_talert_irq_handler(int irq, void *data)
>> +{
>> + =A0 =A0 struct omap_temp_sensor =A0 =A0 =A0 =A0 *temp_sensor;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 t_=
hot, t_cold, temp;
>> +
>> + =A0 =A0 temp_sensor =3D data;
>> + =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> + =A0 =A0 /* Read the status of t_hot */
>> + =A0 =A0 t_hot =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_s=
tatus)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & temp_sensor->registers->stat=
us_hot_mask;
>> +
>> + =A0 =A0 /* Read the status of t_cold */
>> + =A0 =A0 t_cold =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_s=
tatus)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & temp_sensor->registers->stat=
us_cold_mask;
>> +
>> + =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_m=
ask_ctrl);
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* One TALERT interrupt: Two sources
>> + =A0 =A0 =A0* If the interrupt is due to t_hot then mask t_hot and
>> + =A0 =A0 =A0* and unmask t_cold else mask t_cold and unmask t_hot
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (t_hot) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp &=3D ~temp_sensor->registers->mask_hot_ma=
sk;
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp |=3D temp_sensor->registers->mask_cold_ma=
sk;
>> + =A0 =A0 } else if (t_cold) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp &=3D ~temp_sensor->registers->mask_cold_m=
ask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp |=3D temp_sensor->registers->mask_hot_mas=
k;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 omap_temp_sensor_writel(temp_sensor, temp,
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_mask_ctrl);
>> +
>> + =A0 =A0 if (temp_sensor->hwmon_dev)
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* kobject_uvent to user space telling thresho=
ld crossed */
>> + =A0 =A0 =A0 =A0 =A0 =A0 kobject_uevent(&temp_sensor->hwmon_dev->kobj, =
KOBJ_CHANGE);
>> +
>> + =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> +
>> + =A0 =A0 return IRQ_HANDLED;
>> +}
>> +
>> +static int __devinit omap_temp_sensor_probe(struct platform_device *pde=
v)
>> +{
>> + =A0 =A0 struct omap_temp_sensor_pdata =A0 *pdata =A0=3D pdev->dev.plat=
form_data;
>> + =A0 =A0 struct omap_temp_sensor =A0 =A0 =A0 =A0 *temp_sensor;
>> + =A0 =A0 struct resource =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *mem;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 re=
t =3D 0;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cl=
k_rate;
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ma=
x_freq, min_freq;
>> +
>> + =A0 =A0 if (!pdata) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "platform data missing\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 temp_sensor =3D kzalloc(sizeof(*temp_sensor), GFP_KERNEL);
>> + =A0 =A0 if (!temp_sensor) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Memory allocation failed\=
n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 mutex_init(&temp_sensor->sensor_mutex);
>> +
>> + =A0 =A0 mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> + =A0 =A0 if (!mem) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no mem resource\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 temp_sensor->irq =3D platform_get_irq_byname(pdev, "thermal_al=
ert");
>> + =A0 =A0 if (temp_sensor->irq < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "get_irq_byname failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D temp_sensor->irq;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 temp_sensor->phy_base =3D ioremap(mem->start, resource_size(me=
m));
>> + =A0 =A0 if (!temp_sensor->phy_base) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "ioremap failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 temp_sensor->clock =3D NULL;
>> + =A0 =A0 temp_sensor->registers =3D pdata->registers;
>> + =A0 =A0 temp_sensor->pdev_dev =3D &pdev->dev;
>> +
>> + =A0 =A0 if (pdata->max_freq && pdata->min_freq) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D pdata->max_freq;
>> + =A0 =A0 =A0 =A0 =A0 =A0 min_freq =3D pdata->min_freq;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D MAX_FREQ;
>> + =A0 =A0 =A0 =A0 =A0 =A0 min_freq =3D MIN_FREQ;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 pm_runtime_enable(&pdev->dev);
>> + =A0 =A0 pm_runtime_irq_safe(&pdev->dev);
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* check if the efuse has a non-zero value if not
>> + =A0 =A0 =A0* it is an untrimmed sample and the temperatures
>> + =A0 =A0 =A0* may not be accurate
>> + =A0 =A0 =A0*/
>> +
>> + =A0 =A0 if (omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_e=
fuse))
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&pdev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Invalid EFUSE, Non-trimmed BG=
AP, Temp not accurate\n");
>> +
>> + =A0 =A0 dev_set_drvdata(&pdev->dev, temp_sensor);
>> + =A0 =A0 temp_sensor->clock =3D clk_get(&pdev->dev, "fck");
>> + =A0 =A0 if (IS_ERR(temp_sensor->clock)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(temp_sensor->clock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to get fclk: %d\n", re=
t);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D omap_temp_sensor_clk_enable(temp_sensor);
>> + =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto clken_err;
>> +
>> + =A0 =A0 clk_rate =3D clk_round_rate(temp_sensor->clock, max_freq);
>> + =A0 =A0 if (clk_rate < min_freq || clk_rate =3D 0xffffffff) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto clken_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D clk_set_rate(temp_sensor->clock, clk_rate);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Cannot set clock rate\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto clken_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 temp_sensor->clk_rate =3D clk_rate;
>> + =A0 =A0 omap_enable_continuous_mode(temp_sensor);
>> + =A0 =A0 /* 1 clk cycle */
>> + =A0 =A0 omap_configure_temp_sensor_counter(temp_sensor, 1);
>> +
>> + =A0 =A0 /* Wait till the first conversion is done wait for at least 1m=
s */
>> + =A0 =A0 usleep_range(1000, 2000);
>> +
>> + =A0 =A0 /* Read the temperature once due to hw issue*/
>> + =A0 =A0 omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->temp_s=
ensor_ctrl);
>> +
>> + =A0 =A0 /* Set 2 seconds time as default counter */
>> + =A0 =A0 omap_configure_temp_sensor_counter(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 temp_sensor->clk_rate * 2);
>> +
>> + =A0 =A0 ret =3D request_threaded_irq(temp_sensor->irq, NULL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_talert_irq_handler, IRQF_TRIGGER_RISING |=
 IRQF_ONESHOT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "temp_sensor", temp_sensor);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Request threaded irq fail=
ed.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto req_irq_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D sysfs_create_group(&pdev->dev.kobj, &omap_temp_sensor_=
group);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "could not create sysfs fi=
les\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto sysfs_create_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 temp_sensor->hwmon_dev =3D hwmon_device_register(&pdev->dev);
>> + =A0 =A0 if (IS_ERR(temp_sensor->hwmon_dev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "hwmon_device_register fai=
led.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(temp_sensor->hwmon_dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto hwmon_reg_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> + =A0 =A0 omap_temp_sensor_configure_thresholds_mask(temp_sensor, 1, 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 T_HOT, T_COLD);
>> + =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> +
>> + =A0 =A0 return 0;
>> +
>> +hwmon_reg_err:
>> + =A0 =A0 sysfs_remove_group(&temp_sensor->hwmon_dev->kobj,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &omap_temp_sen=
sor_group);
>> +sysfs_create_err:
>> + =A0 =A0 free_irq(temp_sensor->irq, temp_sensor);
>> +req_irq_err:
>> + =A0 =A0 omap_temp_sensor_clk_disable(temp_sensor);
>> +clken_err:
>> + =A0 =A0 clk_put(temp_sensor->clock);
>> + =A0 =A0 iounmap(temp_sensor->phy_base);
>> +plat_res_err:
>> + =A0 =A0 dev_set_drvdata(&pdev->dev, NULL);
>> + =A0 =A0 mutex_destroy(&temp_sensor->sensor_mutex);
>> + =A0 =A0 kfree(temp_sensor);
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static int __devexit omap_temp_sensor_remove(struct platform_device *pd=
ev)
>> +{
>> + =A0 =A0 struct omap_temp_sensor *temp_sensor =3D platform_get_drvdata(=
pdev);
>> +
>> + =A0 =A0 hwmon_device_unregister(&pdev->dev);
>> + =A0 =A0 sysfs_remove_group(&temp_sensor->hwmon_dev->kobj,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &omap_temp_sensor_group);
>> + =A0 =A0 free_irq(temp_sensor->irq, temp_sensor);
>> + =A0 =A0 omap_temp_sensor_clk_disable(temp_sensor);
>> + =A0 =A0 clk_put(temp_sensor->clock);
>> + =A0 =A0 iounmap(temp_sensor->phy_base);
>> + =A0 =A0 dev_set_drvdata(&pdev->dev, NULL);
>> + =A0 =A0 mutex_destroy(&temp_sensor->sensor_mutex);
>> + =A0 =A0 kfree(temp_sensor);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static void omap_temp_sensor_save_ctxt(struct omap_temp_sensor *temp_se=
nsor)
>> +{
>> + =A0 =A0 temp_sensor->temp_sensor_ctrl =3D omap_temp_sensor_readl(temp_=
sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->temp_sensor_ctrl);
>> + =A0 =A0 temp_sensor->bg_ctrl =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_mask_ctrl);
>> + =A0 =A0 temp_sensor->bg_counter =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_counter);
>> + =A0 =A0 temp_sensor->bg_threshold =3D omap_temp_sensor_readl(temp_sens=
or,
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_threshold);
>> + =A0 =A0 temp_sensor->temp_sensor_tshut_threshold >> + =A0 =A0 =A0 =A0 =
=A0 =A0 omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->thsut_threshold);
>> +}
>> +
>> +static void omap_temp_sensor_restore_ctxt(struct omap_temp_sensor *temp=
_sensor)
>> +{
>> + =A0 =A0 omap_temp_sensor_writel(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->t=
emp_sensor_ctrl,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->r=
egisters->temp_sensor_ctrl);
>> + =A0 =A0 omap_temp_sensor_writel(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->b=
g_ctrl,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->r=
egisters->bgap_mask_ctrl);
>> + =A0 =A0 omap_temp_sensor_writel(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->b=
g_counter,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->r=
egisters->bgap_counter);
>> + =A0 =A0 omap_temp_sensor_writel(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->b=
g_threshold,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->r=
egisters->bgap_threshold);
>> + =A0 =A0 omap_temp_sensor_writel(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->t=
emp_sensor_tshut_threshold,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->r=
egisters->thsut_threshold);
>> +}
>> +
>> +static int omap_temp_sensor_suspend(struct device *dev)
>> +{
>> + =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(dev);
>> +
>> + =A0 =A0 omap_temp_sensor_save_ctxt(temp_sensor);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int omap_temp_sensor_resume(struct device *dev)
>> +{
>> + =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(dev);
>> +
>> + =A0 =A0 omap_temp_sensor_restore_ctxt(temp_sensor);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int omap_temp_sensor_runtime_suspend(struct device *dev)
>> +{
>> + =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(dev);
>> +
>> + =A0 =A0 omap_temp_sensor_save_ctxt(temp_sensor);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int omap_temp_sensor_runtime_resume(struct device *dev)
>> +{
>> + =A0 =A0 static int context_loss_count;
>> + =A0 =A0 int temp;
>> + =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdata(dev);
>> +
>> + =A0 =A0 temp =3D omap_device_get_context_loss_count(to_platform_device=
(dev));
>> +
>> + =A0 =A0 if (temp !=3D context_loss_count && context_loss_count !=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_restore_ctxt(temp_sensor);
>> +
>> + =A0 =A0 context_loss_count =3D temp;
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int omap_temp_sensor_idle(struct device *dev)
>> +{
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static const struct dev_pm_ops omap_temp_sensor_dev_pm_ops =3D {
>> + =A0 =A0 SET_SYSTEM_SLEEP_PM_OPS(omap_temp_sensor_suspend,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_resume)
>> + =A0 =A0 SET_RUNTIME_PM_OPS(omap_temp_sensor_runtime_suspend,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_runtime_resum=
e, omap_temp_sensor_idle)
>> +};
>> +
>> +#define DEV_PM_OPS =A0 (&omap_temp_sensor_dev_pm_ops)
>> +#else
>> +#define DEV_PM_OPS =A0 NULL
>> +#endif
>> +
>> +static struct platform_driver omap_temp_sensor_driver =3D {
>> + =A0 =A0 .probe =3D omap_temp_sensor_probe,
>> + =A0 =A0 .remove =3D omap_temp_sensor_remove,
>> + =A0 =A0 .driver =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "omap_temp_sensor",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =3D DEV_PM_OPS,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
>> +};
>> +
>> +int __init omap_temp_sensor_init(void)
>> +{
>> + =A0 =A0 return platform_driver_register(&omap_temp_sensor_driver);
>> +}
>> +module_init(omap_temp_sensor_init);
>> +
>> +static void __exit omap_temp_sensor_exit(void)
>> +{
>> + =A0 =A0 platform_driver_unregister(&omap_temp_sensor_driver);
>> +}
>> +module_exit(omap_temp_sensor_exit);
>> +
>> +MODULE_DESCRIPTION("OMAP446X temperature sensor Driver");
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform:" DRIVER_NAME);
>> +MODULE_AUTHOR("J Keerthy <j-keerthy@ti.com>");
>> --
>> 1.7.0.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>
> - Paul
>



--=20
Regards and Thanks,
Keerthy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
