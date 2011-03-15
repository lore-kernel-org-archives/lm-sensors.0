From: Luca Tettamanti <kronos.it@gmail.com>
Date: Tue, 15 Mar 2011 14:01:24 +0000
Subject: Re: [lm-sensors] extreme fan rpms with atk0110
Message-Id: <AANLkTin9HbAxkn_0maLbe13vpYj-npPbB1i=tPd2c26g@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110312212759.3c9e0e56@endymion.delvare>
In-Reply-To: <20110312212759.3c9e0e56@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Mar 12, 2011 at 11:54 PM, Luca Tettamanti <kronos.it@gmail.com> wrote:
> On Sat, Mar 12, 2011 at 11:45 PM, Anders Kullenberg <akullen@swipnet.se> wrote:
>> I have attached what I think is the DSDT, used this method:"sudo cat
>> /sys/firmware/acpi/tables/DSDT > /tmp/DSDT" is that correct?
>
> Yes, that's correct. I'll take a look tomorrow.

I don't see anything suspicious in the ACPI code, but the relevant
method (HWF1) scales the value read from the sensor using the divider
(also read from the monitoring chip) and a built-in table.
Can you identify the chip using sensors-detect?
If possible load the native driver (blacklist asus_atk0110 and boot
with acpi_enforce_resources=lax) and compare the fan readings.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
