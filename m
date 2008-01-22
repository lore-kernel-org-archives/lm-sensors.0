From: Uwe Hermann <uwe@hermann-uwe.de>
Date: Tue, 22 Jan 2008 11:20:08 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Small W83627EHF comment	fix
Message-Id: <20080122112008.GB5515@greenwood>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080118215449.GA26080@greenwood>
In-Reply-To: <20080118215449.GA26080@greenwood>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Sat, Jan 19, 2008 at 05:40:47PM +0100, Jean Delvare wrote:
> We can probably go even further. The w83627ehf driver says that 0x885x
> corresponds to the W83627EHF and 0x886x corresponds to the W83627EHG.
> While the datasheet doesn't mention anything like this, it seems to be
> correct on all chips I (and others) have checked. For example my
> W83627EHG has ID 0x8868.
> 
> So we could have 2 entries in sensors-detect, one for the W83627EHF/EF
> and one for the W83627EHG/EG. It would be more precise, and it also has
> the advantage that the mask(s) would be narrower. What do you think?

Yeah, why not. We cannot be 100% sure, but it sounds like a reasonable
assumption. But I'd add a comment in the script which says that this
is just an educated guess.


Uwe.
-- 
http://www.hermann-uwe.de  | http://www.holsham-traders.de
http://www.crazy-hacks.org | http://www.unmaintained-free-software.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
