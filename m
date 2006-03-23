From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 23 Mar 2006 10:50:38 +0000
Subject: [lm-sensors] EVGA NF41
Message-Id: <20060323115038.9ae5e98d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jerry,

Sorry for the late answer...

> (I hope this is the correct way to do this...)
> 
> I did some searching on this motherboard, here is some of the info I 
> have discovered as far as the tmp sensor stuff.
> Sensor Properties:
> Sensor Type Fintek F71872F (ISA 290h)
> GPU Sensor Type Diode (NV-Diode)
> 
> It is an nForce 4 SLi motherboard.
> 
> Is there an existing driver I can use for this?

No, we don't support this chip right now. However, I did add support to
our sensors detection script, and it should now identify the F71872F/FG
chip properly. Can you pick it, give it a try and report?
http://www2.lm-sensors.nu/%7Elm78/cvs/lm_sensors2/prog/detect/sensors-detect

> If not, could I request one???

Support for your chip could be added to our f71805f driver. The F71805F
and F71872F chips are very similar when it comes to hardware
monitoring. The F71872F seems to have a few more inputs, but otherwise
it seems to be compatible.

I added an entry to our New Drivers page for this chip, mentioning your
request for support, so that we don't forget about it.

Now, how much time it'll take to actually add the support you need
depends on how much free time someone willing to do it (could be me)
has, and on what you have to offer.

-- 
Jean Delvare

