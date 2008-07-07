From: Rudolf Marek <r.marek@assembler.cz>
Date: Mon, 07 Jul 2008 08:49:40 +0000
Subject: Re: [lm-sensors] AMD K10 Driver progress
Message-Id: <4871D8A4.7060902@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4870E7C0.8030900@jive-videos.net>
In-Reply-To: <4870E7C0.8030900@jive-videos.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rob,

> I'm new to the list, but having googled and searched the list archives, 
> I cant see any mention of the AMD K10 since april and wondered what the 
> current status is ?

Status is still the same.

1) no thermal datasheet - no known TControlMAX  - we need this because the 
temperature it measures is non-physical.

2) Some? Maybe all revisions of Phenoms have some problem with digital sensors. 
What is your cpuid of your cpu?

cat /proc/cpuinfo

or even better please mail here the output of cpuid utillity.

Thanks,
Rudolf


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
