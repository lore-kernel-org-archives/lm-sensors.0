From: Johannes Winkelmann <johannes.winkelmann@gmail.com>
Date: Fri, 20 Jul 2012 15:35:10 +0000
Subject: Re: [lm-sensors] [RFC][PATCH] hwmon: add support for Sensirion C1 sensor
Message-Id: <CAEYbzYuDJLarBULPz1ooSiLhtFsL-YZ-DAxwFW76LnmQ67n5Qw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1342789042-13433-1-git-send-email-johannes.winkelmann@sensirion.com>
	<6190165.D1PKLQQHEK@linux-lqwf.site>
	<CAEYbzYsu_xhXJgbYKPj-rz-d26wTTM98+oyEDWbXMO5VNC5sgw@mail.gmail.com>
	<13845450.qTFZGkrci5@linux-lqwf.site>
In-Reply-To: <13845450.qTFZGkrci5@linux-lqwf.site>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>, Johannes Winkelmann <johannes.winkelmann@sensirion.com>

On Fri, Jul 20, 2012 at 5:14 PM, Oliver Neukum <oneukum@suse.de> wrote:
> On Friday 20 July 2012 17:13:51 Johannes Winkelmann wrote:
>> On Fri, Jul 20, 2012 at 4:03 PM, Oliver Neukum <oneukum@suse.de> wrote:
>
>> > We have dedicated macros for conversion of endianness.
>>
>> Like this:
>>               val = swab16p((__le16 *)buf);
>>               data->temperature = ((21875 * val) >> 13) - 45000;
>>               val = swab16p((__le16 *)(buf+2));
>>               data->humidity = ((15000 * val) >> 13) - 10000;
>
> I was thinking of be16_to_cpu()

Ok, fixed locally; I'll collect some more feedback and will resubmit v2

Thanks,
Johannes
-- 
Johannes Winkelmann
jw@smts.ch

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
