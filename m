From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: RFC PATCH 2.6 sysfs names: fscher: change div to ripple
Message-Id: <blku619v52o5jipadsm5vtu4ckv192p15p@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <o99t61p4c255uvjrhpavjejblb2r1cdts5@4ax.com>
In-Reply-To: <o99t61p4c255uvjrhpavjejblb2r1cdts5@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali, Philip,

On Wed, 27 Apr 2005 10:32:39 +0200 (CEST), "Jean Delvare" <khali@linux-fr.org> wrote:

>               I would have gone for fanN_ppr for something shorter.

I'll do it this way, the long name was for comment :)  Any driver may 
choose to include the fanN_ppr accessor so that correct reading in 
rpm available from sysfs?  Or is that going too far again? 

>think I remember a Linux 2.4 driver using that name already.

>At any rate, the name fanN_ripple doesn't sound good to me.

Ripple always struck me as an odd name too.

>Note that such patches can only be accepted in Linux 2.6 if an equivalent
>patch is provided for libsensors.

I've done that before, do you want the old name kept like last time too?

Cheers,
Grant.
