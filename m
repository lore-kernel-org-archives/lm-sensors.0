From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 12 Sep 2011 17:59:20 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon/f71882fg: Make all fan/pwm attr
Message-Id: <4E6E4878.9090300@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1315563155-15774-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1315563155-15774-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 09/12/2011 07:48 PM, Guenter Roeck wrote:
> On Fri, 2011-09-09 at 06:12 -0400, Hans de Goede wrote:
>> This is a preparation patch for not registering fan/pwm attributes for
>> some fans (rather then register them for all or for none).
>>
>> Signed-off-by: Hans de Goede<hdegoede@redhat.com>
>> ---
>
> Hans,
>
> what tree is your patch series based on ? I tried to apply it to
> mainline for testing but it failed.

Hmm, they apply cleanly for me against a fully up2date checkout of:
git://github.com/torvalds/linux.git

Want me to resend them?

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
