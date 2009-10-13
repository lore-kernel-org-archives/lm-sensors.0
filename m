From: Luca Tettamanti <kronos.it@gmail.com>
Date: Tue, 13 Oct 2009 13:37:34 +0000
Subject: Re: [lm-sensors] it87 / acpi / DSDT-dump (ASUS P5V2D-MX)
Message-Id: <68676e00910130637u6863bc3fya5716c4b4905d6a1@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <68676e00910130600u39fff342mf5db22c962f895de@mail.gmail.com>
In-Reply-To: <68676e00910130600u39fff342mf5db22c962f895de@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 13, 2009 at 3:23 PM, Manuel Knitza
<manuel.knitza@uni-konstanz.de> wrote:
> Luca Tettamanti schrieb:
>>
>> On Sat, Oct 10, 2009 at 2:58 PM, Manuel Knitza
>> <manuel.knitza@uni-konstanz.de> wrote:
>>>
>>> as being owner of an ASUS P5V2D-MX board, i have the same problems
>>> with it87 that also showed up on the net/lkml.org.
>>
>> Define problem. Are you seeing a higher temperature?
>
> no higher temp; simply not able to load it87 module

Ok, then this is expected. See this FAQ:
http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31

> when i searched the net for a solution i came across
> http://lkml.org/lkml/2009/9/20/43
>
> i started to collect some kind of solutions which are more likely some
> workarounds which i put into this post
> http://forums.gentoo.org/viewtopic-p-6005344-highlight-.html#6005344

pnpacpi shouldn't be overridden. If you want to load the native driver
(it87) then use "acpi_enforce_resources=lax"

> finally i switched from using it87 to asus_atk0110 and upgraded to latest
> lm_sensors.

Ok, does atk0110 work fine?

>>> sry for being too lazy to register for an account on lkml.org.
>>
>> Both lkml and lm-sensors@lm-sensors.org (which is more relevant) lists are
>> open.
>
> as you´re suggesting lm-sensors list, i´m a bit unsure if you were the
> right one to bother with that it87 problem. the first thing that came
> into my mind when i read some posts about that on lkml and seing you
> mailadress kronos.IT@....

(it stands for information technology :P)

> i thought u are one of those guys responsible
> for it8xx. or is that actually the same?

Nope, I'm the maintainer of  asus_atk0110. And lm-sensors is the right
ML (do not strip the CC).

>>> i´m chosing this way to send you a dump of my DSDT.
>>
>> I don't see anything suspicious, please describe what problem you're
>> experiencing.
>
> read sth about faulty dsdt provided by asus. some ressource handling with
> acpi... (dont understand very much about that); well, as my mobo
> like 4, or 5 yrs old, asus won´t be interested into providing some
> bios-update i think. but on the other side im not the only owner of that
> board for sure, so maybe its possible to fix that from kernel/module-
> side

The DSDT is not faulty. The hwmon chip is used by ACPI and hence its
IO ports are marked as reserved. The native drivers used to bind to
the hwmon chip anyway; this might lead to invalid data being read - or
worse (since there are two users touching the chip without any
synchronization).
Starting from 2.6.31 the native drivers are forbidden to bind if the
chip is claimed by ACPI; asus_atk0110 replaces (at least for
monitoring) native drivers on ASUS boards, using the hwmon interface
defined in the DSDT.

So my advise to you is to use asus_atk0110; if you need to directly
control the fans (not possible with the ACPI driver) then use
"acpi_enforce_resources=lax" and load it87 (and do *not* load
asus_atk0110).

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
