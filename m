From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 08 Jan 2006 13:10:23 +0000
Subject: [lm-sensors] Lmsensors and Asus CUSL2
Message-Id: <43C10F3F.8010002@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <000301c6142c$ec8c6be0$0200a8c0@administrator>
In-Reply-To: <000301c6142c$ec8c6be0$0200a8c0@administrator>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo,

Jetz probiere ich es auf Deutsch sagen. Du musst drei Sachen machen:

1) sensors-detect starten
2) modprobe modules - laden
3) sensors - starten

1) Die erste Sache wird dir sagen welche Sensoren du auf deinem Motherboard hast. Bitte starte das Programm
sensors-detect und antworte alle Fragen mit Yes

Wenn das Programm verl?uft, du wirst auf dem Bildschirm sehen welche modules zu laden sind.

2) Nutz modprobe programm und lade diese modules.
3) Starte sensors programm und du solltest die Temperaturen sehen, wenn alles OK ist.

Wenn es nicht geht bitte schreibe mir wieder hier und ich  m?chte dann wissen:

Die Version des lm-sensors: sensors -v
Wird es dir sagen.

Kernel version: uname -a
Dann m?chte ich die Ausgabe von sensors-detect sehen. (cut and paste)

Verzeihe mein schelchtes Deutsch :)

Danke,
Tsch?ss
Rudolf

