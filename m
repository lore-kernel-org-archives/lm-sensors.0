From: Stefan Steuerwald <salsasepp@googlemail.com>
Date: Wed, 29 Apr 2009 15:17:01 +0000
Subject: [lm-sensors] dme1737: Base address not set / How to do the BIOS' job
Message-Id: <f76a32050904290817u6e296898x2fdbd43136e0d5ef@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3269053263392543955=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============3269053263392543955==
Content-Type: multipart/alternative; boundary=001636c5a26e3c1ff70468b31291

--001636c5a26e3c1ff70468b31291
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi lm-sensor,

I have an embedded system with a SCH3114 Super-I/O sitting at 0x2E on the
LPC bus.
My BIOS does not support this chip, hence it goes uninitialized on boot.
Consequently, when I load the dme1737 kernel module, it says "Base address
not set".

For lack of a better BIOS, I think I have to manually poke around the
SCH3114's registers to set base address, IRQ numbers, whatever else.
Correct?
Maybe anybody can point me to some code that may be doing something similar?
I'd like to enable the Super-I/O's USARTs and LPT, above all.

Thank you,
  Stefan.

--001636c5a26e3c1ff70468b31291
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi lm-sensor,<br><br>I have an embedded system with a SCH3114 Super-I/O sit=
ting at 0x2E on the LPC bus.<br>My BIOS does not support this chip, hence i=
t goes uninitialized on boot.<br>Consequently, when I load the dme1737 kern=
el module, it says &quot;Base address not set&quot;.<br>
<br>For lack of a better BIOS, I think I have to manually poke around the S=
CH3114&#39;s registers to set base address, IRQ numbers, whatever else.<br>=
Correct? <br>Maybe anybody can point me to some code that may be doing some=
thing similar? I&#39;d like to enable the Super-I/O&#39;s USARTs and LPT, a=
bove all.<br>
<br>Thank you,<br>=C2=A0 Stefan.<br><br>

--001636c5a26e3c1ff70468b31291--


--===============3269053263392543955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3269053263392543955==--
