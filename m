From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 10 Jun 2005 17:24:40 +0000
Subject: [lm-sensors] 050610 Sensors einrichten. SuSE Linux 9.3 Prof.
Message-Id: <42A9B07C.8030804@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1118413481.26905.2.camel@linux.site>
In-Reply-To: <1118413481.26905.2.camel@linux.site>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo,

Ich werde versuchen im Deutsch zu helfen, aber nutz nachtesmal Englisch bitte (wenn du kennst)
>  Client found at address 0x1b 
>  Probing for `Maxim MAX6650/MAX6651'... Failed! 
>  Probing for `Philips Semiconductors PCA9556'... Failed! 

Hmm Ich weiss nicht was das soll sein. kannst du bitte

i2cdump 0 0x1B

machen und Ausgang zuruck schicken?


>  Client found at address 0x2f 
>  Probing for `National Semiconductor LM78'... Failed! 
>  Probing for `National Semiconductor LM78-J'... Failed! 
>  Probing for `National Semiconductor LM79'... Failed! 
>  Probing for `National Semiconductor LM80'... Failed! 
>  Probing for `Winbond W83781D'... Failed! 
>  Probing for `Winbond W83782D'... Failed! 
>  Probing for `Winbond W83791D'... Failed! 
>  Probing for `Winbond W83792D'... Failed! 
>  Probing for `Winbond W83791SD'... Failed! 
>  Probing for `Winbond W83627HF'... Failed! 
>  Probing for `Asus AS99127F (rev.1)'... Failed! 
>  Probing for `Asus AS99127F (rev.2)'... Failed! 
>  Probing for `Asus ASB100 Bach'... Failed! 
>  Probing for `Analog Devices ADM9240'... Failed! 
>  Probing for `Dallas Semiconductor DS1780'... Failed! 
>  Probing for `National Semiconductor LM81'... Failed! 
>  Probing for `Analog Devices ADM1029'... Failed! 
>  Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed! 

Bitte auch hier, diesmal mit:
i2cdump 0 0x2f

>  
>  Sensors 
>  w83697hf-isa-0290 
>  Adapter: ISA adapter 
>  VCore: +1.66 V (min = +1.71 V, max = +1.89 V) 
>  +3.3V: +2.93 V (min = +3.14 V, max = +3.47 V) 
>  +5V: +4.92 V (min = +4.76 V, max = +5.24 V) 
>  +12V: +11.49 V (min = +10.82 V, max = +13.19 V) 
>  -12V: -12.28 V (min = -13.18 V, max = -10.80 V) 
>  -5V: -5.15 V (min = -5.25 V, max = -4.75 V) 
>  V5SB: +5.48 V (min = +4.76 V, max = +5.24 V) 
>  VBat: +0.13 V (min = +2.40 V, max = +3.60 V) 
>  fan1: 0 RPM (min = 19852 RPM, div = 2) 
>  fan2: 0 RPM (min = 75000 RPM, div = 2) 
>  temp1: +50?C (high = +11?C, hyst = -100?C) sensor = diode 
>  temp2: +61.5?C (high = +80?C, hyst = +75?C) sensor = diode 
>  alarms: 
>  beep_enable: 
>  Sound alarm enabled 

Du kannst versuchen "divisor" zu andern. Bitte mach es im sensors.conf file.
Suche fur richtige Abteilung mit deinem chip Name, und schreib dort:

set fan1_div 4
set fan2_div 4

Du kannst auch 8 wie "divisor" versuchen wenn du langsame Ventilatoren hast.

>   
>  Aber die Ventielatoren werden nicht angezeigt! 
>  Und was ist mit dem dritten Ventilator? CPU; System, Northbridg! 

Kannst du drittes im Win. auch beobachten? Es ist moglich, dass anderes chip genutzt ist.


>  Und kann man die Werte von der Grafikkarte auslesen? 
>  ?ber Windoof gibt es von ASUS ein Tool mit dem man Spannung,
> Temperatur, 
> Ventilatoren auslesen kann. 

Das ist ganz anderes Problem. Manche grafische Karten haben auch klassische Sensoren aber du must i2c driver fur i2c bus haben.
Ich kenne nicht dieses I2C driver fur linux bitte versuch google.com.


>  Was mu? ich jetzt machen? 

Bitte schreib zuruck was ich will :)

Rudolf
