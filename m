From: Jeff Rickman <jrickman@myamigos.us>
Date: Wed, 06 Jul 2011 00:14:30 +0000
Subject: Re: [lm-sensors] Where are all the sensors?
Message-Id: <4E13A8E6.2080502@myamigos.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <4E0B52A6.1070402@yahoo.co.uk>
In-Reply-To: <4E0B52A6.1070402@yahoo.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 7/5/2011 3:54 PM, DB wrote:
> On 07/05/2011 10:37 PM, Luca Tettamanti wrote:
>> On Tue, Jul 5, 2011 at 9:45 PM, DB<Freddog_de@yahoo.co.uk> wrote:
>>> [ 21.121981] f71882fg: Found f71889fg chip at 0x600, revision 21
>>> [ 21.122030] ACPI: resource f71882fg [io 0x0600-0x0607] conflicts with
>>> ACPI region HMOR [mem 0x00000605-0x00000606 pref disabled]
>>> [ 21.122037] ACPI: If an ACPI driver is available for this device, you
>>> should use it instead of the native driver
>>
>> This means that the BIOS is claiming the hwmon chip for itself;
>> starting from 2.6.31 Linux started enforcing this claim, see
>> http://lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31.
>>
>>
>> Asus exposes the hardware monitoring data trough an ACPI interface. If
>> you send me a copy of /sys/firmware/acpi/tables/DSDT I'll see if
>> there's something usable.
>>
>> Luca
>>
>
> Hi Luca,
>
> I tried cat /sys/firmware/acpi/tables/DSDT & got a lot of characters all
> over the page, nothing really readable.... ls -l gives
> ls -l /sys/firmware/acpi/tables/DSDT
> -r--------. 1 root root 0 Jul 5 22:42 /sys/firmware/acpi/tables/DSDT
>
> Here's the last page of the file:
>

[..snip..]

>
> Is there some other way I ought to have looked at the file???
>
> Thanks for your help!!!
>
> Dave
>

DSDT is "binary" so "cat" will not work. When I need a copy of DSDT I do 
the following:

cp /proc/acpi/dsdt /home/jeff

The "ls -al /home/jeff" shows me a file called DSDT in that directory.

Then I can attach that DSDT file to an email or whatever....

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
