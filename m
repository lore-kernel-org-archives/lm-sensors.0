From: Sergio.Gelato@astro.su.se (Sergio Gelato)
Date: Thu, 19 May 2005 06:25:34 +0000
Subject: lm-sensors 2.9.0 i2c-ipmi and bmcsensors compile-time issues
Message-Id: <20050131003801.GA679@astro.su.se>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Just discovered a couple of typos in lm-sensors 2.9.0 code:

1) kernel/busses/i2c-ipmi.c, line 183:
that return (with a value, in a void function, with an unreachable "if (error)"
immediately afterwards) is premature. I'm tentatively replacing it with
	error = i2c_add_adapter(&i2c_ipmi_adapter);
which makes a lot more sense in that context.

2) kernel/chips/bmcsensors.c, line 300:
gcc points out that m is not declared (did anyone ever try to compile this?!)
I'm guessing that sd->m was meant.
[OK, this one is already in CVS. But I rediscovered it anyway.]

Also, a comment on kernel/busses/i2c-ipmi.c line 100:
OpenIPMI patch v33 adds an argument to ipmi_request(), so users who've patched
their 2.4 kernels will need to replace the final ", 0)" with ", NULL, 0)"
--- or would a non-NULL value be more appropriate? We'll see. Probably not
worth changing your code yet, but a mention in the installation notes may
be in order.
