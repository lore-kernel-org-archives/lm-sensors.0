From: Luca Tettamanti <kronos.it@gmail.com>
Date: Mon, 08 Mar 2010 21:34:49 +0000
Subject: Re: [lm-sensors] Upgraded my old Debian box's Kernel from 2.6.30 to
Message-Id: <68676e01003081334l6479c3edg603ea30e383f200d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100305222015.GR11436@alpha.zimage.com>
In-Reply-To: <20100305222015.GR11436@alpha.zimage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 8, 2010 at 10:17 PM, Jean Delvare <khali@linux-fr.org> wrote:
> On Mon, 8 Mar 2010 21:57:25 +0100, Luca Tettamanti wrote:
>> On Sat, Mar 6, 2010 at 1:02 AM, Luca Tettamanti <kronos.it@gmail.com> wrote:
>> >> I am scared to use the lax method since it is not recommended. Is there
>> >> another way to show the datas safely? Or do I have to use this trick or
>> >> live without them?
>> >
>> > Asus provides an ACPI interface for accessing the sensors in a safe
>> > way; I don't know what it's used on MSI boards, but I can take a look:
>> > please send me a dump of the DSDT table
>>
>> Nothing interesting in the DSDT; the hwmon chip is used only for
>> reading a temperature (TZ).
>> I think you can use "acpi_enforce_resources=lax", there not other ways
>> to access the sensor data.
>
> If you do, please make sure to blacklist the ACPI "thermal" driver.

Hum, I'd rather live with the race condition. The thermal driver is
also responsible for controlling the cooling state.
Would it be totally horrible to use acpi_ex_{enter,exit}_interpreter
inside hwmon code to serialize execution?

L

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
