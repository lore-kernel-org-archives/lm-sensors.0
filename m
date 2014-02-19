From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 19 Feb 2014 21:15:11 +0000
Subject: Re: [lm-sensors] Sensors configuration for ASRock G41C-GS
Message-Id: <20140219221511.544ab2ec@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392823661.17478.YahooMailNeo@web160502.mail.bf1.yahoo.com>
In-Reply-To: <1392823661.17478.YahooMailNeo@web160502.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, 19 Feb 2014 09:51:14 -0800 (PST), ianp wrote:
> > On Thursday, February 20, 2014 1:01 AM, Jean Delvare <jdelvare@suse.de>=
 wrote:
>=20
> >
> >>  =A0=A0 ### Set in0 according to CPU nominal voltage.
> >>  =A0=A0 ### Set min and max values according to preference.
> >>=20
> >>  =A0=A0 set in0_min 1.2 * 0.95
> >>  =A0=A0 set in0_max 1.2 * 1.05
> >=20
> > What (family of) CPU is it? Typically modern CPUs have a range of
> > supported voltages and the voltage changes dynamically depending on
> > load. So you should use the lowest value to set in0_min and the highest
> > value to set in0_max.
> >=20
>=20
> It's an Intel Core 2 Duo E8400 (family 6, model 23; CPUID 0x10676). You a=
re correct about the CPU min and max voltages, which I have overlooked. Int=
el's Ark provides just that: http://ark.intel.com/products/33910/Intel-Core=
2-Duo-Processor-E8400-6M-Cache-3_00-GHz-1333-MHz-FSB?q=3De8400

Same CPU in my wife's machine, still quite good.

>=20
> set in0_min 0.850
> set in0_max 1.362

Wiki updated.

> >>  ### Temperatures
> >>=20
> >>  =A0=A0 ### Ignore temp3 until properly identified.
> >>=20
> >>  =A0=A0 label=A0 temp1=A0 "N/B Temp"
> >>  =A0=A0 label=A0 temp2=A0 "CPU Temp"
> >>  =A0=A0 ignore temp3
> >=20
> > I do not recommend ignoring unidentified temperatures, they are still
> > useful as long as they are real (which seems to be the case here.)
>=20
> hwmonitor labels it as AUXTIN. It's value resides between 45 C - 46 C, ev=
en from a cold boot. I guess that value seems rational so I will leave it '=
as is' per your recommendation.

AUXTIN is the name of the input in the datasheet, that doesn't say much
about where the sensor actually is on your motherboard.

--=20
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
