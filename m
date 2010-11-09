From: Luca Tettamanti <kronos.it@gmail.com>
Date: Tue, 09 Nov 2010 20:15:04 +0000
Subject: Re: [lm-sensors] [06/32] drivers/hwmon/asus_atk0110.c: Use pr_fmt
Message-Id: <AANLkTi=cTAGuCyk4S-1rscbMUmOm_6X43L7hQTBFmL4y@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <506bc745e46020fb99159fd73288d3b0202c99cf.1287556801.git.joe@perches.com>
	<20101109163740.GA14733@ericsson.com>
In-Reply-To: <20101109163740.GA14733@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Joe Perches <joe@perches.com>, Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Tue, Nov 9, 2010 at 5:37 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Wed, Oct 20, 2010 at 06:51:30AM -0000, Joe Perches wrote:
>> Added #define pr_fmt KBUILD_MODNAME ": " fmt
>> Converted printks to pr_<level>
>> Coalesced any long formats
>> Removed prefixes from formats
>>
>> Signed-off-by: Joe Perches <joe@perches.com>
>>
> Applied.
>
> On a side note, I let the long lines go through as long as checkpatch doesn't complain.

I lost sight of the discussion, but I thought that a better solution
was to put the define for pr_fmt in a common header instead of
scattering it in all the drivers.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
