From: Carsten Aulbert <carsten.aulbert@aei.mpg.de>
Date: Wed, 22 Apr 2009 20:27:06 +0000
Subject: Re: [lm-sensors] w83793 related question
Message-Id: <49EF7D9A.8000508@aei.mpg.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <49E45712.6020906@aei.mpg.de>
In-Reply-To: <49E45712.6020906@aei.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi

Rudolf Marek schrieb:
> 1) the board is equipped with some kind of remote management conroller,
> which is also doing transactions on I2C
> 
> Is there some?

Yes there is an IPMI card on these boards. I'm not sure if they use I2C
but I think that would make sense. We are not actively querying values
via the IPMI card, however it does it by itself.

> 
> I would still need to know how often this problem  actually happens.

It seems bursty, e.g. like many times within a second and then its
silent for some time, e.g. one node has this disribution:

n0047:~# dmesg | egrep '(i801_smbus|w83793)' | cut -d. -f 1 | \
tr -d '[' | sort -n | uniq -c
      1     8
      1 25241
      1 26501
      1 53262
      1 123160
      1 132928
    196 137025
      1 144900
      1 156875
      1 198766
      1 229545
      1 266396
      1 280566
      1 285294
      1 286873
      1 298844
      1 312390
      1 318375
      1 337578
     12 367501
      1 380728
      1 422294
      1 433634
      1 444343

second column shows seconds since last boot.

Does this help, or shall I do it on every node and think about a way to
show this in 2d?

Cheers

Carsten

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
