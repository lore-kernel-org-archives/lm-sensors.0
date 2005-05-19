From: marcus.roeckrath@gmx.de (Marcus Roeckrath)
Date: Thu, 19 May 2005 06:23:43 +0000
Subject: lmsensors 2.7.0 kann auf SuSE 7.2 nicht kompiliert werden
Message-Id: <02121221483700.10542@lighthouse>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo,

nachdem ich i2c 2.7.0 erfolgreich kompiliert und installiert hatte, brach die 
Kompilierung von lmsensors mit einem Fehler in i2c-amd8111.c ab.

Dabei ging es um die Variable u8, die nicht konstant sei, wenn ich die 
Fehlermeldung richtig verstanden habe.

Bin wieder zur?ck auf die 2.6.5, die wie alle Vorversionen immer problemlos 
installierbar war.

Eine Idee?

-- 

Gruss Marcus

Marcus Roeckrath -- Vikarsbusch 8 -- D-48308 Senden -- Germany
Phone  : +49-2536-9944 -- Mailer/BBS/Fax : +49-2536-9943 (V34, X75)
FidoNet: 2:2449/523
E-Mail : marcus.roeckrath@gmx.de
WWW    : http://home.foni.net/~marcusroeckrath/
