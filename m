From: Karsten de Freese <karsten@maxi-dsl.de>
Date: Tue, 26 Oct 2010 22:32:54 +0000
Subject: Re: [lm-sensors] looking for help with W83795ADG
Message-Id: <4CC75716.8080805@maxi-dsl.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101022135607.6996731s0m2gcr48@webmail.mnet-online.de>
In-Reply-To: <20101022135607.6996731s0m2gcr48@webmail.mnet-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi Jean,

to close the topic on jc42, using

temp1_crit_hyst

did the trick!


thanks again -

Karsten


Am 26.10.2010 22:30, schrieb Jean Delvare:
>
> There's a trick: temp1_max_hyst exists but is read-only.
> temp1_crit_hyst is writable, set it and the same delta will be applied
> to temp1_max_hyst (relative to temp1_max, obviously.) The reason is
> that there's only one register in the chip to store the delta, and it
> applied to both limits.
>
>    


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
