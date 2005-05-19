From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: website/man isadump.html
Message-Id: <OOOjMUei.1108372874.2007900.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050213092410.5a28015e.khali@linux-fr.org>
In-Reply-To: <20050213092410.5a28015e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mark,

On 2005-02-13, Mark D. Studebaker wrote:
> works for me w83627hf and vt1211
> also verified that w/o -k, after some reads, winbond returns 00, via
> returns ff.

So the VIA chips are also affected. Interesting.

The Winbond I tested returned 0xffs, not 0x00s. I guess that what matters
is the way the chip is wired, and maybe not which chip it is.

Thanks,
--
Jean Delvare
