From: jens.marcus@kiontke.name (Jens Marcus Kiontke)
Date: Fri, 17 Jun 2005 21:04:44 +0000
Subject: [lm-sensors] 050610 Sensors einrichten. SuSE Linux 9.3 Prof.
Message-Id: <1119035029.3433.39.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <1118413481.26905.2.camel@linux.site>
In-Reply-To: <1118413481.26905.2.camel@linux.site>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo Rudolf Marek,

hier ein Bild von meinem Motherboard MSI 7047 CIA KT880 Delta und den
entsprechenden Chips.
Ich hoffe man kann etwas erkennen.
Ich habe leider keine MAXIM Chips finden k?nnen!

Die beiden Fans kann ich jetzt mit div 8 auslesen.
Sie drehen mit kleiner 2500.

Ich habe mal MSI und ASUS ATI Redoen 9800XT wegen den Sensor Chips
angeschrieben leider noch keine Antwort bekommen.

Ich finde es einen tollen Einsatz, den Ihr privat in Eurer Freizeit
aufbringt, wof?r Ihr noch nicht einmal Geld oder Sonstiges bekommt.

Eure Leistungen werden einfach gebraucht ohne sich dar?ber Gedanken zu
machen, wer dies unter welchen Umst?nden macht!

So lebt Ihr mit Eurer Leistung und Produkten leider nur ein
Schattendasein und Eure Leistung wird nicht richtig gew?rdigt!

Vielen herzlichen Dank!

JMK!

Am Freitag, den 10.06.2005, 18:19 +0200 schrieb Rudolf Marek:
> Hallo,
> 
> 
> JMKio wrote:
> > Hallo Rudolf Marek,
> > 
> > i2cdump 0 0x1B
> > No size specified (using byte-data access)
> > WARNING! This program can confuse your I2C bus, cause data loss and
> > worse!
> > I will probe file /dev/i2c-0, address 0x1b, mode byte
> > Continue? [Y/n]
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> > 00: 00 00 00 02 08 00 f0 00 00 00 00 fc 08 08 f0 07    ...??.?....?????
> > 10: 0c 03 05 00 55 55 00 ff ff 00 00 00 02 00 00 00    ???.UU......?...
> > 20: ff 00 07 00 08 00 30 00 00 ff 00 00 00 00 00 00    ..?.?.0.........
> > 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 
> > i2cdump 0 0x2f
> > No size specified (using byte-data access)
> > WARNING! This program can confuse your I2C bus, cause data loss and
> > worse!
> > I will probe file /dev/i2c-0, address 0x2f, mode byte
> > Continue? [Y/n]
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> > 00: 01 07 01 00 07 00 00 00 ff ff ff ff ff ff ff ff    ???.?...........
> > 10: ff ff ff ff 14 62 03 02 ff ff ff ff ff ff ff ff    ....?b??........
> > 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 
> Danke ich werde es ansehen aber leider muss is fur Prufung studieren also vieleich ich werde mehr sagen am Mittwoch.
> 
> 
> > Du kannst versuchen "divisor" zu andern. Bitte mach es im sensors.conf
> > file.
> > 
> >>Suche fur richtige Abteilung mit deinem chip Name, und schreib dort:
> >>
> >>set fan1_div 4
> >>set fan2_div 4
> >>
> >>Du kannst auch 8 wie "divisor" versuchen wenn du langsame Ventilatoren hast.
> > 
> > 
> > Bei welchem mu? ich schauen und die Divisor ?ndern?
> 
> Du must mit text editor ins file /etc/sensors.conf gehen.
> Dort eine Abteilung mit:
> chip "w83697hf-*"
> 
> Suchen und diese zwei
> 
> set fan1_div 4
> set fan2_div 4
> 
> Dort zuchreiben.
> Dan ess muss "sparen" (save)
> Und du must
> 
> sensors -s
> 
> rennen
> 
> und dann
> 
> sensors
> 
> Und du wird sehen weder es arbeitet (du solltest jetzt div = 4 sehen)
> Und wenn dort div = 4 ist, und ventilator is 0 dann du kannst fan1_div 8 versuchen.
> 
> Wenn es nicht arbeitet, ventilatoren sind zum anderes Chip verbindet.
> 
> > Ich habe von MSI ein Tool welches die Werte anzeigt!
> 
> Das ist prima, aber wir wissen nicht wie MSI hat es verbidet. Ich werde versuchen die unbekante chips zu identifieren.
> Ich meine die sind fur ventilatoren. Hast du ein Photo of dein motherboard (high resolution)? Oder kannst du auf motherboard anschauen
> ob dort eingige MAXIM chip sind (und welche) bitte?
> 
> > 
> > Das ist ganz anderes Problem. Manche grafische Karten haben auch
> > klassische Sensoren aber du must i2c driver fur i2c bus haben.
> > 
> >>Ich kenne nicht dieses I2C driver fur linux bitte versuch google.com.
> > 
> > 
> > Wie mu? ich danach suchen, welchen Suchbegriff?
> 
> linux ATI radeon temperature monitor
> 
> > 
> > Leider ist mein englisch sehr schlecht!
> > Gibt es den Jemand der sich damit auch auskennt und deutsch kann
> 
> Nein leider nicht. Du must gedult haben, wir machen es in der Freizeit und wir haben kein geld auf es.
> 
> Regards
> Rudolf
> 

