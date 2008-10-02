From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 02 Oct 2008 16:41:59 +0000
Subject: Re: [lm-sensors] Looking for IT8720 datasheet.
Message-Id: <20081002184159.231d2ada@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <79c9d4530810020825r79de9817g6933f6cab1d414c1@mail.gmail.com>
In-Reply-To: <79c9d4530810020825r79de9817g6933f6cab1d414c1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2 Oct 2008 12:28:40 -0400, Jean-Marc Spaggiari wrote:
> Did you get a chance to work on IT8720? I have modify the
> sensors-detect script to return it87, and also modify it87.c to handle
> the IT8720 as any other IT87 chipset, and it seems to work pretty
> fine. It's fine for the FANs and the temp, but I'm not 100% sur for
> the voltage.
> 
> in0:         +0.00 V  (min =  +0.00 V, max =  +4.08 V)   ALARM
> in1:         +3.02 V  (min =  +0.00 V, max =  +4.08 V)
> in2:         +3.42 V  (min =  +0.00 V, max =  +4.08 V)
> in3:         +3.01 V  (min =  +0.00 V, max =  +4.08 V)
> in4:         +1.22 V  (min =  +0.00 V, max =  +4.08 V)
> in5:         +2.62 V  (min =  +0.00 V, max =  +4.08 V)
> in6:         +2.59 V  (min =  +0.00 V, max =  +4.08 V)
> in7:         +3.01 V  (min =  +0.00 V, max =  +4.08 V)
> in8:         +3.38 V
> 
> 
> I didn't get the +12 or -5 or others. I was able to get it one time,
> and no more. Any idea?

This is expected. The IT87xxF use a 4V DAC, so you can only measure
voltage values up to 4V directly. For +5V, +12V and negative voltages,
there are scaling resistors on the motherboard. So you need proper
sensors.conf statements. You can try with the default settings for the
IT87xxF chips (see the default sensors.conf file) but your motherboard
may or may not follow these. So it can take some work to get things
right. Best is to compare with what the BIOS displays.

The typical way is to scale voltages so that their nominal value at the
chip's pin is 3V. So, looking at the above, it is likely that in1, in3,
and in7 are monitoring voltages above 4V. in7 is usually 5VSB. in2 is
probably +3.3V and in8 is most certainly Vbat.

As for negative voltage, check your BIOS, but you probably do not have
any. Most recent motherboards no longer bother monitoring them because
they are almost unused.

Strange thing is that in0 is 0V... on most boards, in0 is Vcore.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
