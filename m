From: CC <ccomren@gmail.com>
Date: Fri, 27 Jan 2012 18:02:58 +0000
Subject: Re: [lm-sensors] AsRock Z68 Pro3-M configuration
Message-Id: <CAH4eiUizQAN=TLYJTVBO1Zeg9AL0n-wxkBp7fzbzN8T=PJV40w@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The actual data for the AsRock Z68 Pro3-M is:

        label in1 "+12V"
        compute in1 @*6.6,@/6.6
        set in1_min 11.400
        set in1_max 12.600

        label in5 "+5V"
        compute in5 @*3,@/3
        set in5_min 4.750
        set in5_max 5.250

        label fan1 "CHA_FAN1"
        label fan2 "CPU_FAN"
        ignore fan3
        label fan4 "PWR_FAN"
        label fan5 "CHA_FAN2"

There's one rogue in4 that has very low, but changing values. They are
between 0.01V and 0.03V.

Best,  CC

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
