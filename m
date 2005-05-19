From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: 1250
Message-Id: <3EF3A4DA.9060505@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200306021011.37032.decibel8@charter.net>
In-Reply-To: <200306021011.37032.decibel8@charter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm glad you were able to apply the patch.

The via686a is on the ISA bus.  That may be changing the "corruption" 
that happens when we attempt to read from /proc.

David, can you please run:

    strace -o /tmp/sensors.strace sensors -s

And then send me (or the list) the file /tmp/sensors.strace that will be 
created.  I'd like to see the system calls and more detail about the 
error before we decide to back out the patch.  It definitely does solve 
a problem for some people...

Thanks,
:v)

DAVID wrote:
>> Do you by any chance have any additional patch to your kernel, such as
>> GRSEC or ACL?
> 
> 
> If your asking me I don't believe so. Even if I do I don't have GRSEC 
> set in the kernel.
> 
> 
> On Fri, 20 Jun 2003 08:35:43 +0200
>  Jean Delvare <khali@linux-fr.org> wrote:
> 
>>
>>> 2)  Installed fine. Tried several things. Still get same error. I
>>> restarted lm_sensors and rebooted. Still:
>>> #sensors -s
>>> via686a-isa-6000: Can't access /proc file for writing;
>>> Run as root?
>>
>>
>> OK, so the patch doesn't work. Or, at least, it doesn't fix *that*
>> problem. Philip, should we remove the fix from CVS?
>>
>> Do you by any chance have any additional patch to your kernel, such as
>> GRSEC or ACL?
>>
>> -- 
>> Jean Delvare
>> http://www.ensicaen.ismra.fr/~delvare/
> 
> 
> <TEXTAREA NAME="Signature" ROWS="4" COLS="60">
> 



-- 
Philip Pokorny, Director of Engineering
Tel: 415-358-2635   Fax: 415-358-2646   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com
