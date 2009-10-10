From: Kent Liu <kent.liu@linux.intel.com>
Date: Sat, 10 Oct 2009 06:01:18 +0000
Subject: Re: [lm-sensors] [PATCH] coretemp: Add Lynnfield CPU
Message-Id: <20091010060118.GA12489@wliu-linux.bj.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090915021341.GA14957@owl>
In-Reply-To: <20090915021341.GA14957@owl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Rudolf

Yes. I think Huaxu and I can take this, even though I am still on the way 
to acquire enough documents from hardware team. As I have a lot of processors
on hand to test, maybe it's better to gain more coverage in coretemp driver.

Please let me know what I need to do regarding to take the maintainership. 
We are not experienced in doing so.

Thanks,
Kent
On Wed, Sep 16, 2009 at 11:24:51PM +0200, Rudolf Marek wrote:
> Hi,
>
> Looks good. However I would like to see the Documentation/hwmon/coretemp 
> updated too.
>
> Maybe Intel can overtake the driver maintainership because I'm quite 
> struggling to get any info from Intel. Second reason is lack of free 
> time.
>
> Thank you,
>
> Rudolf
>
> Huaxu Wan napsal(a):
>> Add Lynnfield processor support. Lynnfield is a quad-core Nehalem based microprocessor for Desktop market, which is introduced in September 2009.
>>
>> Signed-off-by: Huaxu Wan <huaxu.wan@linux.intel.com>
>> Signed-off-by: Kent Liu <kent.liu@linux.intel.com>
>> ---
>>  drivers/hwmon/coretemp.c |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
>> index 93c1722..a9a21dc 100644
>> --- a/drivers/hwmon/coretemp.c
>> +++ b/drivers/hwmon/coretemp.c
>> @@ -413,11 +413,11 @@ static int __init coretemp_init(void)
>>         for_each_online_cpu(i) {
>>                 struct cpuinfo_x86 *c = &cpu_data(i);
>>
>> -               /* check if family 6, models 0xe, 0xf, 0x16, 0x17, 0x1A */
>> +               /* check if family 6, models 0xe, 0xf, 0x16, 0x17, 0x1A, 0x1E */
>>                 if ((c->cpuid_level < 0) || (c->x86 != 0x6) ||
>>                     !((c->x86_model = 0xe) || (c->x86_model = 0xf) ||
>>                         (c->x86_model = 0x16) || (c->x86_model = 0x17) ||
>> -                       (c->x86_model = 0x1A))) {
>> +                       (c->x86_model = 0x1A) || (c->x86_model = 0x1E))) {
>>
>>                         /* supported CPU not found, but report the unknown
>>                            family 6 CPU */
>> --
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
