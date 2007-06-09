From: Max Baker <max@warped.org>
Date: Sat, 09 Jun 2007 19:12:29 +0000
Subject: [lm-sensors] Fintek F71805F on Jetway J7F4K1G5D - fancontrol?
Message-Id: <20070609191229.GB16891@warped.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Newbie question here.  I have a Jetway J7F4K1G5D, w/ a VIA C7, CN700 North
bridge and VT8237R south bridge.   It has the super i/o Fintek F71805F.

I'm trying to get basic fan control working .  Right now I've got it to
the point that when i type 'sensors' I can see all the voltages and fan
speeds.

This post is a similar request:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-March/019278.html
that Jean Delvare was able to address.

Is there some magic register I can poke w/ isaset like the one in that
email in order to slow down fan#2? 

> isaset 0x295 0x296 0x90 0x00

Or can I possibly get the full fancontrol program working?    I have zero
experience in this realm and have already burned 5 hours on it (no pun
intended).

My basic problem is that i'm building a mythTv box and the case fan is on
at 8,000 rpm and it sounds like a hair dryer.  I think I could run it at
about one quarter that duty cycle and still achieve adequate cooling.

Thanks!
-m

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
