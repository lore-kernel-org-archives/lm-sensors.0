From: Daniel J Blueman <daniel.blueman@gmail.com>
Date: Sun, 20 Sep 2009 22:21:19 +0000
Subject: Re: [lm-sensors] strange values when reading sensors
Message-Id: <6278d2220909201521i7a162042g5eaafc90518f94b1@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <0bf096687409de1be8dadc8082376124.squirrel@webmail.fast-mail.nl>
In-Reply-To: <0bf096687409de1be8dadc8082376124.squirrel@webmail.fast-mail.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Sep 20, 2009 at 11:14 PM, Sander <san@fast-mail.nl> wrote:
> Hi,
>
> I see some strange values when i read the mainboard sensors, some of theme
> are in ALARM.
> I have 4 questions about this, maybe someone can explain this?
>
> 1) Why does this happen and what values should i trust?
> 2) Why are there 2 sensors and what parts do they control?
> 3) Where can i find the reference from the output? like temp1= for example
> cpu temp2= mainbord, etc...

Your motherboard BIOS may setup the chip incorrectly or incompletely.

> 4) My mainboard is a SuperMicro "X6DVL-EG2" with kernel
> "2.6.30.5-43.fc11.i586" (FC11), do i need to set the
> "acpi_enforce_resources=lax" parameter at boot to ensure system stability?

No.

Thanks,
  Daniel
-- 
Daniel J Blueman

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
