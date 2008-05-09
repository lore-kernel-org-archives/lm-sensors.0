From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 09 May 2008 15:29:36 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Check for 1-register-only
Message-Id: <20080509172936.0db5db75@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080508224145.41cfa3ef@hyperion.delvare>
In-Reply-To: <20080508224145.41cfa3ef@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Achim,

On Fri, 09 May 2008 16:43:19 +0200, achim wrote:
> For sake of completenes here's the result of the dump test.
> (...)
> 0x38: passed b and w dump
> 0x47: b,w and s result in no reply and if i cancle it i get XX's for
> dumps afterwards
> (...)
> 0x6e: only likes s dumps others stop at address 0x91 and result in XX's.
> The datasheet for that chip is available so it might be possible to at
> least detect this chip.

We don't much care about 0x6e at the moment, there is no known hardware
monitoring chip living at this address so it is never probed. Same for
0x38 and, since a few days, 0x47.

(Thanks for the info, though.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
