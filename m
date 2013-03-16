From: Francesco Lavra <francescolavra.fl@gmail.com>
Date: Sat, 16 Mar 2013 10:28:39 +0000
Subject: Re: [lm-sensors] [PATCH v4 2/3] ab8500: re-arrange ab8500 power and temperature data tables
Message-Id: <51444957.9070500@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1362730411-11112-3-git-send-email-hongbo.zhang@linaro.org>
In-Reply-To: <1362730411-11112-3-git-send-email-hongbo.zhang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 03/12/2013 10:44 AM, Hongbo Zhang wrote:
> On 12 March 2013 13:38, Guenter Roeck <linux@roeck-us.net> wrote:
>> On Fri, Mar 08, 2013 at 04:13:30PM +0800, Hongbo Zhang wrote:
>>> This patch moves the data tables from driver/power/ab8500_bmdata.c to a common
>>> header file include/linux/power/ab8500.h, so that other modules such as ab8500
>>> hwmon can use these data. This patch also renames these variable names to
>>> eliminate CamelCase warnings from checkpatch.pl, and adds const attribute to
>>> these data.
[...]
>> I don't think it is a good idea to define static variables in an include
>> file.
>>
> Hmm.. this part is more difficult than the hwmon itself from my point of view,

I think Guenter meant leaving the data tables inside a .c file in
drivers/power/, but declaring them as extern variables in a public
header file in include/linux/power/, instead of having extern
declarations in the importing driver (hwmon).
This is the standard practice when variables need to be shared between
drivers.

Regards,
Francesco

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
