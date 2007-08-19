From: =?ISO-8859-1?Q?S=E9bastien_CRAMATTE?= <s.cramatte@wanadoo.fr>
Date: Sun, 19 Aug 2007 10:49:34 +0000
Subject: [lm-sensors] VCoreB aceptable values ? Negative temperature value ?
Message-Id: <46C8203E.6050207@wanadoo.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I've got a PDSMI+ motherboard with intel core duo 2.
I'm running Linux Debian with 2.6.22.1 kernel

Lm-sensors return me this values :

w83793-i2c-0-2f
VCoreA:    +1.32 V  (min =  +0.92 V, max =  +1.49 V)   
VCoreB:    +1.53 V  (min =  +0.92 V, max =  +1.49 V)   ALARM
Vtt:       +1.21 V  (min =  +1.08 V, max =  +1.33 V)   
in3:       +0.51 V  (min =  +0.38 V, max =  +0.69 V)   
in4:       +1.82 V  (min =  +1.62 V, max =  +1.98 V)   
+3.3V:     +3.38 V  (min =  +2.96 V, max =  +3.63 V)   
+12V:     +11.81 V  (min = +10.75 V, max = +13.25 V)   
+5V:       +5.00 V  (min =  +4.64 V, max =  +5.65 V)   
5VSB:      +5.07 V  (min =  +4.64 V, max =  +5.65 V)   
VBAT:      +3.23 V  (min =  +2.99 V, max =  +3.66 V)   
fan1:     11637 RPM  (min =  712 RPM)                   
fan2:     11250 RPM  (min =  712 RPM)                   
CPU1 Temp: +37.2 C  (high = +60.0 C, hyst = +55.0 C)   
CPU2 Temp:-115.5 C  (high = +60.0 C, hyst = +55.0 C)   
temp3:    -128.0 C  (high = +60.0 C, hyst = +55.0 C)   
temp4:    -128.0 C  (high = +60.0 C, hyst = +55.0 C)   
temp5:       +39 C  (high =   +80 C, hyst =   +75 C)  

Could you tell me what should the values rangee for  VCoreB (min/max) ?
What about temp4 and temp5  ? I would like to know what this temp captor
return me  negative values ...

Regards



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
