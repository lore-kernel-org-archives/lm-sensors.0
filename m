From: <JGong@nuvoton.com>
Date: Tue, 24 Feb 2009 10:09:54 +0000
Subject: Re: [lm-sensors] W83667HG on ASUS P6T6 WS Revolution
Message-Id: <29CFBC9A3FDC81418F5FACEEC8970E0020AE0F@ntshml01.nuvoton.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <498B944A.3060502@ioerror.us>
In-Reply-To: <498B944A.3060502@ioerror.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Dear Jean,

>Can you please clarify what you mean by "decided by BIOS"? Do you mean
>that the BIOS is writing something to the chip to configure pin 109? Or
>do you mean that the BIOS author has the knowledge of the board and
>displays either in6 or temp3 depending on the board's wiring?

I mean the second one.=20

>This is really not ideal from a usability perspective.
>Why don't we simply trust bit 0 of register 0x52 in bank 2? After all,
>your original code changes this bit to switch between temp3 and in6, so
>it would seem reasonable that the BIOS sets it to the right value as
>well.

I made a mistake in the last patch. Recently my colleague explains that set=
ting the bit 0 can only stop monitoring the temp3, not to switch the readin=
gs to in6, and for in6, we still need to read it at bank 0 index 26h.

>So I propose the following approach:
>* Make the driver trust bit 0 of register 0x52 in bank 2. If the bit is
>  set, create in6 attributes but not temp3 attributes. If it is clear,
>  create temp3 attributes but not in6 attributes. Issue a debug message
>  explaining the decision. For the W83667HG only, of course; for older
>  chips we keep always creating all attributes.
>* If it is ever found that some motherboard doesn't properly initialize
>  this configuration bit, try to get the manufacturer to fix the BIOS.
>  If we fail, either add a per-motherboard override in the driver, or
>  add a module parameter or a sysfs attribute to let the user override
>  the default configuration.

OK, if we trust the bit 0 and the bit is set, we create in6 not temp3, othe=
rwise we create the temp3 not in6. (The bit's default value is 0.)

But what can we do if the temp3 is created and its value is unacceptable li=
ke 124.5=B0C?=20

>It would be great to get this solved quickly so that support for the >W836=
67HG makes it into kernel 2.6.30.

As soon as we've found a proper solution of this problem, I'll make out the=
 patch and recommit it.=20

Best regards,
Gong Jun


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DThe privileged =
confidential information contained in this email is intended for use only b=
y the addressees as indicated by the original sender of this email. If you =
are not the addressee indicated in this email or are not responsible for de=
livery of the email to such  a person, please kindly reply to the sender in=
dicating this fact and delete all copies of it from your computer and netwo=
rk server immediately. Your cooperation is highly appreciated. It is advise=
d that any unauthorized use of confidential information of Nuvoton is stric=
tly prohibited; and any information in this email irrelevant to the officia=
l business of Nuvoton shall be deemed as neither given nor endorsed by Nuvo=
ton.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
