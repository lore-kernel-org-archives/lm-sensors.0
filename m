From: Luca Tettamanti <kronos.it@gmail.com>
Date: Thu, 02 Dec 2010 20:39:49 +0000
Subject: Re: [lm-sensors] asus_atk0110 causes mouse and keyboard freeze in
Message-Id: <AANLkTimMbBZrnK8ty4xi9P9G+PP0tvSEAJfS-gEs=hF9@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4CF7B282.10007@verizon.net>
In-Reply-To: <4CF7B282.10007@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Dec 2, 2010 at 3:51 PM, Billy DeVincentis <billydv1@verizon.net> wrote:
> I know there have been some discussions on this matter with this driver
> previously but it would seem that in this kernel version the problem if it
> had been fixed in any earlier versions, has returned.

It was never debugged actually; the tester reported lockups even
without the module loaded...

> I have clearly
> pinpointed this to be the problem. No matter what else is set in the bios,
> if this module gets loaded and is turned on in the bios (Asus Utilities, if
> 3rd party utilities are chosen there is no asus Hardware monitoring
> support), the mouse and keyboard WILL freeze.

Only keyboard and mouse are involved or is the whole system locked up?
Can you access the PC using the network?

> What if anything can I do to try to help you debug this?

If you have network access I'll think something :)
Are you able to compile a patched kernel?

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
