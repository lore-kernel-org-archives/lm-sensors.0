From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: Temps on S755MAX IT8705F
Message-Id: <200407161003.i6GA3pQq078747@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <40F5A42D.9070301@verizon.net>
In-Reply-To: <40F5A42D.9070301@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>>You don't use the reset_it87 module parameter, do you?
>>
>I don't even know what it is.:-)

Just a module parameter you can use if you want to have the IT87xx chip
reset and arbitrarily reconfigured. That's so useful that we plan to
drop it at some later time... ;)

Read below though.

>OK, I thought I had tried all combos in MBM, but I guess not. Set to
>sensor 1-diode works for the cpu temp in MBM. I verified this by making
>the temps go up and down  and checking the time it took vs Smartguardian
>and they were basically the same. My boards not in the MBM database
>either so I just picked a K7S5A I think to start with, but I don't
>recall for sure. It's been a few months and I don't normally run win.

Ok, that's interesting. At least we can now assume that temp1 with type
"diode" is where you can read the CPU temperature. We just have to
figure out where it87+sensors is failing while MBM works.

Can you check if you have any particular option enabled in MBM to make it
work? For example "Reset sensorchip", or just anything that sounds
like a special configuration parameter?

If it has "Reset sensorchip" checked then I guess you want to try the
reset_it87 parameter of the it87 module (just load it with "modprobe
it87 reset_it87=1").

>Now for the bad part. I changed to set sensor1 3 in sensors.conf and
>then set it with -s. Still read 70C. So I lowered that with a -35 offset
>to get it to 35 which I know is very close to the normal idle temp. I
>then turned the fan off expecting the temps to start rising. They never
>did, so I either missed something or there's another problem somewhere.
>So, either way I set sensor1 it was the same. no rise in temps with fan
>off. What's wierd is that when set to thermisor, it rises 1C when I run
>glxgears and load the cpu to about 50%. Now that seems real strange to
>me. At this point, I'm going to update from 2.8.4 to 2.8.7 and see what
>happens.

Yes, please try 2.8.7. Some of the changes made to the it87 driver, most
notably in the init part, may have fixed your problem as a side effect.

If it still doesn't work, please provide a dump of your it87 chip (with
"isadump 0x295 0x296").

Thanks,
Jean Delvare
