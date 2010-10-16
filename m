From: "Jeff Rickman" <jrickman@myamigos.us>
Date: Sat, 16 Oct 2010 07:40:11 +0000
Subject: Re: [lm-sensors] f71882fg on Jetway NC92-330-LF
Message-Id: <49590.75.142.173.238.1287214811.squirrel@webmail.myamigos.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTi=abRLHVUXTz=fwAiWcD1sUgdPjKxz3xY92j=8O@mail.gmail.com>
In-Reply-To: <AANLkTi=abRLHVUXTz=fwAiWcD1sUgdPjKxz3xY92j=8O@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

> On Thu, Oct 14, 2010 at 10:39 AM, Алексей Сычев
> <taviscaron@gmail.com> wrote:
>> Hello.
>> I have Jetway NC92-330-LF and interesting in your post:
>> http://lists.lm-sensors.org/pipermail/lm-sensors/2010-April/028281.html
>>
>> I have compiled attached driver, but it still does not work:
>>
>> f71882fg: Found f71862fg chip at 0x290, revision 1
>> ACPI: resource f71882fg [io  0x0290-0x0297] conflicts with ACPI region
>> IP__
>> [??? 0x00000295-0x00000296 flags 0x5f]
>> ACPI: If an ACPI driver is available for this device, you should use it
>> instead of the native driver
>>
>> Maybe i can help in something (testing, log, etc)? Working driver will
>> be
>> very good.
>
> There was a bit of round trip with the user to adjust the driver. I'm
> attaching a version that was confirmed working, but it's an ugly ugly
> ugly hack. In fact if Jean sees this he's going to ask my maintainer
> badge back :P
> Keep the conversation on the list, we might get some insight on how to
> proceed with this...
>
> Luca
> _______________________________________________

I have this exact board and tested this driver on Fedora Core 12 and
Fedora Core 13 "i386" code. It does work; I had to learn how to compile
kernel modules, but the effort was worth it.

I do not have that exact test setup right now; it might take a few days to
set things up again due "real life issues". If you require further
testing, please let me know.




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
