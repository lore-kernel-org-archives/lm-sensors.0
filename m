From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 13 Jul 2012 11:25:12 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: s3c-hwmon: Use devm_kzalloc instead of kzalloc
Message-Id: <CAK9yfHwUU1pMLg_eXvPf_i83e+VAL15bGtPFadFH3FwyJt+9XA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1342170388-5682-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1342170388-5682-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 13/07/2012, Jean Delvare <khali@linux-fr.org> wrote:
> On Fri, 13 Jul 2012 14:36:28 +0530, Sachin Kamat wrote:
>> This makes the code simpler as explicit freeing is not needed.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> ---
>>  drivers/hwmon/s3c-hwmon.c |    7 ++-----
>>  1 files changed, 2 insertions(+), 5 deletions(-)
>>
>
> I'm afraid Guenter was faster:
>
> http://git.kernel.org/?p=linux/kernel/git/groeck/linux-staging.git;a=commitdiff;ho66b055060eee17b4c0c18f2d5c1efa04682e11

Oops.. :)
I did not find it in the linux-next tree.. hence was not aware..

>
> --
> Jean Delvare
>


-- 
With warm regards,
Sachin

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
