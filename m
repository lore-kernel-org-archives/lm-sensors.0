From: Pelle Windestam <pelle@windestam.se>
Date: Fri, 26 Aug 2011 05:49:59 +0000
Subject: Re: [lm-sensors] dell pe 600sc
Message-Id: <CAOdCkm1km+bYMCDw=QMf7HnBLUbVZ32Uqud4pHOcrvVZR2vsaw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314325122.65777.YahooMailClassic@web161426.mail.bf1.yahoo.com>
In-Reply-To: <1314325122.65777.YahooMailClassic@web161426.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Did you run sensors-detect again after=A0the modprobe?

//Pelle

On Fri, Aug 26, 2011 at 4:18 AM, Jane Teng <sunshine97s@yahoo.com> wrote:
>
> Hi All,
>
> I have an old dell poweredge 600sc. I can't detect any sensor after runni=
ng sensors-detect.
>
> motherboard:
> CPU: Processor, 80532, 2.4G, 512K, 533, Socket N, C1
>
> however I read this from google:
> "Sorry to fly in the face of common wisdom, but after some persistence, I=
 have discovered that the Dell Poweredge 600SC DOES in fact have managment =
sensors an lm_sensors CAN read them. The secret was to force load the i2c_p=
iix4 module: modprobe i2c_piix4 force=3D1 Works fine, reads temperature, fa=
n speeds, etc. "
>
> I have tried:
> modprobe i2c_piix4 force=3D1
> what should I do next?
>
> Thanks in advance
>
> Jane
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
