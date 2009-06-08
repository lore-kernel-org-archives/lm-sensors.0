From: Frank Myhr <fmyhr@fhmtech.com>
Date: Mon, 08 Jun 2009 14:05:08 +0000
Subject: Re: [lm-sensors] hwmon-vid driver from linux 2.6.29
Message-Id: <4A2D1A94.6090101@fhmtech.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A0C6BF7.9010107@assembler.cz>
In-Reply-To: <4A0C6BF7.9010107@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> You could contact the motherboard vendor and tell them about the
> problem (the question is "Is VID5 properly routed from CPU to
> IT8716F?") and see what they have to say about this.
> 
> I don't really know how to work around this. I suspect that only the
> late 0Fh family CPUs actually make use of VID5. If I am right then we
> could tweak the hwmon-vid VRM selection table and use 5-pin VID (VRM
> code 24) for some of the 0Fh family CPUs. I don't know where to put the
> limit, and this is fixing the problem where it is not... which is
> likely to cause even more problems on other systems in the future.
> 
> Frank, can you please tell us for which 0Fh family CPU model you did
> need the 6th VID pin decoding originally?

Hi Jean and others,

I'm sorry, that system is currently offline and I (not so) cleverly
didn't back up log files so I don't have kernel-reported cpu info. But
here is hardware spec:

cpu: AMD Athlon X2 64 4850e, ADH4850IAA5DO
mainboard: Gigabyte GA-MA770-DS3, IT8718

-Frank



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
