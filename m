From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 20 Nov 2012 08:45:39 +0000
Subject: Re: [lm-sensors] [PATCH 131/493] hwmon: remove use of __devexit_p
Message-Id: <20121120094539.233271a6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1353349642-3677-131-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-131-git-send-email-wfp5p@virginia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Bill,

On Mon, 19 Nov 2012 13:21:20 -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed.

I don't see any value in making this a separate patch from [PATCH
402/493] hwmon: remove use of __devexit. __devexit_p only exists
because __devexit exists, so they should all be removed at once.

More generally, I don't see any point in making separate patches for
__devinit, __devexit, __devinitdata... If we are getting rid of the
whole __dev* section markers then it can all go in a single patch (per
subsystem). This will be much easier to handle that way IMHO.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
