From: Rudolf Marek <r.marek@assembler.cz>
Date: Sun, 07 Oct 2007 16:46:01 +0000
Subject: Re: [lm-sensors] [PATCH] coretemp driver and Celeron 430 - works
Message-Id: <47090D49.70105@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4708C611.5040808@assembler.cz>
In-Reply-To: <4708C611.5040808@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jan,

Cool thanks. Please note that the temperature might be more non-physical. So in
your case you have still 55C to overheat. The processor reports temp relative to
trip point, which is "100C" in your case. If it is 85C or 100C works fine on
mobile variants, should not on desktop CPUs.

To sum it up. Even if your temperature is not a real one, you have still 55C to
critical level.

Mark please will you take the patch?

Thanks,

Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
