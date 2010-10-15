From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 15 Oct 2010 14:10:44 +0000
Subject: Re: [lm-sensors] [PATCH] Check for flex and bison
Message-Id: <20101015141044.GA25978@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101015153005.2d3fcac8@endymion.delvare>
In-Reply-To: <20101015153005.2d3fcac8@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, Oct 15, 2010 at 09:30:05AM -0400, Jean Delvare wrote:
> Hi all,
>=20
> I sometimes help people on IRC who have trouble building lm-sensors
> from source, and the most frequent problem is that they don't have flex
> and bison installed. The error message they get is all but explicit.
> While I agree they should have read the documentation which _does_
> explain that flex and bison are required, I think we could still be a
> little more helpful with a proper error message.
>=20
> Is there any objection to the following patch? I hope "which" is
> portable enough.
>=20
> Index: Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- Makefile	(r=E9vision 5865)
> +++ Makefile	(copie de travail)
> @@ -267,6 +267,10 @@
> =20
>  # Flex and Bison
>  %c: %y
> +	@if ! which $(BISON) 2> /dev/null ; then \
> +		echo "Please install $(BISON), then run \"make clean\" and try again" =
; \
> +		false ; \
> +	fi
>  	$(BISON) -p sensors_yy -d $< -o $@
> =20
>  ifeq ($(DEBUG),1)
> @@ -276,4 +280,8 @@
>  endif
> =20
>  %.c: %.l
> +	@if ! which $(FLEX) 2> /dev/null ; then \
> +		echo "Please install $(FLEX), then run \"make clean\" and try again" ;=
 \
> +		false ; \
> +	fi
>  	$(FLEX) $(FLEX_FLAGS) $< > $@
>=20
Looks good (and makes sense) to me.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
