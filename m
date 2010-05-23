From: Ira Snyder <iws@ovro.caltech.edu>
Date: Sun, 23 May 2010 00:12:57 +0000
Subject: Re: [lm-sensors] [PATCH 0/2 v2] hwmon: (ltc4245) fix GPIO support
Message-Id: <20100522171257.104b0f15.iws@ovro.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <1271199569-3880-1-git-send-email-iws@ovro.caltech.edu>
In-Reply-To: <1271199569-3880-1-git-send-email-iws@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, 22 May 2010 13:53:50 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> Hi Ira,
>=20
> On Fri, 21 May 2010 08:02:27 -0700, Ira W. Snyder wrote:
> > On Fri, May 21, 2010 at 11:04:52AM +0200, Jean Delvare wrote:
> > > I still think the current error handling is less than ideal. If it
> > > becomes common that hwmon drivers return errors, I'd prefer them to
> > > look nice in the output of "sensors". Something like:
> > >=20
> > > Dig 3.30v Output: +3.26 V
> > > Dig 2.25v Output:     N/A
> > > Dig 1.80v Output:     N/A
> > >=20
> > > Hopefully this wouldn't be too hard to implement. What do you think?
> > >=20
> > > We might have to invent new libsensors error codes to differentiate
> > > between error cases, or give callers a way to retrieve the original
> > > error code.
> >=20
> > I agree, that would be nice. That's a libsensors patch, not a kernel
> > patch though.
>=20
> A more immediate action would actually be a sensors patch. I get the
> following output for my thinkpad with the attached patch applied:
>=20
> thinkpad-isa-0000
> Adapter: ISA adapter
> fan1:       3430 RPM
> temp1:       +62.0=B0C                                   =20
> temp2:       +46.0=B0C                                   =20
> temp3:       +44.0=B0C                                   =20
> temp4:       +75.0=B0C                                   =20
> temp5:       +50.0=B0C                                   =20
> temp6:           N/A                                   =20
> temp7:       +37.0=B0C                                   =20
> temp8:           N/A                                   =20
> temp9:       +48.0=B0C                                   =20
> temp10:      +58.0=B0C                                   =20
> temp11:      +58.0=B0C                                   =20
> temp12:          N/A                                   =20
> temp13:          N/A                                   =20
> temp14:          N/A                                   =20
> temp15:          N/A                                   =20
> temp16:          N/A                                   =20
>=20
> Would this be OK with you?
>=20

That looks fine to me. I'm using libsensors (but not the sensors
program itself, except when debugging) to read my chips. The output
certainly is much nicer, though.

Ira

> ---
>  prog/sensors/chips.c |   42 ++++++++++++++++++++++++++++--------------
>  1 file changed, 28 insertions(+), 14 deletions(-)
>=20
> --- lm-sensors.orig/prog/sensors/chips.c	2010-05-21 17:38:36.000000000 +0=
200
> +++ lm-sensors/prog/sensors/chips.c	2010-05-21 17:49:22.000000000 +0200
> @@ -91,6 +91,21 @@ static double get_value(const sensors_ch
>  	return val;
>  }
> =20
> +/* A variant for input values, where we want to handle errors gracefully=
 */
