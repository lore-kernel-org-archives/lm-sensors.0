From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 23 Sep 2007 21:30:20 +0000
Subject: Re: [lm-sensors] [patch] don't use functions marked as LEGACY in
Message-Id: <20070923233020.4518a3e8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Bernhard,

On Thu, 20 Sep 2007 14:02:48 +0200, Bernhard Fischer wrote:
> I choose not to have index(), rindex(), bzero(), bcopy() et al in my
> libc since they are marked as legacy in SUSv3.
> The attached patch uses the recommended functions instead.

Patch applied, thanks for your contribution.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
