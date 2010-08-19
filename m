From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 19 Aug 2010 14:31:38 +0000
Subject: Re: [lm-sensors] pwmconfig doesn't detect correlations properly
Message-Id: <20100819143138.GB3342@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTinN=fLZZyMNfHL5CShkRDOjMTUQeV+GZChUKdWy@mail.gmail.com>
In-Reply-To: <AANLkTinN=fLZZyMNfHL5CShkRDOjMTUQeV+GZChUKdWy@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, Aug 19, 2010 at 09:37:23AM -0400, Jean Delvare wrote:
> Hi Charles,
>=20
> > On Thu, Aug 19, 2010 at 6:36 PM, Jean Delvare <khali@linux-fr.org> wrot=
e:
> > > I think I would prefer a radically different approach:
> > >
> > > pwm1_enable=3D0
> > > pwm2_enable=3D0
> > > wait...
> > > for each PWM:
> > > =A0 this pwm_enable=3D1
> > > =A0 this pwm=3D0
> > > =A0 for each fan
> > > =A0 =A0 =A0check and store fan speed
> > > =A0 next fan
> > > =A0 this pwm_enable=3D0
> > >
> > > =A0 for each fan
> > > =A0 =A0 =A0verify fan speed returned to normal
> > > =A0 next fan
> > >
> > > =A0 for each fan
> > > =A0 =A0 =A0check stored fan speed
> > > =A0 =A0 =A0if speed lower than threshold:
> > > =A0 =A0 =A0 =A0 =A0mark fan as controlled by this pwm
> > > =A0 next fan
> > > next pwm
> > >
> > > This idea is to split the inner for loop into individual actions. This
> > > requires more code, but when dealing with hardware, doing the right
> > > thing in a timely manner is more important than saving a couple lines
> > > of code and CPU cycles. My approach has three merits:
> > > * It is more obviously correct (or, if the code is broken, more
> > > =A0obviously broken.) Each inner for loop will do only one thing, so
> > > =A0hopefully it will do it well.
> > > * It limits the number of PWM on/off to the minimum, as well as the
> > > =A0zero duty cycle time (fan potentially off).
> > > * It warns about stuck fans faster than other approaches do.
> > >
> > > Opinions?
>=20
> On Thu, 19 Aug 2010 20:41:37 +0930, Charles Pillar wrote:
> >    Thanks for your feedback. Jean that suggestion looks great to me, I
> > guess I was going for the minimal approach, just in case I was stark
> > raving mad :P but I agree, what you proposed does look like a better
> > way to go.
>=20
> Hmm, in the end I came up with the following fix, which is quite
> different from my proposed implementation, but also way less intrusive.
> The two parts could even be committed separately, as they fix different
> bugs. The upper part of the patch fixes the problem you actually
> reported. The lower part of the patch fixes redundant sleeps in case a
> given PWM output controls more than one fan.
>=20
> Can you please try this patch and confirm that it solves your problem?
>=20
> Index: prog/pwm/pwmconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- prog/pwm/pwmconfig	(r=E9vision 5853)
> +++ prog/pwm/pwmconfig	(copie de travail)
> @@ -437,15 +437,19 @@
>  		echo '^C received, restoring PWM and aborting...'
>  		exit 1
>  	fi
> +
> +	# Sample all current fan speeds at once, so that we can quickly
> +	# disable PWM.
> +	CURRENT_SPEEDS=3D"`cat $GOODFAN`"
> +	pwmdisable $i
> +
>  	let pwmactivecount=3D0
>  	let count=3D1
>  	for j in $GOODFAN
>  	do
>  		OS=3D`echo $SPEEDS | cut -d' ' -f$count`
> -		# this will return the first field if there's only one (sysfs)
> -		S=3D`cat $j | cut -d' ' -f2`
> +		S=3D`echo $CURRENT_SPEEDS | cut -d' ' -f$count`
>  		echo "  $j ... speed was $OS now $S"
> -		pwmdisable $i
>  		let threshold=3D2*$OS/3
>  		if [ $S -lt $threshold ]
>  		then
> @@ -460,16 +464,18 @@
>  				pwmactive=3D"$i ${pwmactive}"
>  				fanactive=3D"$j ${fanactive}"
>  				fanactive_min=3D"$S ${fanactive_min}"
> +
> +				# Give the fans time to return to full speed
> +				sleep $DELAY
> +				if [ $? -ne 0 ]
> +				then
> +					echo '^C received, aborting...'
> +					exit 1
> +				fi
>  			else
>  				fanactive=3D"$j+${fanactive}" #not supported yet by fancontrol
>  				fanactive_min=3D"$S+${fanactive_min}"
>  			fi
> -			sleep $DELAY
> -			if [ $? -ne 0 ]
> -			then
> -				echo '^C received, aborting...'
> -				exit 1
> -			fi
>  			# this will return the first field if there's only one (sysfs)
>  			S=3D`cat $j | cut -d' ' -f2`
>  			if [ $S -lt $threshold ]
>=20
Looks good to me. My intend was to fix the problem while not being too intr=
usive,
for which you found a much better solution than mine.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
