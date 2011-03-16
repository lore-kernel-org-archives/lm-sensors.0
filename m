From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Mar 2011 15:59:10 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: Add support for Texas
Message-Id: <20110316165910.3ab482ef@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110302185718.3c0e06dc@endymion.delvare>
In-Reply-To: <20110302185718.3c0e06dc@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Emiliano,

On Tue, 8 Mar 2011 16:36:37 +0100, Emiliano Carnati wrote:
> It make sense...
> 
> Please correct me if I'm wrong. I should:
> 
> - start from Dirk's patch v4

Almost. There is a patch of mine on top of it already, you can get both
patches here:
  ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-hwmon/hwmon-add-support-for-texas-instruments-ads1015.patch
  ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-hwmon/hwmon-ads1015-drop-dynamic-attribute-group.patch
Your own work should go on top of this.

> - create a patch that fixes the bug
> - apply this patch

No longer needed, as I've already merged the fix in the initial patch.

> - create a patch that adds the support for 1115
> 
> It's right?

Yes. Please make sure to run scripts/checkpatch.pl on your patch before
you send it.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
