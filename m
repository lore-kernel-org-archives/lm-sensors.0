From: Luca Tettamanti <kronos.it@gmail.com>
Date: Fri, 12 Mar 2010 09:40:48 +0000
Subject: Re: [lm-sensors] Wrong temperatures reported for Core2Duo CPU in
Message-Id: <68676e01003120140j3983387cx47765a304f412a7@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <781687b2e6d2a27726f35a316f5bf821.squirrel@webmail.nodivisions.com>
In-Reply-To: <781687b2e6d2a27726f35a316f5bf821.squirrel@webmail.nodivisions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Wed, Mar 10, 2010 at 7:10 PM, Jean Delvare <khali@linux-fr.org> wrote:
> On Wed, 10 Mar 2010 08:41:52 -0800, lmsensorslist@nodivisions.com wrote:
>> OK, I just tested this, by running the "stress" command for a few minutes,
>> until the coretemp values were 91C and 92C.  I then immediately shut down
>> and went into the BIOS.  Here's the BIOS numbers:
>>
>> 68C CPU Die/Package Temperature
>> 54C Motherboard Temperature
>> 44C Motherboard Temperature
>> 82C ICH Temperature
>> 58C MCH Temperature
>>
>> And here's the same BIOS numbers after sitting there in the BIOS for 10
>> minutes:
>>
>> 63C CPU Die/Package Temperature
>> 50C Motherboard Temperature
>> 44C Motherboard Temperature
>> 83C ICH Temperature
>> 54C MCH Temperature
>>
>> I guess the die temp is the one that corresponds to the CPU?
>
> Yes, it probably comes from the CPU internal sensors, although only
> disassembling the BIOS could tell for sure.

From my experience on Asus boards the "CPU" temperature shown in the
BIOS is usually read from the external monitoring chip, and only
rarely from the CPU itself (using PECI - with a totally wrong tjmax -
sigh).
The ICH temperature is also suspiciously high.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
