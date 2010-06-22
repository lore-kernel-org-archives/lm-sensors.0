From: Luca Tettamanti <kronos.it@gmail.com>
Date: Tue, 22 Jun 2010 11:32:26 +0000
Subject: Re: [lm-sensors] ASUS P7P55D PRO
Message-Id: <AANLkTiklyOeM_Pjmspkr7ywsSdK26syk8YNYeFyK0mYw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <43865.137.222.58.99.1277137848.squirrel@webmail.bris.ac.uk>
In-Reply-To: <43865.137.222.58.99.1277137848.squirrel@webmail.bris.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, Jun 21, 2010 at 6:30 PM, DG Cussans <David.Cussans@bristol.ac.uk> w=
rote:
>
> Hi,
> =C2=A0 I have a PC with a ASUS p7p55d motherboard. sensors-detect indicat=
es
> that it uses a W83667HG-B
> Is there any estimate of how long it will take before there is a driver
> for this device?

The native driver won't load because the hwmon chip is actively used
by the firmware. asus_atk0110 should work fine on this board.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
