From: Max Baker <max@warped.org>
Date: Sat, 09 Jun 2007 23:12:03 +0000
Subject: Re: [lm-sensors] Fintek F71805F on Jetway J7F4K1G5D - fancontrol?
Message-Id: <20070609231203.GA27100@warped.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070609191229.GB16891@warped.org>
In-Reply-To: <20070609191229.GB16891@warped.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Update.

I found the data sheet for the fintek f71805f and started PEEKing and
POKEing in its register bank.

: FAN1 OPERATING Control Register -- Index 60h
: FAN1 OPERATING Control Register -- Index 60h
: FANPWM2 STOP DUTY-CYCLE . Index 72h
: FANPWM2 Output Frequency Control . Index 73h
: FANPWM2 STEP Control Register -- Index 74h
: FAN2 PWM_DUTY -- Index 7Bh

I am now relatively sure that this board does not have any hardware
control of the fan (PWM or DC mode).  The registers were mostly at their
default values from the datasheet and would change accordingly, so I think
i was in the right place.  I tried setting the fan to manual mode and
turning it down.  I also tried any number of other settings in the temp
monitoring registers.

All that said, is there anything else you experts could recommend I try
before packing up this board and returning it?   I don't think I want to
go with the 'roll-your-own' solution -- I'ld rather it work out of the
box.

Can anyone recommend an Mini-ITX motherboard with CN700 or CM700x chipsets
that has working hardware fan control built in?  It's critical to my
application (big drive+tv tuner+small case = heat).

Thanks all!
-m


On Sat, Jun 09, 2007 at 12:12:29PM -0700, Max Baker wrote:
> Hi,
> 
> Newbie question here.  I have a Jetway J7F4K1G5D, w/ a VIA C7, CN700 North
> bridge and VT8237R south bridge.   It has the super i/o Fintek F71805F.
> 
> I'm trying to get basic fan control working .  Right now I've got it to
> the point that when i type 'sensors' I can see all the voltages and fan
> speeds.
> 
> This post is a similar request:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-March/019278.html
> that Jean Delvare was able to address.
> 
> Is there some magic register I can poke w/ isaset like the one in that
> email in order to slow down fan#2? 
> 
> > isaset 0x295 0x296 0x90 0x00
> 
> Or can I possibly get the full fancontrol program working?    I have zero
> experience in this realm and have already burned 5 hours on it (no pun
> intended).
> 
> My basic problem is that i'm building a mythTv box and the case fan is on
> at 8,000 rpm and it sounds like a hair dryer.  I think I could run it at
> about one quarter that duty cycle and still achieve adequate cooling.
> 
> Thanks!
> -m
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
