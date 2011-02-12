From: Andrew Lutomirski <luto@mit.edu>
Date: Sat, 12 Feb 2011 03:09:23 +0000
Subject: Re: [lm-sensors] [PATCH v3 7/7] hwmon: (w83627ehf) Use 16 bit fan
Message-Id: <AANLkTi=FZwsRdJ6Ln_yf=G1YSK6ybN8zMB2Hv3DYjRR+@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297444832-10874-8-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1297444832-10874-8-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, Feb 11, 2011 at 12:20 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> Some of the chips supported by this driver have 13 bit or 16 bit fan count
> registers. This patch improves support for those registers, specifically =
for
> NCT6775F. With the changes in this patch, fan speed is reported correctly=
 even
> if the fan divider is set to a low value, which results in a fan speed re=
ading
> above 0xff.

I'm not convinced this works.  I have an NCT6775F (or at least the
driver says I do) and, with fan2_min =3D 0 or 100, I get fan2_div =3D 128.
 If I set fan2_min=1000, I get fan2_div =3D 8 but fan2_input reads 0.
Presumably a low divider should have worked if I really had 16 bits to
play with.

--Andy

>
> With this patch, the width of fan count registers is no longer used to de=
termine
> if the chip has fan divider register(s) or not. A dedicated flag is used =
instead
> to determine if this is the case.
>
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
> =A0drivers/hwmon/w83627ehf.c | =A0 86 +++++++++++++++++++++++++++++++----=
----------
> =A01 files changed, 59 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
> index a6616b7..473e052 100644
> --- a/drivers/hwmon/w83627ehf.c
> +++ b/drivers/hwmon/w83627ehf.c
> @@ -234,7 +234,7 @@ static const u16 NCT6775_REG_FAN_STOP_TIME[] =3D { 0x=
107, 0x207, 0x307 };
> =A0static const u16 NCT6775_REG_PWM[] =3D { 0x109, 0x209, 0x309 };
> =A0static const u16 NCT6775_REG_FAN_MAX_OUTPUT[] =3D { 0x10a, 0x20a, 0x30=
a };
> =A0static const u16 NCT6775_REG_FAN_STEP_OUTPUT[] =3D { 0x10b, 0x20b, 0x3=
0b };
> -static const u16 NCT6776_REG_FAN[] =3D { 0x630, 0x632, 0x634, 0x636, 0x6=
38 };
> +static const u16 NCT6775_REG_FAN[] =3D { 0x630, 0x632, 0x634, 0x636, 0x6=
38 };
> =A0static const u16 NCT6776_REG_FAN_MIN[] =3D { 0x63a, 0x63c, 0x63e, 0x64=
0, 0x642};
>
> =A0static const u16 NCT6775_REG_TEMP[]
> @@ -342,21 +342,36 @@ static inline u8 step_time_to_reg(unsigned int msec=
, u8 mode)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0(msec + 200) / 400), 1, 255);
> =A0}
>
> -static inline unsigned int
> -fan_from_reg(int reg, u16 val, unsigned int div)
> +static unsigned int fan_from_reg8(u16 reg, unsigned int divreg)
> =A0{
> - =A0 =A0 =A0 if (val =3D 0)
> + =A0 =A0 =A0 if (reg =3D 0 || reg =3D 255)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> - =A0 =A0 =A0 if (is_word_sized(reg)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((val & 0xff1f) =3D 0xff1f)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D (val & 0x1f) | ((val & 0xff00) >> 3=
);
> - =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (val =3D 255 || div =3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 val *=3D div;
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 return 1350000U / val;
> + =A0 =A0 =A0 return 1350000U / (reg << divreg);
> +}
> +
> +static unsigned int fan_from_reg13(u16 reg, unsigned int divreg)
> +{
> + =A0 =A0 =A0 if ((reg & 0xff1f) =3D 0xff1f)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 reg =3D (reg & 0x1f) | ((reg & 0xff00) >> 3);
> +
> + =A0 =A0 =A0 if (reg =3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 return 1350000U / reg;
> +}
> +
> +static unsigned int fan_from_reg16(u16 reg, unsigned int divreg)
> +{
> + =A0 =A0 =A0 if (reg =3D 0 || reg =3D 0xffff)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Even though the registers are 16 bit wide, the fan div=
isor
> + =A0 =A0 =A0 =A0* still applies.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 return 1350000U / (reg << divreg);
> =A0}
>
> =A0static inline unsigned int
> @@ -424,6 +439,9 @@ struct w83627ehf_data {
> =A0 =A0 =A0 =A0const u16 *REG_FAN_MAX_OUTPUT;
> =A0 =A0 =A0 =A0const u16 *REG_FAN_STEP_OUTPUT;
>
> + =A0 =A0 =A0 unsigned int (*fan_from_reg)(u16 reg, unsigned int divreg);
> + =A0 =A0 =A0 unsigned int (*fan_from_reg_min)(u16 reg, unsigned int divr=
eg);
> +
> =A0 =A0 =A0 =A0struct mutex update_lock;
> =A0 =A0 =A0 =A0char valid; =A0 =A0 =A0 =A0 =A0 =A0 /* !=3D0 if following =
fields are valid */
> =A0 =A0 =A0 =A0unsigned long last_updated; =A0 =A0 /* In jiffies */
> @@ -439,6 +457,7 @@ struct w83627ehf_data {
> =A0 =A0 =A0 =A0u8 fan_div[5];
> =A0 =A0 =A0 =A0u8 has_fan; =A0 =A0 =A0 =A0 =A0 =A0 /* some fan inputs can=
 be disabled */
> =A0 =A0 =A0 =A0u8 has_fan_min; =A0 =A0 =A0 =A0 /* some fans don't have mi=
n register */
> + =A0 =A0 =A0 bool has_fan_div;
> =A0 =A0 =A0 =A0u8 temp_type[3];
> =A0 =A0 =A0 =A0s16 temp[9];
> =A0 =A0 =A0 =A0s16 temp_max[9];
> @@ -765,8 +784,8 @@ static struct w83627ehf_data *w83627ehf_update_device=
(struct device *dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* If we failed to measure=
 the fan speed and clock
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 divider can be increa=
sed, let's try that for next
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 time */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!is_word_sized(data->RE=
G_FAN[i])
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && data->fan[i] =3D=
 0xff
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->has_fan_div
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && data->fan[i] >=
=3D 0xff
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&& data->fan_div[i=
] < 0x07) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(de=
v, "Increasing fan%d "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0"clock divider from %u to %u\n",
> @@ -960,9 +979,7 @@ show_fan(struct device *dev, struct device_attribute =
*attr, char *buf)
> =A0 =A0 =A0 =A0struct sensor_device_attribute *sensor_attr =3D to_sensor_=
dev_attr(attr);
> =A0 =A0 =A0 =A0int nr =3D sensor_attr->index;
> =A0 =A0 =A0 =A0return sprintf(buf, "%d\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fan_from_reg(data->REG_FAN[n=
r],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dat=
a->fan[nr],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 div=
_from_reg(data->fan_div[nr])));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->fan_from_reg(data->fan=
[nr], data->fan_div[nr]));
> =A0}
>
> =A0static ssize_t
> @@ -972,9 +989,8 @@ show_fan_min(struct device *dev, struct device_attrib=
ute *attr, char *buf)
> =A0 =A0 =A0 =A0struct sensor_device_attribute *sensor_attr =3D to_sensor_=
dev_attr(attr);
> =A0 =A0 =A0 =A0int nr =3D sensor_attr->index;
> =A0 =A0 =A0 =A0return sprintf(buf, "%d\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fan_from_reg(data->REG_FAN_M=
IN[nr],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dat=
a->fan_min[nr],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 div=
_from_reg(data->fan_div[nr])));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->fan_from_reg_min(data-=
>fan_min[nr],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 data->fan_div[nr]));
> =A0}
>
> =A0static ssize_t
> @@ -1004,7 +1020,11 @@ store_fan_min(struct device *dev, struct device_at=
tribute *attr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
>
> =A0 =A0 =A0 =A0mutex_lock(&data->update_lock);
> - =A0 =A0 =A0 if (is_word_sized(data->REG_FAN_MIN[nr])) {
> + =A0 =A0 =A0 if (!data->has_fan_div) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Only NCT6776F for now, so we know that=
 this is a 13 bit
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* register
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!val) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val =3D 0xff1f;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> @@ -1028,7 +1048,7 @@ store_fan_min(struct device *dev, struct device_att=
ribute *attr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0new_div =3D 7; /* 128 =3D (1 << 7) */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_warn(dev, "fan%u low limit %lu below m=
inimum %u, set to "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "minimum\n", nr + 1, val,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fan_from_reg(data->REG_F=
AN_MIN[nr], 254, 128));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->fan_from_reg_min(2=
54, 7));
> =A0 =A0 =A0 =A0} else if (!reg) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Speed above this value cannot possibly =
be represented,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 even with the lowest divider (1) */
> @@ -1036,7 +1056,7 @@ store_fan_min(struct device *dev, struct device_att=
ribute *attr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0new_div =3D 0; /* 1 =3D (1 << 0) */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_warn(dev, "fan%u low limit %lu above m=
aximum %u, set to "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "maximum\n", nr + 1, val,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fan_from_reg(data->REG_F=
AN_MIN[nr], 1, 1));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->fan_from_reg_min(1=
, 0));
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Automatically pick the best divider, i.=
e. the one such
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 that the min limit will correspond to=
 a register value
