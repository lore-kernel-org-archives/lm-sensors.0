From: Andreas Hartmann <andihartmann@01019freenet.de>
Date: Wed, 19 Sep 2012 16:11:29 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon, fam15h_power: Tweak runavg_range on resume
Message-Id: <5059EEB1.70200@01019freenet.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120919104553.GF4663@alberich>
In-Reply-To: <20120919104553.GF4663@alberich>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Andreas,

Jean Delvare wrote:
> Hi Andreas,
> 
> On Wed, 19 Sep 2012 12:45:53 +0200, Andreas Herrmann wrote:
>>
>> The quirk introduced with commit
>> 00250ec90963b7ef6678438888f3244985ecde14 (hwmon: fam15h_power: fix
>> bogus values with current BIOSes) is not only required during driver
>> load but also when system resumes from suspend. The BIOS might set the
>> previously recommended (but unsuitable) initilization value for the
>> running average range register during resume.

I'm waiting for the V2 for testing. Is this ok for you?

Thanks for your patch,
kind regards,
Andreas Hartmann


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
