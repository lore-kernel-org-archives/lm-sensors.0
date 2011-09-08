From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 08 Sep 2011 21:02:06 +0000
Subject: Re: [lm-sensors] Fintek F71862FG Super IO Sensors only shows
Message-Id: <4E692D4E.6050201@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAPtvKsNGD2fY1Fo7BSLRqVVU+92Rh0YyfMbdD2FBFpu=bHhCng@mail.gmail.com>
In-Reply-To: <CAPtvKsNGD2fY1Fo7BSLRqVVU+92Rh0YyfMbdD2FBFpu=bHhCng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 09/08/2011 10:35 PM, Jean Delvare wrote:
> On Thu, 08 Sep 2011 22:32:22 +0200, Hans de Goede wrote:

<snip>

>> I guess the BIOS only setups fan 1 and the *cough* brilliant *cough* BIOS
>> developers decided to just write 00 as value for the other fans, sigh.
>>
>> There are really 2 things we can do here:
>> 1) Overwrite the BIOS settings, tricky, could do this with a module option
>> 2) Instead of not binding the driver at all, allow the driver initialization
>> to continue normally, but don't register the pwm interface. This requires
>> some thinking wrt modifying the code a bit though.
>>
>> 1 is a really bad idea IMHO, so I'll think a bit about doing 2.
>
> And of course option 0, to start with, is to check for a BIOS update
> for the board in question, and report to the vendor if no BIOS fix is
> available yet.

I'm afraid that is very wishful thinking, but it makes sense to
try a BIOS update first. Daniel, can you see if there is one and
if it helps?

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
