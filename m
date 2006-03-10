From: pavouk@pavouk.org (Pavel Ruzicka)
Date: Fri, 10 Mar 2006 23:26:07 +0000
Subject: [lm-sensors] New 2.6 kernel patch for hardware monitoring
Message-Id: <200603110026.07321.pavouk@pavouk.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0603042101570.3972@Laila>
In-Reply-To: <Pine.LNX.4.63.0603042101570.3972@Laila>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I have this board too (RS480M2-IL) and voltages are not available in a latest
bios. This board probably doesn't have connected measure pins to the voltages.
Temperature measuring is really good ;-) I must try it, when I return from a 
holiday.

Best regards,

Pavel Ruzicka

PS. temp1 can be board temperature.

> I tested the new smsc47m192 driver on my msi rs480m2 system using
> 2.6.16-rc5 and here are my results.

> smsc47m192-i2c-0-2d
> Adapter: SMBus PIIX4 adapter at 0400
>
> in0:       +0.00 V  (min =  +0.00 V, max =  +3.32 V)   ALARM
> in1:       +0.00 V  (min =  +0.00 V, max =  +2.99 V)   ALARM
> in2:       +0.00 V  (min =  +0.00 V, max =  +4.38 V)   ALARM
> in3:       +0.00 V  (min =  +0.00 V, max =  +6.64 V)   ALARM
> in5:       +3.33 V  (min =  +0.00 V, max =  +4.38 V)
> in6:       +0.00 V  (min =  +0.00 V, max =  +1.99 V)   ALARM
> in7:       +0.00 V  (min =  +0.00 V, max =  +2.39 V)   ALARM
> temp1:     +35.0 C  (low  =  -128 C, high =  +127 C)
> temp2:     +55.0 C  (low  =  -128 C, high =   +60 C)
> temp3:    +116.0 C  (low  =  -128 C, high =  +127 C)
> vid:      +1.550 V  (VRM Version 2.4)
>
> which is fantastic!
>
> The rest of the measurements are a mystery to me and the 6 ALARMS seem
> slightly... alarming :)

