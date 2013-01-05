From: Chris Verges <kg4ysn@gmail.com>
Date: Sat, 05 Jan 2013 09:19:17 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] lm73: added 'update_interval' and 'alarm' attributes
Message-Id: <CAG4_upRgVaKiO_Ay85MmiAO2p0fDZDpi4+SLONFRsQLu=1v+QA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1356336669-18722-1-git-send-email-kg4ysn@gmail.com>
In-Reply-To: <1356336669-18722-1-git-send-email-kg4ysn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jan 4, 2013 at 1:19 AM, <linux@roeck-us.net> wrote:
>
> Quoting Chris Verges <kg4ysn@gmail.com>:
>
>> The LM73 supports four A/D conversion resolutions.  The default used by
>> the existing lm73 driver is the chip's default, 11-bit (0.25 C/LSB).
>> This patch enables changing of this resolution from userspace via the
>> temp1_update_interval attribute.
>>
> Hi Chris,
>
> just noticed ... update_interval is a global attribute (update_interval, not temp1_update_interval).
>
> Also, it would be great if you can separate the changes into two patches, one for update_interval (as previously), and one for the alarms. This would help a lot for the review.

Hi Guenter,

Will do.  I think that this next patchset plus any minor fixes will have to be
my last on this for awhile due to other projects beginning to consume my time,
so I'm hoping that we can get to a conclusion soon.

Thanks,
Chris

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
