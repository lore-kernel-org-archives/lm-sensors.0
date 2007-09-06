From: Juergen Bausa <Juergen.Bausa@web.de>
Date: Thu, 06 Sep 2007 19:20:45 +0000
Subject: Re: [lm-sensors] dme1737 module
Message-Id: <1589120833@web.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
In-Reply-To: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org



> Von: Jean Delvare <khali@linux-fr.org>
> Gesendet: 06.09.07 11:51:43
> An: "Juerg Haefliger" <juergh@gmail.com>
> CC: lm-sensors@lm-sensors.org
> Betreff: Re: [lm-sensors] dme1737 module

>=20
> We must rework the checks in the dme1737 printing functions to process
> the ignore statements properly, and to only display errors for missing
> features, not missing channels. I'm attaching the patch I have come up
> with. I can't test it as I do not have the hardware. Juergen, can you
> please test and report?
>=20

Sorry I cant test it because I have the debian package installed. The patch=
 doesnt
apply cleanly to my debian lm-sensors-2.10.4 and I dont want to install the=
 source=20
package.

Juergen
_______________________________________________________________________
Jetzt neu! Sch=FCtzen Sie Ihren PC mit McAfee und WEB.DE. 3 Monate
kostenlos testen. http://www.pc-sicherheit.web.de/startseite/?mc=022220


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
