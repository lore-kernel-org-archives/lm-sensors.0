From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 02 Dec 2010 21:50:35 +0000
Subject: Re: [lm-sensors] asus_atk0110 causes mouse and keyboard freeze in
Message-Id: <1291326635.2406.6.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <4CF7B282.10007@verizon.net>
In-Reply-To: <4CF7B282.10007@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2010-12-02 at 15:39 -0500, Luca Tettamanti wrote:
> On Thu, Dec 2, 2010 at 3:51 PM, Billy DeVincentis <billydv1@verizon.net> wrote:
> > I know there have been some discussions on this matter with this driver
> > previously but it would seem that in this kernel version the problem if it
> > had been fixed in any earlier versions, has returned.
> 
> It was never debugged actually; the tester reported lockups even
> without the module loaded...
> 
> > I have clearly
> > pinpointed this to be the problem. No matter what else is set in the bios,
> > if this module gets loaded and is turned on in the bios (Asus Utilities, if
> > 3rd party utilities are chosen there is no asus Hardware monitoring
> > support), the mouse and keyboard WILL freeze.
> 
> Only keyboard and mouse are involved or is the whole system locked up?
> Can you access the PC using the network?
> 
> > What if anything can I do to try to help you debug this?
> 
> If you have network access I'll think something :)
> Are you able to compile a patched kernel?

Some information on the web indicates that the problem may be fixed by
updating the Asus BIOS to the latest version. This supposedly helped on
ASUS P7P55D-E Pro and ASUS P5K Pro MB.
Someone else suggested to add "acpi=force irqpoll" to the linux command
line.

Seen on https://bugs.launchpad.net/linux/+bug/585765?comments=all.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
