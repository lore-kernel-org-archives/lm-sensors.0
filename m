From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 04 Mar 2014 05:15:31 +0000
Subject: Re: [lm-sensors] How values are populated in sysfs enteries in LM73 sensor
Message-Id: <53156173.7050101@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAAi8uRzZizJk0Kk2zXhySG7zNdW6BwtPWJxhDJ9WnzK5xS0ThQ@mail.gmail.com>
In-Reply-To: <CAAi8uRzZizJk0Kk2zXhySG7zNdW6BwtPWJxhDJ9WnzK5xS0ThQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 03/03/2014 08:36 PM, Romanic Dean wrote:
> Thanks Jean but doubt is because of this data sheet
>
Please don't top-post.

> http://www.st.com/st-web-ui/static/active/jp/resource/technical/document/=
application_note/CD00079564.pdf<https://legacy.aricent.com/OWA/redir.aspx?C=
=E7rMQdCIsEe5h1I8xjn4nfrwpkv6CtFIOVJ_ZzqMu_GSLT6DEkWx_bxJe_XdhaG5aieI22_WnS=
o.&URL=3Dhttp%3a%2f%2fwww.st.com%2fst-web-ui%2fstatic%2factive%2fjp%2fresou=
rce%2ftechnical%2fdocument%2fapplication_note%2fCD00079564.pdf>
>
Cool link. Points to something behind a firewall afaics.
Jean, the initial link works.

>
> Where sensor application senses and log the temp. into EEPROM.
>
The AN describes how to use a microcontroller (not running Linux)
to access a temperature sensor (not LM73) and store the retrieved
data in an EEPROM.

What does that have to do with the LM73 driver in Linux ?

Guenter

> Thanks
>
>
>
> On Mon, Mar 3, 2014 at 1:33 PM, Jean Delvare <jdelvare@suse.de> wrote:
>
>> On Mon, 3 Mar 2014 10:58:21 -0800, Romanic Dean wrote:
>>> Hi all
>>>
>>> I am going through LM73 sensor implementation and wanted to know
>>> how different entries in sysfs is populated .
>>>
>>> I can see max and min temp. values are hard coded in code itself
>>>
>>>   #define LM73_TEMP_MIN           (-256000 / 250)
>>> #define LM73_TEMP_MAX           (255750 / 250)
>>>
>>> But what about the current temp. values ,how it is populated?
>>>
>>> Is it read from EEPROM and then populated into sysfs entry temp_input1?
>>>
>>> Can anyone let me know these values are populated and what is role of
>>> EEPROM here?
>>
>> What makes you think there is any EEPROM involved?
>>
>> You keep asking vague questions, we can't really help you.
>>
>> The datasheet is available:
>> http://www.ti.com/product/LM73
>>
>> The source code is available:
>>
>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/driv=
ers/hwmon/lm73.c
>>
>> The driver documentation is available:
>>
>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Docu=
mentation/hwmon/lm73
>>
>> The sysfs interface documentation is available:
>>
>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Docu=
mentation/hwmon/sysfs-interface
>>
>> A brief introduction to user-space tools is available:
>>
>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Docu=
mentation/hwmon/userspace-tools
>>
>> So please read all of these. If you still have question, feel free to
>> ask, but in a clear way so that we can understand.
>>
>> --
>> Jean Delvare
>> SUSE L3 Support
>>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
