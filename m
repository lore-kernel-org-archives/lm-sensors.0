From: "J, KEERTHY" <j-keerthy@ti.com>
Date: Mon, 28 Feb 2011 04:57:18 +0000
Subject: Re: [lm-sensors] [PATCH 1/2 v2] mfd: twl4030: Driver for twl4030
Message-Id: <AANLkTin8hJk3qUysA84ZPoRPH7P-DdjN8BN2-KzJttt-@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1298560713-18790-1-git-send-email-j-keerthy@ti.com>
	<20110228010045.GD2749@sortiz-mobl>
In-Reply-To: <20110228010045.GD2749@sortiz-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: lm-sensors@lm-sensors.org, guenter.roeck@ericsson.com, khali@linux-fr.org, mikko.k.ylinen@nokia.com, amit.kucheria@canonical.com, linux-omap@vger.kernel.org

On Mon, Feb 28, 2011 at 6:30 AM, Samuel Ortiz <sameo@linux.intel.com> wrote:
> Hi Keerthy,
>
> On Thu, Feb 24, 2011 at 08:48:33PM +0530, Keerthy wrote:
>> Introducing a driver for MADC on TWL4030 powerIC. MADC stands for monito=
ring
>> ADC. This driver monitors the real time conversion of analog signals like
>> battery temperature, battery cuurent etc.
> Looks mostly good to me, one minor comment though:
>
>> +static int twl4030_madc_read_channels(struct twl4030_madc_data *madc,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8=
 reg_base, u16 channels, int *buf)
>> +{
>> + =A0 =A0 int count =3D 0, count_req =3D 0;
>> + =A0 =A0 u8 reg, i;
>> +
>> + =A0 =A0 for (i =3D 0; i < TWL4030_MADC_MAX_CHANNELS; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (channels & (1 << i)) {
> You may want to use for_each_set_bit() here.
>

Ok.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D reg_base + 2 * i;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[i] =3D twl4030_madc_channe=
l_raw_read(madc, reg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (buf[i] < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(madc->=
dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Unable to rea=
d register 0x%X\n", reg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count_req++;
> For a clearer code, just call continue here, and the following blck will =
look
> nicer.
>

I will call continue.
>> +static irqreturn_t twl4030_madc_threaded_irq_handler(int irq, void *_ma=
dc)
>> +{
>> + =A0 =A0 struct twl4030_madc_data *madc =3D _madc;
>> + =A0 =A0 const struct twl4030_madc_conversion_method *method;
>> + =A0 =A0 u8 isr_val, imr_val;
>> + =A0 =A0 int i, len, ret;
>> + =A0 =A0 struct twl4030_madc_request *r;
>
> Don't you want to take the madc lock around here ?

Ok.
>
> Cheers,
> Samuel.
>
> --
> Intel Open Source Technology Centre
> http://oss.intel.com/
>



--=20
Regards and Thanks,
Keerthy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
