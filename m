From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 08 Oct 2009 12:25:58 +0000
Subject: Re: [lm-sensors] [Module] hwmon: GM/GME965 GM45 and more chips IGP
Message-Id: <20091008142558.478fb16c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <73511e6c0907180440p43b81f33x85c4dc70007165b3@mail.gmail.com>
In-Reply-To: <73511e6c0907180440p43b81f33x85c4dc70007165b3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Lu,

On Sat, 18 Jul 2009 11:40:36 +0000, Lu Zhihe wrote:
> Dear all,
> 
>     Attachment is the updated version gm965temp module and patched
> "sensors-detect.gm965temp".
>     For some reasons about safe consideration, gm965temp is not
> considered to merge to hwmon subsystem.
>     So, it is packaged as external module.
> 
>     Now, it supported:
>     PM/GM/GME965, PM/GM45(need tester :-). These chips read temp from
> register TR1/RTR1 .
> 
>     Following Chip sets:
>     G33/Q33/Q35 G41 G43/Q43 G45/Q45,
>     B43_BASE and B43_SOFT_SKU.
>     They all need testers!                      These chips read temp
> from register TSTTP.RELT .
> 
>     Thanks for Tobias Hain helping me test gm965temp.
> 
>     Hope someone can help to test it too, thank you very much!

Some comments on the packaging:

* It's confusing to have both "makefile" and "Makefile". You can put
everything in "Makefile" and it will work fine.

* I can't do anything with sensors-detect.gm965temp. Please provide a
patch just adding support for the GM965 and friends, and I'll apply it.
Please use a recent version of the sensors-detect script as a base (for
example the one in lm-sensors 3.1.1.)

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
