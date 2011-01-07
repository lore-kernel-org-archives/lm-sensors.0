From: Luca Tettamanti <kronos.it@gmail.com>
Date: Fri, 07 Jan 2011 13:14:21 +0000
Subject: Re: [lm-sensors] Erratic value of MCH temp. (0C),
Message-Id: <AANLkTi=bwPWnbSMZST3tMWZwoSDTskyfGr=bmNNPUUbY@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1294052867.1860.36.camel@Asus5>
In-Reply-To: <1294052867.1860.36.camel@Asus5>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jan 6, 2011 at 10:01 PM, Jean Delvare <khali@linux-fr.org> wrote:
[...]
>> To complicate things the firmware provides both the old and the new
>> ATK0110 interfaces, and the driver selects the old one. The new one
>> seems to have the code to read all the sensors. I'll see what I can
>> do.
>
> Would it make sense to add a module parameter to asus_atk0110 to let
> the user force the interface when both are present? So that the user
> can test the other one and report easily.

Yes, I'm planning to do that. Plus maybe a DMI table to automatically
override the default logic.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
