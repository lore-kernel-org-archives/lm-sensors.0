From: "Phil Endecott" <phil_ujlam_endecott@chezphil.org>
Date: Mon, 11 Jun 2007 11:55:06 +0000
Subject: Re: [lm-sensors] Fintek F71805F on Jetway J7F4K1G5D - fancontrol?
Message-Id: <1181562906123@dmwebmail.belize.chezphil.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070609191229.GB16891@warped.org>
In-Reply-To: <20070609191229.GB16891@warped.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Max Baker wrote:
> On Sun, Jun 10, 2007 at 11:35:28AM +0100, Phil Endecott wrote:
>> My 1.2GHz board is fanless, i.e. it has a passive CPU heatsink, and all 
>> three of the fan connectors are non-controllable.  However the board 
>> has unpopulated positions for control components for the CPU fan, and 
>> my guess was that they are fitted on the 1.5GHz+ versions (which ship 
>> with a CPU fan, as I presume yours does).  So you should be able to 
>> control the speed of your CPU fan.
>
> No Dice.   I set 0x60 to 0x22 (Fan #1 - Manual Mode) and 0x6b to 0x01
> (lowest PWM setting) and did not see any change in the fan speed.

Max,

I've put a couple of photos of my J7F2 board here:
http://chezphil.org/tmp/j7f2_cpufan_top.jpeg
http://chezphil.org/tmp/j7f2_cpufan_bottom.jpeg

In the top photo, you can see an unpopulated position for a transistor 
("Q1") next to the CPU fan connector.  In the bottom photo, you can see 
a "zero-ohm resistor" and some more unpopulated positions (the three 
pins on the left of this picture are the bottom of the fan connector).

If your board looks similar, you're right that you can't control the 
fan speed.  If you have a transistor and other components near the fan 
connector, then keep trying!


Phil.





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
