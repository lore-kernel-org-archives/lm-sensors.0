From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 02 Nov 2005 12:05:22 +0000
Subject: [lm-sensors] Running lm-sensors on EPIA 5000 with Debian SARGE 2.6
Message-Id: <ciiXOTvF.1130928737.7508800.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051012133202.9303523324@box1.planbit.co.uk>
In-Reply-To: <20051012133202.9303523324@box1.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Rudolf,

On 2005-11-01, Rudolf Marek wrote:
> VID "something special"
> 1 1 1 1  1.30V
> 1 1 1 0  1.35V
> 0 0 0 0  2.05V

This looks like standard VRM 8.4 to me, nothing special.

> We need to define 2 new VIDs one is something called
>
> IMVP-II (I dont know anything about -I and -III  => will call it 1718
>
> and the that really strange samuel 2 VID codding. => will call it 670
>
> Ideas? Questions?
> If not I will develop the patch.

Sure, add new VRM-like values if needed. We might end up defining
constant for these so that the number do not look like magic.

While you're at it, I think we should do some changes to vid_from_reg: I
think VRM 8.2 was the default for historical reasons, but it's not
safe. We shouldn't have no default. 8.2 should be handled explicitely
as other values are. Any non-zero, non-handled value should trigger a
debug log message. Any non-handled value should result in 0 being
returned. OK?

Thanks,
--
Jean Delvare
