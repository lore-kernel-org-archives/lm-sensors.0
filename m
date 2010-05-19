From: "Jeff Rickman" <jrickman@myamigos.us>
Date: Wed, 19 May 2010 18:46:52 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add sch5127 support to dme1737
Message-Id: <17480.199.74.155.50.1274294812.squirrel@webmail.myamigos.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca1001192115u22b07199h1fb4eceff0f795f@mail.gmail.com>
In-Reply-To: <191fb4ca1001192115u22b07199h1fb4eceff0f795f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> Hi Jean,
>
>> Hi Juerg,
>>
>> On Tue, 13 Apr 2010 10:49:15 +0200, Jean Delvare wrote:
>>> On Fri, 9 Apr 2010 10:20:40 -0700, Juerg Haefliger wrote:
>>> > I don't understand your proposal. Could you elaborate?
>>>
>>> I propose that you don't change the value of force_id in the driver.
>>> This value can be set by the user and should be considered read-only by
>>> the driver itself. The resulting code might be slightly larger, but it
>>> is also more correct:
>>>
>>>       /* Skip chip detection if module is loaded with force_id
>>> parameter */
>>>       switch (force_id) {
>>>       case SCH5127_ID:
>>>               data->type = sch5127;
>>>               break;
>>>       case SCH3112_ID:
>>>               data->type = sch311x;
>>>               break;
>>>       default:
>>>               company = dme1737_read(data, DME1737_REG_COMPANY);
>>>               device = dme1737_read(data, DME1737_REG_DEVICE);
>>>
>>>               if ((company = DME1737_COMPANY_SMSC) &&
>>>                   (device = SCH311X_DEVICE)) {
>>>                       data->type = sch5127;
>>>               } else if ((company = DME1737_COMPANY_SMSC) &&
>>>                          (device = SCH5127_DEVICE)) {
>>>                       data->type = sch311x;
>>>               } else {
>>>                       err = -ENODEV;
>>>                       goto exit_kfree;
>>>               }
>>>       }
>>>
>>>       data->name = data->type = sch5127 ? "sch5127" : "sch311x";
>>
>> Any progress with this patch? Would be nice to finally have support for
>> the SCH5127 in kernel 2.6.35.
>
> I sent a revised patch yesterday that you should have in your inbox.
> Waiting for Jeff.
>
> ...juerg

I am building a test system for this experiment; I have all the hardware I
need. It will take a few days, possibly to get done this weekend. Hope to
provide feedback sometime next week. How does that fit into the schedule
for delivering code to include in kernel 2.6.35?

>
>>
>> Thanks,
>> --
>> Jean Delvare
>>



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
