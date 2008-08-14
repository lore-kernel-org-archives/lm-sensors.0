From: "Simon Depiets" <sdepiets@gmail.com>
Date: Thu, 14 Aug 2008 08:27:14 +0000
Subject: Re: [lm-sensors] CPU Model 1c (Intel Atom) not supported in coretemp
Message-Id: <f4897e880808140127r2c781eday5157f5f58cfac782@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <489F3A3E.30908@assembler.cz>
In-Reply-To: <489F3A3E.30908@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

OK, it seems to work

# uname -a
Linux localhost.localdomain 2.6.27-rc2 #1 SMP Thu Aug 14 02:07:37 CEST 2008
i686 i686 i386 GNU/Linux

# modprobe coretemp && dmesg -c
coretemp coretemp.0: Unable to read IA32_TEMPERATURE_TARGET MSR
coretemp coretemp.1: Unable to read IA32_TEMPERATURE_TARGET MSR

#sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +29.0=B0C  (crit =3D +95.0=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +29.0=B0C  (crit =3D +95.0=B0C)

Thanks a lot,
mail me when it'll be commited to main kernel, I'll try it again

2008/8/10 Rudolf Marek <r.marek@assembler.cz>:
> Hi all,
>
> I completed a patch for Atom support. Intel told me the TjMax. It is 95C.
> Here we go. Please test and report if it works for you.
>
> The high temperature might be wrong. Please check that Critical temperatu=
re
> is 95C. Or even better paste the output sensors to some mail.
>
> The patch has been just compile tested! Test with care!
>
> Signed-off-by: Rudolf Marek <r.marek@assembler.cz>
>
> Thanks
> Rudolf
>



--=20
Lliane aka Simon Depiets
Epita Promo 2011,42
http://www.lliane.com
A man is smoking with his girlfriend. She angers herself : "don't you
see the warning on the box ?!"
To which the man replies, "I am a programmer. I don't worry about
warnings. I only worry about errors."

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
