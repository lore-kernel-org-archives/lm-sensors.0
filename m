From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:43 +0000
Subject: lmsensors 2.7.0 kann auf SuSE 7.2 nicht kompiliert werden
Message-Id: <20021213100008.20390316.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <02121221483700.10542@lighthouse>
In-Reply-To: <02121221483700.10542@lighthouse>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Marcus,

Please keep in mind that most people on this list can read german. Use
english next time.

Please give us the exact compiler error message (including line number)
and it should be easy to fix.

> nachdem ich i2c 2.7.0 erfolgreich kompiliert und installiert hatte,
> brach die Kompilierung von lmsensors mit einem Fehler in i2c-amd8111.c
> ab.
> 
> Dabei ging es um die Variable u8, die nicht konstant sei, wenn ich die
> Fehlermeldung richtig verstanden habe.
> 
> Bin wieder zur?ck auf die 2.6.5, die wie alle Vorversionen immer
> problemlos installierbar war.
> 
> Eine Idee?

Translation for everyone:

Marcus complains that he is unable to compile lm_sensors 2.7.0 on his
SuSE 7.2 (whereas 2.6.5 and previous versions were always OK). The error
is about u8 not being constant (?) in i2c-amd8111.c.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
