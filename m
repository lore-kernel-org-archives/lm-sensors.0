From: eaut <eaut@boehm.org>
Date: Fri, 06 Feb 2015 07:08:34 +0000
Subject: Re: [lm-sensors] NCT6776 on ASRock Z77 Pro4-M
Message-Id: <CAHBhnhciW7-ucA6jH90AAh8v-n=akvrypaFCwgbAxP8bnap-Dw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAHBhnheRFDe-76vtNWS5B6Nk4sQC7Sz+-CcncKYSsgDOPus1KA@mail.gmail.com>
In-Reply-To: <CAHBhnheRFDe-76vtNWS5B6Nk4sQC7Sz+-CcncKYSsgDOPus1KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

the DMI information is:

BOARD_VENDOR = "ASRock"
BOARD_NAME = "Z77 Pro4-M"
BIOS_VERSION = "P2.00"

thx, Erich


On Fri, Feb 6, 2015 at 4:23 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 02/05/2015 12:48 PM, eaut wrote:
>>
>> Hello,
>>
>> When I recently started to use UEFI "Ultra-FastBoot" on a ASRock Z77
>> Pro4-M
>> board I discovered that fans 3-5 were suddenly missing. After booting in
>> Fast or Normal mode the fans were showing up correctly again. So obviously
>> a firmware bug.
>>
>> After some googling and reading of the Nuvoton NCT6776 data sheet I came
>> up with the following fix:
>>
>>      # enter NCT6776 "Extended Function Mode"
>>      isaset -y 0x2e 0x2e 0x87 0x87
>>      # select logical device HW-MONITOR
>>      isaset -y 0x2e 0x2f 0x07 0x0b
>>      # enable fans 3-5 by setting bits 5-7 in reg 0x30
>>      isaset -y 0x2e 0x2f 0x30 0xe0 0xe0
>>
>> In the process I have created a small script to list all the NCT6776 fan
>> related settings and optionally all NCT6776 GPIO registers. Hopefully it
>> will save someone else the time I had to spend on this issue.
>>
>> https://github.com/eaut/nct6776/blob/master/nct6776-fanpin-info.sh
>>
>> Since quite a few mainboards seem to have firmware related register
>> initialization issues wouldn't it make sense to add an optional module
>> parameter to be able to override register settings when loading the
>> nct6775
>> driver module?
>>
>> Example:
>>
>>         ldev reg  val  mask
>> setreg=0x0b,0x30,0xe0,0xe0,next-sequence,...
>>
>
> I would not want to risk that, but I am not adverse to add code which
> configures the registers as needed for specific mainboards.
>
> What is the exact DMI information for your board (Vendor and board name) ?
>
> Thanks,
> Guenter
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
