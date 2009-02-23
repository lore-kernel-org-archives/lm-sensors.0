From: Alexander Graf <agraf@suse.de>
Date: Mon, 23 Feb 2009 08:51:04 +0000
Subject: Re: [lm-sensors] [PATCH] applesmc: Expose Operating System Key in
Message-Id: <7F323AFD-98C5-40ED-87D7-50EFF86AE175@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1223318477-25365-1-git-send-email-agraf@suse.de>
In-Reply-To: <1223318477-25365-1-git-send-email-agraf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


On 23.02.2009, at 09:47, Jean Delvare wrote:

> On Wed, 15 Oct 2008 10:58:34 +0200, Jean Delvare wrote:
>> Hallo Alexander,
>>
>> I don't know a thing about the applesmc driver, so just a few random
>> comments. Nicolas being the maintainer of this driver, his approval =20
>> is
>> needed before your patch can go upstream anyway.
>>
>> On Mon,  6 Oct 2008 20:41:17 +0200, Alexander Graf wrote:
>>> The AppleSMC is used for various tasks. It allows control over fans,
>>> the backlight, invokes the acceleration interrupt and stores a key,
>>> that is used to decrypt binaries on Mac OS X.
>>>
>>> This key is necessary to receive when virtualizing Mac OS X, but
>>> may not be distributed due to copyright restrictions.
>>>
>>> This patch makes reading this key easy by exporting it via sysfs.
>>>
>>> Signed-off-by: Alexander Graf <agraf@suse.de>
>>> Cc: Nicolas Boichat <nicolas@boichat.ch>
>>> Cc: Jean Delvare <khali@linux-fr.org>
>>> Cc: Ren=E9 Rebe <rene@exactcode.de>
>>> (...)
>
> Alexander, any news from this patch? I never heard you back from you
> since my review. If you are no longer interested in this patch, I'll
> just discard it. If you are still interested, please send an updated
> patch addressing my comments.

Oh phew I almost forgot about it. I'll take your comments into account =20
and send a new one this week :-).

Alex


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
