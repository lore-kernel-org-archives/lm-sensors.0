From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 09 Oct 2005 18:31:51 +0000
Subject: [lm-sensors] Ticket #2030
Message-Id: <434945E0.3090604@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <70FE8182C709BD4F93E33B638E00F463077555@merkur.newtec.de>
In-Reply-To: <70FE8182C709BD4F93E33B638E00F463077555@merkur.newtec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Fe found out that it seems to be a hardware bug in the ali15x3 chip. The
> chip needs a reset when it falls into blocking state. However, the reset
> mechanism currently implemented in the ali15x3 driver does not work since
> the chip does not turn to busy state and keeps idle in our case. We changed
> the driver and now we do a reset when we detect the timeout condition. This
> works fine.

Please can you send a patch so we can take a look and update the driver.
Dont forget to put it inline and do Signed-Off-By stuff.  (see Submitting-Patches for details)

Thanks,

regards
Rudolf
