From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Fri, 22 Feb 2013 04:55:12 +0000
Subject: Re: [lm-sensors] [PATCH v3 2/3] ab8500: make res_to_temp tables public
Message-Id: <CAJLyvQxaQ5g1Oh7kR-YnSzknPqbTsDTq5KUANULC1UTyGDuZCg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361442761-2690-3-git-send-email-hongbo.zhang@linaro.org>
In-Reply-To: <1361442761-2690-3-git-send-email-hongbo.zhang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 22 February 2013 08:49, Guenter Roeck <linux@roeck-us.net> wrote:
> On Thu, Feb 21, 2013 at 02:24:23PM -0800, Anton Vorontsov wrote:
>> On Thu, Feb 21, 2013 at 06:32:40PM +0800, Hongbo Zhang wrote:
>> > These NTC resistance to temperature tables should be public, so others such as
>> > ab8500 hwmon driver can look up these tables to convert NTC resistance to
>> > temperature.
>> >
>> > Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
>> > ---
>>
>> For 1/3 and 2/3 patches:
>>
>> Acked-by: Anton Vorontsov <anton@enomsg.org>
>>
>> (Do you need EXPORT_SYMBOL()? You don't use this from modules?)
>>
> I would think so. Also, the variables should be exported through an include
> file.
>
I have these two lines in drivers/hwmon/ab8500.h,
extern struct abx500_res_to_temp temp_tbl_A_thermistor[];
extern int temp_tbl_A_size;
Do you mean this?

Or do you mean we should create a public header file holding all the tables?
Where to place these tables really baffled me, if the current hwmon
driver is acceptable, I will talk to the ab8500_bmdata.c author to
discuss how to re-arrange all the tables, that should be another patch
in future if possible.

> The variable names are quite generic for global variables; we need to find
> something more specific/descriptive.
>
I noticed this too, this original naming isn't so good, there are also
other names like this.
I will rename these two tables I am using this time.

> There is also some overlap with functionality in drivers/hwmon/ntc_thermistor.c.
> Wonder if it would be possible to unify the code.
>
It seems not so easy to unify the code for me, if necessary and
possible, that should be another dedicated patch I think.

> Guenter
>
>> Thanks.
>>
>> >  drivers/power/ab8500_bmdata.c | 8 ++++++--
>> >  1 file changed, 6 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/power/ab8500_bmdata.c b/drivers/power/ab8500_bmdata.c
>> > index f034ae4..53f3324 100644
>> > --- a/drivers/power/ab8500_bmdata.c
>> > +++ b/drivers/power/ab8500_bmdata.c
>> > @@ -11,7 +11,7 @@
>> >   * Note that the res_to_temp table must be strictly sorted by falling resistance
>> >   * values to work.
>> >   */
>> > -static struct abx500_res_to_temp temp_tbl_A_thermistor[] = {
>> > +struct abx500_res_to_temp temp_tbl_A_thermistor[] = {
>> >     {-5, 53407},
>> >     { 0, 48594},
>> >     { 5, 43804},
>> > @@ -29,7 +29,9 @@ static struct abx500_res_to_temp temp_tbl_A_thermistor[] = {
>> >     {65, 12500},
>> >  };
>> >
>> > -static struct abx500_res_to_temp temp_tbl_B_thermistor[] = {
>> > +int temp_tbl_A_size = ARRAY_SIZE(temp_tbl_A_thermistor);
>> > +
>> > +struct abx500_res_to_temp temp_tbl_B_thermistor[] = {
>> >     {-5, 200000},
>> >     { 0, 159024},
>> >     { 5, 151921},
>> > @@ -47,6 +49,8 @@ static struct abx500_res_to_temp temp_tbl_B_thermistor[] = {
>> >     {65,  82869},
>> >  };
>> >
>> > +int temp_tbl_B_size = ARRAY_SIZE(temp_tbl_B_thermistor);
>> > +
>> >  static struct abx500_v_to_cap cap_tbl_A_thermistor[] = {
>> >     {4171,  100},
>> >     {4114,   95},
>> > --
>> > 1.8.0
>>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
