From: Luca Tettamanti <kronos.it@gmail.com>
Date: Mon, 15 Feb 2010 16:08:17 +0000
Subject: Re: [lm-sensors] ATK0110 on older Asus board
Message-Id: <68676e01002150808u6da9b8t30dccdc989559f31@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <52ae42fa1001140656w17e9e219lad760a0687db6b20@mail.gmail.com>
In-Reply-To: <52ae42fa1001140656w17e9e219lad760a0687db6b20@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Feb 15, 2010 at 4:31 PM, frollic nilsson <frollic@gmail.com> wrote:
> On Fri, Feb 12, 2010 at 11:05 AM, Luca Tettamanti <kronos.it@gmail.com> wrote:
>> On Thu, Feb 11, 2010 at 9:10 PM, frollic nilsson <frollic@gmail.com> wrote:
>>> On Thu, Feb 11, 2010 at 5:25 PM, Luca Tettamanti <kronos.it@gmail.com> wrote:
>>>> On Thu, Feb 11, 2010 at 04:36:53PM +0100, frollic nilsson wrote:
>>>>
>>>> Ok, this means that ACPI core is not even calling the add method.
>>>> I guess that I can happen if _STA reports that the device is not functional.
>>>
>>> with the extra code inserted, I get a AIDI = 1 in the logs
>>
>> As I suspected the device is disabled by the BIOS (AI-whatever is the
>> commercial name of the hwmon features, I guess AIDI = AI DIsable).
>> You should try and see if there's a relevant option in the BIOS setup
>> screen (btw, is there a monitoring page? does it work?)
>
> Yeah, I got the cpu temp and fan RPMs displayed in BIOS.

Nothing to enable the hwmon or "AI-something"?
What about the voltages? Do you see them? Is "Vcore" is spelled all upper case?

> Parts from the messages log file (I grep:ed for "ACPI"), I restarted
> the systenm three days ago:

> Feb 12 22:41:28 atlantis kernel: ACPI: I/O resource w83627ehf
> [0x295-0x296] conflicts with ACPI region HWRE [0x290-0x299]
> Feb 12 22:41:28 atlantis kernel: ACPI: If an ACPI driver is available
> for this device, you should use it instead of the native driver
> Feb 12 22:51:12 atlantis kernel: ACPI: I/O resource w83627ehf
> [0x295-0x296] conflicts with ACPI region HWRE [0x290-0x299]
> Feb 12 22:51:12 atlantis kernel: ACPI: If an ACPI driver is available
> for this device, you should use it instead of the native driver
> Feb 12 22:51:43 atlantis kernel: ACPI: I/O resource w83627ehf
> [0x295-0x296] conflicts with ACPI region HWRE [0x290-0x299]
> Feb 12 22:51:43 atlantis kernel: ACPI: If an ACPI driver is available
> for this device, you should use it instead of the native driver

The resources are reserved even if the ATK0110 device itself is disabled, weird.
This looks like a BIOS bug to me: the device is explicitly disabled,
but ACPI still clams the ioports for the monitoring chip.
I'm not sure how to handle this mobo, but clearly it's safe to use
acpi_enforce_resources=lax and load the native driver.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
