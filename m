From: Philip Pokorny <ppokorny@penguincomputing.com>
Date: Thu, 01 May 2008 17:55:48 +0000
Subject: Re: [lm-sensors] [PATCH 03/10] hwmon: (lm85) Drop dead code
Message-Id: <481A0424.4030309@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080412195552.421b4a28@hyperion.delvare>
In-Reply-To: <20080412195552.421b4a28@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Juerg,
>
> On Wed, 30 Apr 2008 21:52:45 -0700, Juerg Haefliger wrote:
>   
>> Wow, sure a lot of unused junk. The patch looks good but doesn't apply 
>> cleanly over the revised patch 02/10. Could you please refresh and 
>> resend it?
>>     
>
> Sure, here you go:
>
> Drop a lot of useless register defines, conversion macros, data structure
> members and update code. All these register values were read from the
> device but nothing is done out of them, so this is all dead code in
> practice.
>   
The code to use all of those registers was posted in 2004:

http://lists.lm-sensors.org/pipermail/lm-sensors/2004-August/008563.html

But was apparently not picked up because there was an objection to the 
size of the patch?

The patch was streamlined to try and match the "standard" for PWM 
control (which doesn't map to the LM85 registers very well) and reposted:

http://lists.lm-sensors.org/pipermail/lm-sensors/2004-September/009059.html

but without the additional functionality unfortunately.

Wouldn't the better course of action be to add the accessors for these 
tuneables rather than remove the functionality from the driver? Of 
course, that means that I probably need to do the work, but I don't have 
the time to do this right now.

So could I ask that we *not* remove this "dead" code, but leave it in 
for now so that when someone does get around to adding the accessor 
functions, they won't have to submit a patch to reverse this "dead" code 
elimination?

Thanks,
Phil P

-- 
Philip Pokorny, RHCE, Chief Arch. & Sr. Dir. HW & Field Eng.
Tel: 415-954-2823   Cell: 415-370-0835
Fax: 415-954-2899   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
