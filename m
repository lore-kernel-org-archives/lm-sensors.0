From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 12 Jul 2005 11:43:40 +0000
Subject: [lm-sensors] Patches Doubt
Message-Id: <8aUEAh3v.1121161075.5127750.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <42D2FDEF.6020504@feitoza.com.br>
In-Reply-To: <42D2FDEF.6020504@feitoza.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Marcelo,

On 2005-07-11, Marcelo Feitoza Parisi wrote:
> I used only time_after() macro, but I was looking better to my patches
> and I've found that maybe it would introduce bugs. I was thinking if it
> is necessary to use time_after and time_before together, or something
> like time_between.

No, your three patches are correct. Unfortunately they will not apply
as-is due to the driver files being moved to a different place in the
source tree, but I'll take care about that.

Thanks for these cleanup patches, this is much appreciated.

--
Jean Delvare