> +static int get_input_value(const sensors_chip_name *name,
> +			   const sensors_subfeature *sub,
> +			   double *val)
> +{
> +	int err;
> +
> +	err =3D sensors_get_value(name, sub->number, val);
> +	if (err && err !=3D -SENSORS_ERR_ACCESS_R) {
> +		fprintf(stderr, "ERROR: Can't get value of subfeature %s: %s\n",
> +			sub->name, sensors_strerror(err));
> +	}
> +	return err;
> +}
> +
>  static int get_label_size(const sensors_chip_name *name)
>  {
>  	int i;
> @@ -230,8 +245,8 @@ static void print_chip_temp(const sensor
>  	} else {
>  		sf =3D sensors_get_subfeature(name, feature,
>  					    SENSORS_SUBFEATURE_TEMP_INPUT);
> -		if (sf) {
> -			val =3D get_value(name, sf);
> +		if (sf && get_input_value(name, sf, &val) =3D 0) {
> +			get_input_value(name, sf, &val);
>  			if (fahrenheit)
>  				val =3D deg_ctof(val);
>  			printf("%+6.1f%s  ", val, degstr);
> @@ -289,7 +304,7 @@ static void print_chip_in(const sensors_
>  			  int label_size)
>  {
>  	const sensors_subfeature *sf, *sfmin, *sfmax;
> -	double alarm_max, alarm_min;
> +	double val, alarm_max, alarm_min;
>  	char *label;
> =20
>  	if (!(label =3D sensors_get_label(name, feature))) {
> @@ -302,8 +317,8 @@ static void print_chip_in(const sensors_
> =20
>  	sf =3D sensors_get_subfeature(name, feature,
>  				    SENSORS_SUBFEATURE_IN_INPUT);
> -	if (sf)
> -		printf("%+6.2f V", get_value(name, sf));
> +	if (sf && get_input_value(name, sf, &val) =3D 0)
> +		printf("%+6.2f V", val);
>  	else
>  		printf("     N/A");
> =20
> @@ -355,6 +370,7 @@ static void print_chip_fan(const sensors
>  			   int label_size)
>  {
>  	const sensors_subfeature *sf, *sfmin, *sfdiv;
> +	double val;
>  	char *label;
> =20
>  	if (!(label =3D sensors_get_label(name, feature))) {
> @@ -372,8 +388,8 @@ static void print_chip_fan(const sensors
>  	else {
>  		sf =3D sensors_get_subfeature(name, feature,
>  					    SENSORS_SUBFEATURE_FAN_INPUT);
> -		if (sf)
> -			printf("%4.0f RPM", get_value(name, sf));
> +		if (sf && get_input_value(name, sf, &val) =3D 0)
> +			printf("%4.0f RPM", val);
>  		else
>  			printf("     N/A");
>  	}
> @@ -471,8 +487,7 @@ static void print_chip_power(const senso
>  					       SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL);
>  	}
> =20
> -	if (sf) {
> -		val =3D get_value(name, sf);
> +	if (sf && get_input_value(name, sf, &val) =3D 0) {
>  		scale_value(&val, &unit);
>  		printf("%6.2f %sW", val, unit);
>  	} else
> @@ -526,8 +541,7 @@ static void print_chip_energy(const sens
> =20
>  	sf =3D sensors_get_subfeature(name, feature,
>  				    SENSORS_SUBFEATURE_ENERGY_INPUT);
> -	if (sf) {
> -		val =3D get_value(name, sf);
> +	if (sf && get_input_value(name, sf, &val) =3D 0) {
>  		scale_value(&val, &unit);
>  		printf("%6.2f %sJ", val, unit);
>  	} else
> @@ -583,7 +597,7 @@ static void print_chip_curr(const sensor
>  			    int label_size)
>  {
>  	const sensors_subfeature *sf, *sfmin, *sfmax;
> -	double alarm_max, alarm_min;
> +	double alarm_max, alarm_min, val;
>  	char *label;
> =20
>  	if (!(label =3D sensors_get_label(name, feature))) {
> @@ -596,8 +610,8 @@ static void print_chip_curr(const sensor
> =20
>  	sf =3D sensors_get_subfeature(name, feature,
>  				    SENSORS_SUBFEATURE_CURR_INPUT);
> -	if (sf)
> -		printf("%+6.2f A", get_value(name, sf));
> +	if (sf && get_input_value(name, sf, &val) =3D 0)
> +		printf("%+6.2f A", val);
>  	else
>  		printf("     N/A");
> =20
>=20
>=20
>=20
> --=20
> Jean Delvare
>=20


--=20
Ira Snyder <iws@ovro.caltech.edu>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
