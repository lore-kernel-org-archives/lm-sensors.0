From: com.ea@tinet.org (Carlos Olalla =?iso-8859-1?Q?Mart=EDnez?=)
Date: Tue, 20 Mar 2007 09:33:48 +0000
Subject: [lm-sensors] [PATCH] w83627hf: Convert to a platform driver
Message-Id: <1075.140.93.65.31.1174383228.squirrel@webmail.tinet.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070311100154.89c57cb0.khali@linux-fr.org>
In-Reply-To: <20070311100154.89c57cb0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hey guys

I am going to take a look to it again and will repost the patch soon.
In order to not to make the same errors, could you please point me to a
lm-sensors driver with pwm
clock interface which follows the standard?

Regards
Carlos

On Tue, 13 Mar 2007 07:43:27 +0100, you wrote:

>Hi Guillaume,
>
>On Mon, 12 Mar 2007 16:16:19 +0100, Guillaume Millet wrote:
>> Jean Delvare a ?crit :
>> > Convert the w83627hf driver from the nonsensical i2c-isa hack to a
>> > regular platform driver.
>>
>> About this driver, w83627hf, Carlos Olalla proposed a patch in order to
>> adds support for pwm clock selection and pwm clock scaling, but this one
>> was not accepted :
>> http://article.gmane.org/gmane.linux.drivers.sensors/10841.
>
>That patch wasn't acceptable because it did now follow our standard
>sysfs interface. File naming was wrong, and more importantly, the
>values were raw register values instead of frequencies expressed in Hz.
>
>> Since, I haven't seen a patch for pwm clock scaling. Is someone working
>> on this feature ?
>
>I don't think so, I did not see any post or patch about this for months.


