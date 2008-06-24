From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 24 Jun 2008 08:02:46 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/2] hwmon: (lm90) Support ADT7461 in
Message-Id: <20080624100246.7bf872aa@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1213989596-8716-3-git-send-email-ncase@xes-inc.com>
In-Reply-To: <1213989596-8716-3-git-send-email-ncase@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Nate,

On Fri, 20 Jun 2008 14:19:56 -0500, Nate Case wrote:
> Support ADT7461 in extended temperature range mode, which will change
> the range of readings from 0..127 to -64..191 degC.  Adjust the
> register conversion functions accordingly.
> 
> Signed-off-by: Nate Case <ncase@xes-inc.com>
> ---
>  drivers/hwmon/lm90.c |  119 ++++++++++++++++++++++++++++++++++++++------------
>  1 files changed, 91 insertions(+), 28 deletions(-)

This one looks OK to me. Tested OK on my ADM1032.

Note to Mark: Nate's patches to the lm90 driver conflict with the ones
I sent on May 28th:
  http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023250.html
Please disregard both patch sets for the moment. As soon as I get final
patches from Nate, I'll take care of resolving the conflicts, and then
I'll resend a single patch set with all lm90 patches for you to review
and merge.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
