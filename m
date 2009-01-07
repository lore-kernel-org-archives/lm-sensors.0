From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 07 Jan 2009 21:52:03 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add a driver for the ADT7475
Message-Id: <20090107225203.42b91e8b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080610194818.GA21150@cosmic.amd.com>
In-Reply-To: <20080610194818.GA21150@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Sat, 20 Dec 2008 09:22:33 +0100, Hans de Goede wrote:
> Here is a new version with the comments / review from Matt Roberds taken in to 
> account.

Thank you (and to Jordan and Matt as well) for finishing the driver.
I've just added it to my hwmon tree, so that it goes into linux-next.
I'll push it to Linus as part of my next round of hwmon patches (which
should basically be the adt7475 driver + the k8temp fixes which I still
need to review and test.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
