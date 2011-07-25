From: "John Smith" <Kidfromaussie@gmx.com>
Date: Mon, 25 Jul 2011 11:46:09 +0000
Subject: Re: [lm-sensors] Config for Gigabyte GA-G31M-ES2L
Message-Id: <20110725114610.118160@gmx.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110725080443.315720@gmx.com>
In-Reply-To: <20110725080443.315720@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org



Well, it seems , that under load in7 slightly drops from 12.46 to 12.36 to 12.30
,tested by running double glxgears which puts strain on cpu and graphics
and simultaneusly scaninng DVD disc which puts dvd device spinning.
(PSU is non-branded 450W which should have large drops of voltages,and makes it easier for this testings)

That would suggest in7 is +12V and in4 is something else 
and i may have a clue what it is :)

There is an option on this motherboard , connected to overcolcking
called "FSB overvoltage controll".
It is placed in bios submenu "MB Intelligent Tweaker ,and by
means of elimination other two options "CPU voltage ctrl" and "DDR2 overvoltage ctrl"
is only one to remain. It is not shown in BIOS ,and i have not looked at EasyTune utilities.
So presumption is in4=FSB voltage.

as it reads in manual for this option:
---------
FSB overvoltage control
Allows you to set the Front Side Bus voltage
-- Normal    Supplies  the FSB voltage as required (default)
-- +0.1V ~ +0.3V Increases FSB voltage by 0.1V to 0.3V at 0.1V increment
---------

> 
> On the other hand,after more looking into it , inputs in4 and in7 might be different
> in4 might be representing +12V using unusual scaling and
> in7 might be +5VSB 
> 
> 
> > 
> > chip "it8718-*"
> > 
> > ### Voltages
> > 
> >    label  in0  "Vcore"
> >    label  in1  "DDR18V"    # "DDR18V" in BIOS
> >    label  in2  "+3.3V"
> >    label  in3  "+5V"     # Not in BIOS
> >    label  in4  "in4"     # Not in BIOS Misterious ?? 0.34v idle; 0.62v under load
> >    ignore in5         # raw reads: +4.08 V
> >    ignore in6         # raw reads: +4.08 V
> >    label  in7  "+12V"
> > # i think in8 should be ignored too ,verbatim from G33-DS3R
> >    label  in8  "Vbat"    # Not in BIOS,raw reads +3.14 V as in7 ?? 
> --
> 

In course of this testing i've discovered that my northbridge is quite hot
with or without graphics running .
On touch northbridge is hot , southbridge is milde ,and CPU is rather cold.
The same as noticed here in these threads
 http://forums.anandtech.com/archive/index.php/t-276020.html
 http://ubuntuforums.org/archive/index.php/t-1101041.html
Unfortunately motherboard does not seems to have sensor for northbridge :(
Will it be helpfull for northbridge if hsf on cpu is made to be running faster? 

And earlier ticket about this series of mobo's was here
http://www.lm-sensors.org/ticket/2345
g31m-s2l ,g31m-s2c , g31m-es2l , g31m-es2c

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
