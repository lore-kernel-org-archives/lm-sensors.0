From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 08 Jan 2009 07:56:57 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add a driver for the ADT7475
Message-Id: <4965B1C9.10009@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080610194818.GA21150@cosmic.amd.com>
In-Reply-To: <20080610194818.GA21150@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
> Hi Hans,
> 
> On Sat, 20 Dec 2008 09:22:33 +0100, Hans de Goede wrote:
>> Here is a new version with the comments / review from Matt Roberds taken in to 
>> account.
> 
> Thank you (and to Jordan and Matt as well) for finishing the driver.
> I've just added it to my hwmon tree, so that it goes into linux-next.
> I'll push it to Linus as part of my next round of hwmon patches

Great, thanks!



  (which
> should basically be the adt7475 driver + the k8temp fixes which I still
> need to review and test.)
> 

I can test the k8temp driver too if you want. I actually have access to 3 
different k8 models. But testing on some of them is easier for me then testing 
on others. I can test without much work from my side on atleast 1.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
