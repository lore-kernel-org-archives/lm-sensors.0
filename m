From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 08 May 2007 09:35:45 +0000
Subject: Re: [lm-sensors] [PATCH] coretemp add more safety checks
Message-Id: <20070508113545.5ca31f4f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4634A411.4030703@assembler.cz>
In-Reply-To: <4634A411.4030703@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

On Sun, 29 Apr 2007 15:56:33 +0200, Rudolf Marek wrote:
> I hope I will have more time from now, here my patch. It adds check for Errata
> AE18 of core processors, which causes values not to update after the CPU deep
> sleeps. Intel claims that the TjMax detection might not work for the Core2, warn
> the users about this.
> 
> I would like to ask anyone using coretemp on notebook to test this patch!
> 
> In case it is ok (haha) here is the kernel stuff:
> 
> Signed-off-by: Rudolf Marek <r.marek@assembler.cz>
> 
> This patch adds detection of AE18 Errata of Core processor and warns
> users that the absolute readings might be wrong for Core2 users.

Your patch:
* Doesn't apply on top of the version of the coretemp driver I have on
  my hwmon stack [1].
* Once manually fixed to apply, fails to compile.

[1] http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/hwmon-coretemp-new-driver.patch

Can you please provide a patch which at least applies and compiles, so
that users have a chance to test it? Other than that, it looks good.
Please resubmit. Thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
