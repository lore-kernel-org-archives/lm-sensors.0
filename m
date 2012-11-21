From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 21 Nov 2012 22:05:31 +0000
Subject: Re: [lm-sensors] Configuration File for ASRock B75 Pro3
Message-Id: <20121121230531.46691f54@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <509C1EBF.3000309@ing-poetter.de>
In-Reply-To: <509C1EBF.3000309@ing-poetter.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, 21 Nov 2012 21:09:59 +0100, Lars P=F6tter wrote:
> Am 12.11.2012 10:28, schrieb Jean Delvare:
> > +1.9V and +1.66V make little sense to me. These voltage values aren't
> > part of the ATX specification. They most certainly correspond to +12V
> > and +5V (the ASROck BIOS displays these) and need proper scaling
> > factors. Please read:
> >   http://www.lm-sensors.org/wiki/VoltageLabelsAndScaling
> > then you should be able to figure out who is who and which scaling
> > factors should be applied.
>=20
> The Bios has:
> VCore        +1,048V
> +12V        +12,513V
> +5V          +4,992V
> +3,3V        +3,424V
>=20
> and sensors -u has:
> nct6776-isa-0290
> Adapter: ISA adapter
> (...)
> +1.9V:
>   in1_input: 1.896
> (...)
> +1.66V:
>   in5_input: 1.656
>=20
> I hope that makes sense to you.

As explained in the wiki page I wrote and pointed you to, you need
several samples for every input in order to be able to find the mapping
and scaling factors of multiple voltage inputs. I can't do anything
with just the values above, we need more voltage samples from the BIOS.

> > You have only one fan in your machine but the board had 5 headers. The
> > BIOS can display 5 fan speed values, so we don't want these ignore
> > statements in the configuration file that will go to the wiki. Best
> > would be to provide the right label for each fan, with some luck they
> > are in the same order as in the BIOS, but you if you have a spare fan
> > to confirm that, it would be great.
>=20
> I don't have a spare fan to confirm, but these are the Names in the Bios
> used for the Fan Connectors:
> - CPU-FAN1 (The ios shows my fan there so this must be fan2 althoug it
> is listed first in the Bios)
> - CPU-FAN2
> - Chassis FAN 1
> - Chassis FAN 2
> - Power FAN

If even the CPU fan input aren't in the BIOS display order, I wouldn't
place any bet on the rest, especially on an ASRock board. Let's leave
the fan labels blank for the time being.

> (...)
> I understand that it is important for an open source Project to care for
> high quality, but from the user perspective I would prefer to have a
> "beta" or "alpha" marked config file to not having a config file. This
> also gives the user that finds the "beta" version to improve it,..

I'm fine with preliminary configuration files, but not with wrong ones.
Configuration files which ignore inputs which do exist on the board are
not OK. Wrong labels aren't OK either - if you don't know what an input
is, just don't label it.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
