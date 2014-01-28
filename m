From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 28 Jan 2014 07:46:31 +0000
Subject: Re: [lm-sensors] Kernel 3.13 breaks pwmconfig and fancontrol
Message-Id: <52E76057.3040507@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1390857566.34222.YahooMailNeo@web140002.mail.bf1.yahoo.com>
In-Reply-To: <1390857566.34222.YahooMailNeo@web140002.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 01/27/2014 11:22 PM, Jean Delvare wrote:
> Hi John, Guenter,
>
> On Mon, 27 Jan 2014 14:22:51 -0800 (PST), John wrote:
>>> The above log refers to hwmon1/pwmX and hwmon1/fanX_input,
>>> yet the errors refer to hwmon1/device/pwmX and
>>> hwmon1/device/fanX_input. So there is an obvious mismatch.
>>> How does the actual configuration file look like ?
>>
>> I deleted /etc/fancontrol* and rebuilt again under 3.13 (it is attached after I edited it).  It now works.  I am not sure what I did the first time through.  Sorry for the noise to the list.
>
> It's not only noise, the problem is real. Thanks for reporting it early
> so we have a chance to fix it before it hits too many users.
>
> Guenter, you did update quite a few hwmon drivers lately and as a
> consequence their attributes moved from hwmonN/device to hwmonN. While
> libsensors already knows how to deal with this, fancontrol does not. So
> the change is likely to break many fancontrol user setups out there,
> which is not good.
>
> I think we need to teach fancontrol about this change and have it look
> at the new place automatically whenever referenced attributes are
> missing at the old place.
>

You are right. There is a secondary problem, though: Depending on the system,
hwmon modules may be loaded in different order. What is hwmon0 at one boot
may be hwmon1 at the next boot. It would be nice if fancontrol could check
for the name of a hwmon device instead of its path to fix that problem.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
