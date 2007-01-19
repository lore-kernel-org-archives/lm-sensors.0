From: david@ad5ey.net (David Holl)
Date: Fri, 19 Jan 2007 22:27:33 +0000
Subject: [lm-sensors] Asus P5B Deluxe / Winbond 83627DHG
Message-Id: <6b59d5890701191427j72b2cb5l64b1d5b9af8ce296@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
In-Reply-To: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Yeah, my distro only has 2.10.1 as well.  (Gentoo -- hopefully they'll put
it up under ~x86 soon... /me wonders how to become the Gentoo package
maintainer for lm_sensors...)

Try 2.10.2 from http://www.lm-sensors.org/wiki/Download


On 1/19/07, Daniel Ceregatti <daniel at ceregatti.org> wrote:
>
>  I have 2.10.1, which is the highest version my distro has. Should I apply
> a patch? Grab the latest SVN?
>
> Daniel
>
> David Holl wrote:
>
> Hey Daniel, what version of lm-sensors do you have?  I found the "sensors"
> command in lm-sensors 2.10.1 didn't know how to show the w83627dhg info,
> so I submitted a fix which should be in 2.10.2.  :)
>
> - David
>
> On 1/19/07, David Hubbard <david.c.hubbard at gmail.com> wrote:
> >
> > Update on the issue:
> >
> > It looks like the new w83627ehf driver (with patch for official dhg
> > support) works fine. His sensors is reporting the following:
> >
> > ------------------
> > w83627dhg-isa-0290
> > Adapter: ISA adapter
> >
> > coretemp-isa-0000
> > Adapter: ISA adapter
> > temp1:       +58?C  (high =   +85?C)
> >
> > coretemp-isa-0001
> > Adapter: ISA adapter
> > temp1:       +57?C  (high =   +85?C)
> > ------------------
> >
> > (Note lack of any temperature info from w83627dhg)
> >
> > But /sys/class/hwmon/hwmon0/device/temp1_input temp2_input temp3_input
> > seem OK. Well ... temp1_input = -65000. That's not right.
> >
> > So sensors should be displaying something. That's as far as we got
> > tonight.
> >
> > David
> >
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070119/4ddff372/attachment.html 
