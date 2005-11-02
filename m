From: Knut_Petersen@t-online.de (Knut Petersen)
Date: Wed, 02 Nov 2005 19:47:28 +0000
Subject: [lm-sensors] RE: vt8231.c
Message-Id: <436909D8.9030904@t-online.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051102092453.47B1712E9E@bluewhale.planbit.co.uk>
In-Reply-To: <20051102092453.47B1712E9E@bluewhale.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Roger Lucas schrieb:

>Hi Jean,
>
>Updated patch attached.  I love it when you inherit loads of code that you
>end up fixing... :-)
>  
>
One problem: As you know, I use a Verax fan with 9 pulses/revolution.

If i use

    compute fan1 @/9 , @*9
    set fan1_min 1
    set fan1_div 1

in sensors.conf, the shortened sensors output is:

     fan1:     1324 RPM  (min =  571 RPM, div = 1) 

and /sys/bus/i2c/devices/9191-6000/fan1_min contains 5140.

But if I use

    compute fan1 @/9 , @*9
    set fan1_min 0
    set fan1_div 1

that results in a sensors output of

   fan1:     1324 RPM  (min =    0 RPM, div = 1)          ALARM

and /sys/bus/i2c/devices/9191-6000/fan1_min contains 0.

The previous patch also behaved wrong for a "set fan1_min 0".

cu,
 Knut
