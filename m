From: achim <achim@ag-web.biz>
Date: Fri, 09 May 2008 16:56:30 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Check for
Message-Id: <1210352190.3498.4.camel@debian-9850.ag-home.muc>
List-Id: <lm-sensors.vger.kernel.org>
References: <1210344199.3543.12.camel@debian-9850.ag-home.muc>
In-Reply-To: <1210344199.3543.12.camel@debian-9850.ag-home.muc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Freitag, den 09.05.2008, 17:24 +0200 schrieb Jean Delvare:
> Hi Achim,

> I see this, and I think I understand why. The address exclusion logic
> assumes that the original list contains _all_ addresses. This is no
> longer the case. When I restricted sensors-detect to only probe
> addresses where are least one hardware monitoring chip is known, I
> forgot about this optimization which turned into a bug. Thanks for
> reporting. This patch should fix it:
> 
> Can you please test it?
> 
> Thanks,

Yeah, the patch works. I tested sensors-detect with all known adresses
of the board excluded and it did not messup the smbus chip.

Afterward i tried it with only 0x4c excluded and the smbus chip still
works. With no exclusions lm75 detection hangs at 0x4c and afterwards i
only get XX's from dumps.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
