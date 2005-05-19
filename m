From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: bad vid value
Message-Id: <200405190814.i4J8EGM9063483@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040519065553.GA16559@cereve.enpc.fr>
In-Reply-To: <20040519065553.GA16559@cereve.enpc.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>I currently use sensors2.8.6 with kernel 2.6.6
>
>I use the chip 'W83627HF (ISA)', the module loaded are ( i2c_isa,
>i2c_nforce, w83781d, i2c_sensor, i2c_core)
>
>all seems to work well, except that the min and max value of in0 and in1
>are odd, approximately 1.41V for max although the average value for amd
>duron proc is 1.5V
>
>to correct this I changed the vrm value as adviced ( with set vrm 9.0 )
>but it did not change the vid value ( I did of course sensors -s after
>each modification )
>
>I did not have this pb before, do you know what is going on ?

I may have an idea.

What lm_sensors/kernel combination were you using before? Which VRM
version were you using?

>I also noticed that there is no /proc/sys/dev/../vid file,
>for me all is located in /sys/bus/i2c/../(all files except vid)

This file was (probably improperly) renamed in0_ref. This shoudn't be a
problem as libsensors knows about the change and should read the value.

lm_sensors 2.8.6 is known to have a problem with setting VRM value. This
was fixed in CVS right after the release. Could you please try
lm_sensors CVS and see if it helps?

>I noticed on your web site that the ship 'W83627HF (ISA)' has a specific
>driver that is not the on I use, is this one better ? When running
>'sensors-detect' I was not offered to load W83627HF ,
>
>can I safely replace  w83781d with W83627HF ?

Yes, you can. The Winbond W83627HF on the ISA bus is supported by both
drivers. Using the w83627hf driver is prefered though.

Jean



--
Jean "Khali" Delvare
http://khali.linux-fr.org/
