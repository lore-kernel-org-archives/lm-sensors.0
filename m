From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: sensor problems with msi k8t (ticket #1553)
Message-Id: <Gyxdszlf.1100105048.5688770.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <200411101004.56332.murray@smigel.org>
In-Reply-To: <200411101004.56332.murray@smigel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>Hmm, I have set sensor1 to the thermistor and sensors2 and 3 to diode, but I 
>get really screwy temperatures that way.
>
>M/B Temp:   +126 C  (high =   +50 C, hyst =   +47 C)   sensor = thermistor   
>ALARM
>CPU1 Temp: +43.0 C  (high =   +60 C, hyst =   +57 C)   sensor = PII/Celeron 
>diode
>CPU2 Temp:+124.5 C  (high =   +60 C, hyst =   +95 C)   sensor = PII/Celeron 
>diode   ALARM
>
>While if I set sensors 1 and 2 to diode and sensor 3 to thermistor, things 
>look a lot more sane
>
>CPU1 Temp:   +43 C  (high =   +60 C, hyst =   +57 C)   sensor = PII/Celeron 
>diode
>CPU2 Temp: +43.0 C  (high =   +60 C, hyst =   +57 C)   sensor = PII/Celeron 
>diode
>M/B Temp:  +35.0 C  (high =   +50 C, hyst =   +95 C)   sensor = thermistor

I have to admit that you get a point. Maybe MSI swapped the sensors on
your revision of the board compared with the board referenced on MBM's
site.

> What sets the resolution?

It's hardware defined. temp1 has 1 degree resolution, temp2 and temp3
have 0.5 degree resolution. This is common to all Winbond chips as far
as I know. Don't ask me why ;)

Jean