> @@ -1937,9 +1957,12 @@ static int __devinit w83627ehf_probe(struct platfo=
rm_device *pdev)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (sio_data->kind =3D nct6775) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->has_fan_div =3D true;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->fan_from_reg =3D fan_from_reg16;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->fan_from_reg_min =3D fan_from_reg8;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->REG_PWM =3D NCT6775_REG_PWM;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->REG_TARGET =3D NCT6775_REG_TARGET;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->REG_FAN =3D W83627EHF_REG_FAN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->REG_FAN =3D NCT6775_REG_FAN;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->REG_FAN_MIN =3D W83627EHF_REG_FAN_MI=
N;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->REG_FAN_START_OUTPUT =3D NCT6775_REG=
_FAN_START_OUTPUT;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->REG_FAN_STOP_OUTPUT =3D NCT6775_REG_=
FAN_STOP_OUTPUT;
> @@ -1947,14 +1970,20 @@ static int __devinit w83627ehf_probe(struct platf=
orm_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->REG_FAN_MAX_OUTPUT =3D NCT6775_REG_F=
AN_MAX_OUTPUT;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->REG_FAN_STEP_OUTPUT =3D NCT6775_REG_=
FAN_STEP_OUTPUT;
> =A0 =A0 =A0 =A0} else if (sio_data->kind =3D nct6776) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->has_fan_div =3D false;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->fan_from_reg =3D fan_from_reg13;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->fan_from_reg_min =3D fan_from_reg13;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->REG_PWM =3D NCT6775_REG_PWM;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->REG_TARGET =3D NCT6775_REG_TARGET;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->REG_FAN =3D NCT6776_REG_FAN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->REG_FAN =3D NCT6775_REG_FAN;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->REG_FAN_MIN =3D NCT6776_REG_FAN_MIN;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->REG_FAN_START_OUTPUT =3D NCT6775_REG=
_FAN_START_OUTPUT;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->REG_FAN_STOP_OUTPUT =3D NCT6775_REG_=
FAN_STOP_OUTPUT;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->REG_FAN_STOP_TIME =3D NCT6775_REG_FA=
N_STOP_TIME;
> =A0 =A0 =A0 =A0} else if (sio_data->kind =3D w83667hg_b) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->has_fan_div =3D true;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->fan_from_reg =3D fan_from_reg8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->fan_from_reg_min =3D fan_from_reg8;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->REG_PWM =3D W83627EHF_REG_PWM;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->REG_TARGET =3D W83627EHF_REG_TARGET;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->REG_FAN =3D W83627EHF_REG_FAN;
> @@ -1967,6 +1996,9 @@ static int __devinit w83627ehf_probe(struct platfor=
m_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->REG_FAN_STEP_OUTPUT > =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0W83627EHF_REG_FAN_STEP_OUTPUT_W83667_B;
> =A0 =A0 =A0 =A0} else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->has_fan_div =3D true;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->fan_from_reg =3D fan_from_reg8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->fan_from_reg_min =3D fan_from_reg8;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->REG_PWM =3D W83627EHF_REG_PWM;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->REG_TARGET =3D W83627EHF_REG_TARGET;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->REG_FAN =3D W83627EHF_REG_FAN;
> --
> 1.7.3.1
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
