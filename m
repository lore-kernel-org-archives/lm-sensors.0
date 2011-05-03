From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 03 May 2011 11:47:03 +0000
Subject: Re: [lm-sensors] Gigabyte MA785GM-US2H motherboard configuration
Message-Id: <20110503134703.7cf12806@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <BANLkTimA9Uj9DbC+cG8hrpDXZL+6jTGW9w@mail.gmail.com>
In-Reply-To: <BANLkTimA9Uj9DbC+cG8hrpDXZL+6jTGW9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi David,

On Wed, 27 Apr 2011 22:10:54 +0200, David Santamar=EDa Rogado wrote:
> The configuration for Gigabyte MA785GM-US2H
> http://www.lm-sensors.org/wiki/Configurations/Gigabyte/MA785GM-US2H is
> wrong, at least for rev 1.0 of the mobo. in7 is not +12V, is an
> strange voltage that varies with the frequency of the cores. Is
> possible to determinate approximately it's value knowing the highest
> freq of all the cores in the system. If there are doubts, with that
> config and an Athlon II 250 the voltage show by in7 with the
> multiplier is about 24 V.

Thanks for reporting.

> I can provide the config the works with my MA785GM-US2H rev 1.0.

Yes, please do, and I'll update the wiki with your fixed version.

> The
> only thing I doesn't know sure are the fans because I have only tested
> cpu fan. Anyway it's based on a UD2H cfg found on the internet, being
> identical motherboards only differing in dolby theatre support over
> spdif.

"Found on the internet" as in
http://khali.linux-fr.org/devel/lm-sensors/sensors3-Gigabyte-MA785GMT-UD2H.=
conf
? ;)

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
