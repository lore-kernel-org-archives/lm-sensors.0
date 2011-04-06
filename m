From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 06 Apr 2011 10:09:55 +0000
Subject: Re: [lm-sensors] Any idea to support Fintek F71808A
Message-Id: <4D9C3BF3.3080305@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BANLkTinFxPuMEuM-ZOandTcnAwxeWKgx5g@mail.gmail.com>
In-Reply-To: <BANLkTinFxPuMEuM-ZOandTcnAwxeWKgx5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 04/06/2011 10:54 AM, D.B. Tsai wrote:
> Hi
>
> Since Fintek F71808E seems to be quick closed to F71808A, I copy
> everything related to 71808E into F71808A in the f71882fg.c. The code
> can be compiled, but when I try to modprobe, I got the error message
> "FATAL: Error inserting f71882fg
> (/lib/modules/2.6.38-8-server/kernel/drivers/hwmon/f71882fg.ko):
> Device or resource busy
> "
>
> Anything I should notice?

The F71808A is not 100% compatible with the F71808E, at it has less
voltage inputs for one. I've not yet checked the entire datasheet of
the F71808A to see if there are any other differences.

I saw further down the thread that your BIOS ACPI tables / code claims
to own the io ranges which are used for the hwmon part. May I ask on which
kind of device / motherboard you have a F71808A, is this in a laptop or
on a regular motherboard, and which model?

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
