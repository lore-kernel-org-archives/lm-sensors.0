From: arno@natisbad.org (Arnaud Ebalard)
Date: Wed, 24 Apr 2013 20:33:24 +0000
Subject: Re: [lm-sensors] [PATCHv1 2/3] hwmon: Add documentation for g762 driver
Message-Id: <87haiv8y97.fsf@natisbad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1366753420.git.arno@natisbad.org>
 <24acd174f829d211f5d4c1b8631ffc3f8dd97910.1366753420.git.arno@natisbad.org>
 <20130424173216.GA1073@roeck-us.net>
In-Reply-To: <20130424173216.GA1073@roeck-us.net> (Guenter Roeck's message of
 "Wed, 24 Apr 2013 10:32:16 -0700")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Olivier Mouchet <olivier.mouchet@gmail.com>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, Jean Delvare <khali@linux-fr.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Simon Guinot <simon.guinot@sequanux.org>

Hi,

Guenter Roeck <linux@roeck-us.net> writes:

> On Wed, Apr 24, 2013 at 12:06:08AM +0200, Arnaud Ebalard wrote:
>> 
>> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
>> ---
>>  Documentation/hwmon/g762 |   67 ++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 67 insertions(+)
>>  create mode 100644 Documentation/hwmon/g762
>> 
>> diff --git a/Documentation/hwmon/g762 b/Documentation/hwmon/g762
>> new file mode 100644
>> index 0000000..5015829
>> --- /dev/null
>> +++ b/Documentation/hwmon/g762
>> @@ -0,0 +1,67 @@
>> +Kernel driver g762
>> +=========
>> +
>> +This documentation is based on G760a one, GMT G762 datasheet available
>
> G760a ? If this refers to Documentation/hwmon/g760a, I think it is just
> confusing.
>
>> +at http://natisbad.org/NAS/ref/GMT_EDS-762_763-080710-0.2.pdf (used
>> +for the development of the driver) and sysfs bindings described in
>
> I would hope that you used the data sheet for the driver ;), but that
> information does not add much if any value here. I would suggest
> to drop it. Just point to the data sheet.
>
>> +  fan1_gear_mode: fan gear mode. Supported values are 0, 1 and 2. Default
>> +            value is 0. The value is a characteristic of the system
>> +            and a higher value can be set for more precisely control
>> +            fans with a high rotation speed. Note that this affects the
>> +            measurable speed range, not the read value.
>> +
> This attribute no longer exists.

All thoses will be fixed in v2.

a+

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
