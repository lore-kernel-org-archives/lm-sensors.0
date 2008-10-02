From: "Jean-Marc Spaggiari" <jean-marc@spaggiari.org>
Date: Thu, 02 Oct 2008 16:28:40 +0000
Subject: Re: [lm-sensors] Looking for IT8720 datasheet.
Message-Id: <79c9d4530810020928w42165b2if39ca302bc74cca@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <79c9d4530810020825r79de9817g6933f6cab1d414c1@mail.gmail.com>
In-Reply-To: <79c9d4530810020825r79de9817g6933f6cab1d414c1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Thanks for your reply.


Hi Frank,

Did you get a chance to work on IT8720? I have modify the
sensors-detect script to return it87, and also modify it87.c to handle
the IT8720 as any other IT87 chipset, and it seems to work pretty
fine. It's fine for the FANs and the temp, but I'm not 100% sur for
the voltage.

in0:         +0.00 V  (min =  +0.00 V, max =  +4.08 V)   ALARM
in1:         +3.02 V  (min =  +0.00 V, max =  +4.08 V)
in2:         +3.42 V  (min =  +0.00 V, max =  +4.08 V)
in3:         +3.01 V  (min =  +0.00 V, max =  +4.08 V)
in4:         +1.22 V  (min =  +0.00 V, max =  +4.08 V)
in5:         +2.62 V  (min =  +0.00 V, max =  +4.08 V)
in6:         +2.59 V  (min =  +0.00 V, max =  +4.08 V)
in7:         +3.01 V  (min =  +0.00 V, max =  +4.08 V)
in8:         +3.38 V


I didn't get the +12 or -5 or others. I was able to get it one time,
and no more. Any idea?

Thanks,

JM

2008/10/2 Jean Delvare <khali@linux-fr.org>:
> Hi Jean-Marc,
>
> On Thu, 2 Oct 2008 11:25:27 -0400, Jean-Marc Spaggiari wrote:
>> Does any one have the IT8720 datasheet? In ticket #2343,
>> http://www.lm-sensors.org/ticket/2343 sound like the datasheet is now
>> available ("We have a datasheet now.").
>
> We have it but it's not public yet, so we can't redistribute it.
>
>> Is there a way to get this datasheet? I'm building a patch for it87.c.
>> It's working pretty fine with my motherboard, but I would like to
>> double check with the datasheet before submiting the patch to LKML.
>
> Please get in touch with Frank Myhr (Cc'd), who is supposedly working
> on this already. Please do not duplicate the work here. Ideally, if
> Frank is done with the code, you could give it a public review, and
> then the code can be merged.
>
> Patches should be submitted to the lm-sensors list rather than LKML.
> While we still do not have a hwmon subsystem maintainer, you are more
> likely to find reviewers and testers on the lm-sensors list than on
> LKML.
>
> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
