From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:34 +0000
Subject: lm-sensors 2.9.0 i2c-ipmi and bmcsensors compile-time issues
Message-Id: <KX6LnVmZ.1107163175.2408030.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050131003801.GA679@astro.su.se>
In-Reply-To: <20050131003801.GA679@astro.su.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Sergio,

> Just discovered a couple of typos in lm-sensors 2.9.0 code:
>
> 1) kernel/busses/i2c-ipmi.c, line 183:
> that return (with a value, in a void function, with an unreachable "if
> (error)" immediately afterwards) is premature. I'm tentatively replacing
> it with
>	error = i2c_add_adapter(&i2c_ipmi_adapter);
> which makes a lot more sense in that context.

I think you are correct. The Linux 2.6 kernel version of the driver [1]
was fixed in a similar way. Care to send a patch we could apply to
lm_sensors CVS?

> 2) kernel/chips/bmcsensors.c, line 300:
> gcc points out that m is not declared (did anyone ever try to compile
> this?!)
> I'm guessing that sd->m was meant.
> [OK, this one is already in CVS. But I rediscovered it anyway.]

Both the i2c-ipmi and the bmcsensors drivers can only be compiled when
the underlying kernel supports IPMI. I personally don't need it, so I
never happen to compile these drivers, and I suspect that most people
are in the same case. This explains why these drivers are more likely to
contain compilation errors and warnings than the other ones.

The fact that lm_sensors 2.9.0 was released with a bmcsensors driver that
wouldn't even compile is of course a problem, and I will try to at
least compile-test all drivers before the next releases.

> Also, a comment on kernel/busses/i2c-ipmi.c line 100:
> OpenIPMI patch v33 adds an argument to ipmi_request(), so users who've
> patched their 2.4 kernels will need to replace the final ", 0)" with
> ", NULL, 0)" --- or would a non-NULL value be more appropriate? We'll see.
> Probably not worth changing your code yet, but a mention in the
> installation notes may be in order.

I don't know what the extra parameter is for, but the 2.6 version of the
drivers has NULL for it so I guess we can do the same. Looks like it was
actually added in v30, not v33. I searched for a way to check the
version in ipmi.h but there is none. However, at least two defines were
added to that file at the same time the function prototype was changed:
IPMI_LAN_ADDR_TYPE and IPMI_RESPONSE_RESPONSE_TYPE. Maybe we could check
for them and do the correct call? That way the user wouldn't have to
care. I don't really like checking unrelated things but that's the
best we have as far as I can see.

Care to send a patch (for the code, documentation, or both)?

Thanks.

[1] http://bmcsensors-26.sourceforge.net/

--
Jean Delvare
