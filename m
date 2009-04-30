From: Stefan Steuerwald <salsasepp@googlemail.com>
Date: Thu, 30 Apr 2009 06:38:20 +0000
Subject: Re: [lm-sensors] dme1737: Base address not set / How to do the
Message-Id: <f76a32050904292338y3a062f20q9fc3163eb93c39b9@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0594437856037028058=="
List-Id: <lm-sensors.vger.kernel.org>
References: <f76a32050904290817u6e296898x2fdbd43136e0d5ef@mail.gmail.com>
In-Reply-To: <f76a32050904290817u6e296898x2fdbd43136e0d5ef@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============0594437856037028058==
Content-Type: multipart/alternative; boundary=001636c5b4471fd81e0468bff1a7

--001636c5b4471fd81e0468bff1a7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thank you Rudolf,

I have a credit-card sized cpu module with an Intel Atom Z530 and a SMSC3114
Super-IO on a baseboard. The BIOS on the CPU module is a minimal one and
apparently has support only for some Winbond Super-IO and little else.

Now that you have confirmed my suspicion...
I browsed through what sensors-detect does and have been able to use some
outb/inb sequence to set the base address of the chip and activate it. When
I use dme1737 with the force_start=yes module parameter, I am getting
voltage and temp readings. Nice!
Let's see if I can get the rest working without crashing the system.

Thanks again,
  Stefan.


2009/4/29 Rudolf Marek <r.marek@assembler.cz>

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Hi
>
> > For lack of a better BIOS, I think I have to manually poke around the
> > SCH3114's registers to set base address, IRQ numbers, whatever else.
> > Correct?
>
> Yes,
>
> But why the BIOS does not support that? Maybe its not used for monitoring
> at
> all. Maybe you have added to system somehow? (on some strange addon card?)
>
> What southbridge you have? Vendor/model?
>
> Thanks,
> Rudolf
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
>
> iEYEARECAAYFAkn4tcgACgkQ3J9wPJqZRNU5BwCfZx/9ImhkLImucc2F1Mppt3iT
> 38QAoJ3Iedeex9UaaUWgi9FIhuMqSm/j
> =TrYY
> -----END PGP SIGNATURE-----
>

--001636c5b4471fd81e0468bff1a7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thank you Rudolf,<br><br>I have a credit-card sized cpu module with an Inte=
l Atom Z530 and a SMSC3114 Super-IO on a baseboard. The BIOS on the CPU mod=
ule is a minimal one and apparently has support only for some Winbond Super=
-IO and little else.<br>
<br>Now that you have confirmed my suspicion...<br>I browsed through what s=
ensors-detect does and have been able to use some outb/inb sequence to set =
the base address of the chip and activate it. When I use dme1737 with the f=
orce_start=3Dyes module parameter, I am getting voltage and temp readings. =
Nice!<br>
Let&#39;s see if I can get the rest working without crashing the system.<br=
><br>Thanks again,<br>=C2=A0 Stefan.<br><br><br><div class=3D"gmail_quote">=
2009/4/29 Rudolf Marek <span dir=3D"ltr">&lt;<a href=3D"mailto:r.marek@asse=
mbler.cz">r.marek@assembler.cz</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">-----BEGIN PGP SI=
GNED MESSAGE-----<br>
Hash: SHA1<br>
<br>
Hi<br>
<div class=3D"im"><br>
&gt; For lack of a better BIOS, I think I have to manually poke around the<=
br>
&gt; SCH3114&#39;s registers to set base address, IRQ numbers, whatever els=
e.<br>
&gt; Correct?<br>
<br>
</div>Yes,<br>
<br>
But why the BIOS does not support that? Maybe its not used for monitoring a=
t<br>
all. Maybe you have added to system somehow? (on some strange addon card?)<=
br>
<br>
What southbridge you have? Vendor/model?<br>
<br>
Thanks,<br>
Rudolf<br>
<br>
-----BEGIN PGP SIGNATURE-----<br>
Version: GnuPG v1.4.9 (GNU/Linux)<br>
Comment: Using GnuPG with Mozilla - <a href=3D"http://enigmail.mozdev.org" =
target=3D"_blank">http://enigmail.mozdev.org</a><br>
<br>
iEYEARECAAYFAkn4tcgACgkQ3J9wPJqZRNU5BwCfZx/9ImhkLImucc2F1Mppt3iT<br>
38QAoJ3Iedeex9UaaUWgi9FIhuMqSm/j<br>
=3DTrYY<br>
-----END PGP SIGNATURE-----<br>
</blockquote></div><br>

--001636c5b4471fd81e0468bff1a7--


--===============0594437856037028058==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0594437856037028058==--
