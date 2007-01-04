From: a@gaydenko.com (Andrew Gaydenko)
Date: Thu, 04 Jan 2007 03:54:52 +0000
Subject: [lm-sensors] W83627DHG, steps to use
Message-Id: <200701040654.52884@goldspace.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200612271943.00165@goldspace.net>
In-Reply-To: <200612271943.00165@goldspace.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

==== On Thursday 04 January 2007 06:34, you wrote: ===...
>coretemp is measured at the hottest part of the core, while
>motherboard will tend to measure the surface temperature.  A few
>degrees difference is expected.  Also that's a really nice temperature
>for coretemp, perhaps you have really frigid air conditioning.  My
>overclocked Core2Duo (@3.4 GHz) runs coretemps of 51C idle and up to
>60C under full load... which is a huge improvement from my old Athlon
>MPs which were 56-65C surface temperature.

[OT]
My aim is a silence rather an overclocking ;-) So I have set Zalaman
9500 to ~1550 rpm (all fans noise are below Samsung HDD noise now).

[T]
OK, I can conclude, coretemp's temps are more "honest", as expected -
closer to cores - closer to truth.


>I made a patch for KSensors, I don't use SysGuard.

It seems like KSensors project is not under development now :-( 
At any case I'll try it with your patch, thanks! 

