From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 22 Mar 2012 13:48:52 +0000
Subject: Re: [lm-sensors] asus_atk0110: i8042: keys get stuck and keyboard stops responding
Message-Id: <20120322134852.GB19658@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120320231656.GC12339@burratino>
In-Reply-To: <20120320231656.GC12339@burratino>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, Mar 22, 2012 at 07:11:10AM -0400, Luca Tettamanti wrote:
> Hello Jonathan,
>=20
> On Wed, Mar 21, 2012 at 12:16 AM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> > Hi Luca et al,
> >
> > Several people have been finding the PS/2 keyboard and mouse suddenly
> > stop working a few hours after loading the asus_atk0110 module on
> > machines using the Asus P7P55D or P7P55D-E board. =A0For example:
> [...]
> > From [2] I see that you tracked it down to a BIOS problem.
>=20
> Not really, I _suspect_ that there's a bug in the BIOS, but I wasn't
> able to confirm it; maybe it's something that the driver does.
> In the thread that you link Javier never replied with the results of the =
test.
>=20
> > So I am
> > curious: would there be a way to detect affected machines and
> > automatically work around this? =A0Toy patch just to give the idea
> > follows.
>=20
> That would leave the user without any monitoring options; using the
> native driver is very risky in this situation, the board has an EC
> that goes out and reads the sensors on its own.
> Furthermore the bug does not seem to affect all the users of that
> board, it may be BIOS and/or board revision dependent.
>=20
> I'm adding Jean and Guenter in CC: what do you think about blalisting
> the driver on P7P55D?
>=20
I don't like it much, but in the absence of a fix it seems to be the only a=
vailable option.
A stuck keyboard and mouse is worse than having no monitor options.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
