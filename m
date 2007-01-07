From: r.marek@assembler.cz (Rudolf Marek)
Date: Sun, 07 Jan 2007 11:08:40 +0000
Subject: [lm-sensors] sensors.conf for supermicro x7dbe+
Message-Id: <45A0D4B8.5030201@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701031701.08165.nromer@arcmailtech.com>
In-Reply-To: <200701031701.08165.nromer@arcmailtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Had to go with 2.6.20-rc3. 2.6.19 doesn't have the w83793 driver in it. The 
> output of sensors looks good for the w83793, just need to add a few "ignores" 
> to sensors.conf for the bits of hardware that don't exist in this chasis. The 
> output for the w83627hf that sensors-detect finds looks off, though (see 
> below). SuperMicro didn't mention anything about it.

They did the mistake. It should be w83627hf instead of W83792D.
It should contain the power failure on some GPIO pin, plus chassis intrusion.

If you don't need this. Do not load the hf driver. It is twice there because it
can be accessed via i2c or via isa.

CPU1 Core Voltage, Offset 0x10  -> in0
CPU2 Core Voltage, Offset 0x11  -> in1
-12V Voltage, Offset 0x14 -> in3
+1.5V Voltage, Offset 0x15 -> in4
+3.3V Voltage, Offset 0x16 -> in5
+12V Voltage, Offset 0x17 -> in6
+5V Voltage, Offset 0x18 ->in7
5Vsb Voltage, Offset 0x19 -> in8
Battery Voltage, Offset 0x1a -> in9

Our mapping:
       /*Read, High, Low */

        {0x10, 0x60, 0x61},     /* Vcore A      */

        {0x11, 0x62, 0x63},     /* Vcore B      */

        {0x12, 0x64, 0x65},     /* Vtt          */

        {0x14, 0x6a, 0x6b},     /* VSEN1        */

        {0x15, 0x6c, 0x6d},     /* VSEN2        */

        {0x16, 0x6e, 0x6f},     /* +3VSEN       */

        {0x17, 0x70, 0x71},     /* +12VSEN      */

        {0x18, 0x72, 0x73},     /* 5VDD         */

        {0x19, 0x74, 0x75},     /* 5VSB         */

        {0x1a, 0x76, 0x77},     /* VBAT         */

Your labels should be:

   label in0 "VCoreA"
    label in1 "VCoreB"
    label in2 "Vtt - Unknown"
    label in3 "-12V"
    label in4 "+1.5V"
    label in5 "+3.3V"
    label in6 "+12V"
    label in7 "+5V"
    label in8 "5VSB"
    label in9 "VBAT"

In your dump you have it off by one, please fix the configuration file and post
the sensors command again. You will need to ask for the -12V formula to
Supermicro (or try some from sensors.conf)

> fan10:       0 RPM  (min =  712 RPM)                   ALARM
> CPU1 Temp: +24.8?C  (high = +80.0?C, hyst = +75.0?C)   
> CPU2 Temp: +23.8?C  (high = +80.0?C, hyst = +75.0?C)   
> temp3:     +24.8?C  (high = +80.0?C, hyst = +75.0?C)   
> temp4:     +24.8?C  (high = +80.0?C, hyst = +75.0?C)   
> temp5:       +28?C  (high =   +50?C, hyst =   +45?C)   
> temp6:       +92?C  (high =  +100?C, hyst =   +95?C)   

I'm suspecting that this temperature channel is disabled. Please can you check
the temp6_mode file?

The path to file is something like this, please fix it.

cat /sys/class/hwmon/hwmon?/device/temp6_mode
> cpu0_vid: +1.075 V  (VRM Version 10.0)
> cpu1_vid: +0.000 V  (VRM Version 10.0)

This is also bit strange, maybe it is not connected.

Rudolf

