From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 21 Jan 2012 07:13:34 +0000
Subject: Re: [lm-sensors] [PATCH 51/82] hwmon: (pc87360) Fix multi-line comments
Message-Id: <CAJfuBxzsX2py1ffuQYnZKZLvUXr9Cn12cUgxAH+X2e1x5BQoxw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327017376-20466-52-git-send-email-linux@roeck-us.net>
In-Reply-To: <1327017376-20466-52-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

are these checkpatch warnings ?

ackd-by: Jim Cromie <jim.cromie@gmail.com>

On Thu, Jan 19, 2012 at 4:55 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> Cc: Jim Cromie <jim.cromie@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> =A0drivers/hwmon/pc87360.c | =A0 73 +++++++++++++++++++++++++++++--------=
---------
> =A01 files changed, 46 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
> index 51c97ca..7f95761 100644
> --- a/drivers/hwmon/pc87360.c
> +++ b/drivers/hwmon/pc87360.c
> @@ -531,9 +531,11 @@ static struct sensor_device_attribute in_max[] =3D {
> =A0#define CHAN_ALM_MAX =A0 0x04 =A0 =A0/* max limit exceeded */
> =A0#define TEMP_ALM_CRIT =A00x08 =A0 =A0/* temp crit exceeded (temp only)=
 */
>
> -/* show_in_min/max_alarm() reads data from the per-channel status
> - =A0 register (sec 11.5.12), not the vin event status registers (sec
> - =A0 11.5.2) that (legacy) show_in_alarm() resds (via data->in_alarms) */
> +/*
> + * show_in_min/max_alarm() reads data from the per-channel status
> + * register (sec 11.5.12), not the vin event status registers (sec
> + * 11.5.2) that (legacy) show_in_alarm() resds (via data->in_alarms)
> + */
>
> =A0static ssize_t show_in_min_alarm(struct device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device_attribute *d=
evattr, char *buf)
> @@ -748,9 +750,10 @@ static ssize_t set_therm_crit(struct device *dev,
> =A0 =A0 =A0 =A0return count;
> =A0}
>
> -/* the +11 term below reflects the fact that VLM units 11,12,13 are
> - =A0 used in the chip to measure voltage across the thermistors
> -*/
> +/*
> + * the +11 term below reflects the fact that VLM units 11,12,13 are
> + * used in the chip to measure voltage across the thermistors
> + */
> =A0static struct sensor_device_attribute therm_input[] =3D {
> =A0 =A0 =A0 =A0SENSOR_ATTR(temp4_input, S_IRUGO, show_therm_input, NULL, =
0 + 11),
> =A0 =A0 =A0 =A0SENSOR_ATTR(temp5_input, S_IRUGO, show_therm_input, NULL, =
1 + 11),
> @@ -786,8 +789,10 @@ static struct sensor_device_attribute therm_crit[] =
=3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0show_therm_crit, set_therm_crit, 2=
 + 11),
> =A0};
>
> -/* show_therm_min/max_alarm() reads data from the per-channel voltage
> - =A0 status register (sec 11.5.12) */
> +/*
> + * show_therm_min/max_alarm() reads data from the per-channel voltage
> + * status register (sec 11.5.12)
> + */
>
> =A0static ssize_t show_therm_min_alarm(struct device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct dev=
ice_attribute *devattr, char *buf)
> @@ -1007,9 +1012,11 @@ static ssize_t show_temp_alarms(struct device *dev,
>
> =A0static DEVICE_ATTR(alarms_temp, S_IRUGO, show_temp_alarms, NULL);
>
> -/* show_temp_min/max_alarm() reads data from the per-channel status
> - =A0 register (sec 12.3.7), not the temp event status registers (sec
> - =A0 12.3.2) that show_temp_alarm() reads (via data->temp_alarms) */
> +/*
> + * show_temp_min/max_alarm() reads data from the per-channel status
> + * register (sec 12.3.7), not the temp event status registers (sec
> + * 12.3.2) that show_temp_alarm() reads (via data->temp_alarms)
> + */
>
> =A0static ssize_t show_temp_min_alarm(struct device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device_attribute *d=
evattr, char *buf)
> @@ -1172,9 +1179,11 @@ static int __init pc87360_find(int sioaddr, u8 *de=
vid,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else if (i =3D=3D 1) { /* Voltages */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Are we using thermistor=
s? */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (*devid =3D=3D 0xE9) { =
/* PC87366 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* These re=
gisters are not logical-device
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spec=
ific, just that we won't need them if
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0we d=
on't use the VLM device */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* These =
registers are not logical-device
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* specif=
ic, just that we won't need them if
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* we don=
't use the VLM device
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0confreg[2]=
 =3D superio_inb(sioaddr, 0x2B);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0confreg[3]=
 =3D superio_inb(sioaddr, 0x25);
>
> @@ -1258,9 +1267,11 @@ static int __devinit pc87360_probe(struct platform=
_device *pdev)
> =A0 =A0 =A0 =A0if (data->fannr)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->fan_conf =3D confreg[0] | (confreg[1=
] << 8);
>
> - =A0 =A0 =A0 /* Use the correct reference voltage
> - =A0 =A0 =A0 =A0 =A0Unless both the VLM and the TMS logical devices agre=
e to
> - =A0 =A0 =A0 =A0 =A0use an external Vref, the internal one is used. */
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Use the correct reference voltage
> + =A0 =A0 =A0 =A0* Unless both the VLM and the TMS logical devices agree =
to
> + =A0 =A0 =A0 =A0* use an external Vref, the internal one is used.
> + =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0if (data->innr) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i =3D pc87360_read_value(data, LD_IN, NO_B=
ANK,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 PC87365_REG_IN_CONFIG);
> @@ -1402,8 +1413,10 @@ static int __devexit pc87360_remove(struct platfor=
m_device *pdev)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -/* ldi is the logical device index
> - =A0 bank is for voltages and temperatures only */
> +/*
> + * ldi is the logical device index
> + * bank is for voltages and temperatures only
> + */
> =A0static int pc87360_read_value(struct pc87360_data *data, u8 ldi, u8 ba=
nk,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u8 reg)
> =A0{
> @@ -1474,8 +1487,10 @@ static void pc87360_init_device(struct platform_de=
vice *pdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /* We can't blindly trust the Super-I/O space configuration=
 bit,
> - =A0 =A0 =A0 =A0 =A0most BIOS won't set it properly */
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* We can't blindly trust the Super-I/O space configurati=
on bit,
> + =A0 =A0 =A0 =A0* most BIOS won't set it properly
> + =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0dev_dbg(&pdev->dev, "bios thermistors:%d\n", use_thermisto=
rs);
> =A0 =A0 =A0 =A0for (i =3D 11; i < data->innr; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D pc87360_read_value(data, LD_IN, i,
> @@ -1506,8 +1521,10 @@ static void pc87360_init_device(struct platform_de=
vice *pdev,
> =A0 =A0 =A0 =A0if (use_thermistors) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i =3D 11; i < data->innr; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (init >=3D init_in[i]) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* The pin =
may already be used by thermal
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0diod=
es */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* The pi=
n may already be used by thermal
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* diodes
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D pc=
87360_read_value(data, LD_TEMP,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0(i - 11) / 2, PC87365_REG_TEMP_STATUS);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (reg & =
CHAN_ENA) {
> @@ -1560,10 +1577,12 @@ static void pc87360_init_device(struct platform_d=
evice *pdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (init >=3D 2) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Chip config as document=
ed by National Semi. */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pc87360_write_value(data, =
LD_TEMP, 0xF, 0xA, 0x08);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* We voluntarily omit the =
bank here, in case the
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sequence itself matt=
ers. It shouldn't be a problem,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0since nobody else is=
 supposed to access the
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device at that point=
. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We voluntarily omit th=
e bank here, in case the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* sequence itself matter=
s. It shouldn't be a problem,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* since nobody else is s=
upposed to access the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* device at that point.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pc87360_write_value(data, =
LD_TEMP, NO_BANK, 0xB, 0x04);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pc87360_write_value(data, =
LD_TEMP, NO_BANK, 0xC, 0x35);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pc87360_write_value(data, =
LD_TEMP, NO_BANK, 0xD, 0x05);
> --
> 1.7.5.4
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
