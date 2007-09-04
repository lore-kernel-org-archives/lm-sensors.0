From: Bernhard Seibold <bernhard@seibold.ws>
Date: Tue, 04 Sep 2007 20:55:00 +0000
Subject: Re: [lm-sensors] k8temp, BE-2350 CPU
Message-Id: <1188939300.2598.40.camel@klappe.intranet>
List-Id: <lm-sensors.vger.kernel.org>
References: <46BAABD3.5000103@assembler.cz>
In-Reply-To: <46BAABD3.5000103@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Di, 2007-09-04 at 20:53 +0200, Rudolf Marek wrote:
> Are you sure those are correct? The datasheets suggest that you need first
> extract the 0.25 degC from two lowest bits and THEN subtract 49.
> 
> Your code does it first. Your method will work only if AMD made a mistake in
> documentation. Are you sure?

You're right, it should be (raw * 250) - 49000, as M. G. Berberich also
pointed out to me.

This means the original formula should have worked, so either the
documentation is wrong, or the sensors are broken (as someone at the AMD
forums claims).


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
