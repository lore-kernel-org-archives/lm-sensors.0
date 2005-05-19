From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: No subject
Message-Id: <Pine.LNX.4.58.0503282217140.21101@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.33.0111200151170.1364-100000@home.apu.edu>
In-Reply-To: <Pine.LNX.4.33.0111200151170.1364-100000@home.apu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

> I can understand your feelings and complaint absolutely, I'm sorry for
> the trouble and obstacles brought you. I will discuss with my managers
> about it and express your meaning, I think we may improve it in our
> future cooperation.
> Thank you!

Thank you too for good coorporation.

I created some paper for your "responsible manager" staff.
Please forward it to them.

Needs of opensource software development model
on fields of system monitoring
-----------------------------------------------

Most of motherboard manufacturers do not support the hardware monitoring
capabilities of their products in free operating systems (or simply
other than Windows). Thus, open projects were created to build
support of the hardware monitoring chips "on their own".

On the Linux platform project lm-sensors created unified infrastructure and
framework to support different hardware monitoring chips and busses. In mean
time new chips or busses support is handled by members of lm-sensors project.
They are working for free, or sometimes someone supports their work by
donating the hardware, in many cases not the chip makers but frustrated
third parties that are willing to support this project. Cooperation with
manufactures was limited to evaluation board donations or datasheet
support.

We are glad that Winbond decided to work on support of new chips with us,
directly supporting our project with new driver. However to enhance our
future cooperation it is essential to understand specific needs of
open source development.

* Free access to documentation
Our source code is not proprietary, under license conditions anyone can fix
or modify the source code. Chip driver maintenance implies access to chip
documentation. Without that future maintenance of driver is not possible.

* Free access to SMBus host documentation
Our drivers are build upon transport layer provided by other drivers for
SMBus (System Management Bus). It is essential that documentation to this SMBus
host chip is also accessible. We do not need whole southbridge documentation
we just need to know the way how to speak with SMBUS host. Please try to
convince some chipset makers about this, specially NVIDIA, SiS and ALI. Most
of registers is done same way in all chipset following ACPI standart, but
it is essential to know what is done differently.

* Support from motherboard manufacturers
This is very crucial and anticipatory point. There is no cooperation these
days. When motherboard manufacturers follows recommended values of resistors
nets, conversion formulas can be gained from datasheet. End users are happy
that our project is supporting their workstations or company servers instead
of "no support" from motherboard manufacturer. But from time to time
motherboard maker decides to use other components resulting in unknown
conversion formulas. Motherboard manufacturers do not want to disclose
information about the formulas or simply do not respond. This is very
strange behavior, we created our project to support different kind of
hardware and indirectly we are supporting motherboard manufacturers products
by our work. We can't understand that this simple thing is not understood.

* Additional obstacles set by motherboard manufactures
Some created proprietary monitoring interfaces or their own ASIC and they
do not want to disclose documentation to this chips. Some are playing hide
and seek.

Infamous examples:

Abit created their uGuru (in fact programmed Winbond IC), they do not want to
disclose information even to "closed source" companies. Bad luck, we can
only tell to growing Linux userbase - avoid them

ASUS created their own proprietary ASIC chips, however their programming
interface is very very close to Winbond so our driver was developed on
"guesswork". We do not support new chips with no documentation today.
Unfortunately we can't drop support for already supported ones even if
it's a pain.

ASUS is even more creative, they started to hide SMBUS host, later they
start to hide "well known" monitoring chips, result is that we cannot
help much with this to end users. Complaints to ASUS do not work.

Summary
-------
Please try to explain the motherboard companies that they have unique
opportunity to have support of their monitoring chips in Linux with no
additional cost to them, when they will communicate with us and provide
documentation that is essential to support their motherboard.

Please try to explain to chipset makers that we really need parts of
documentation of their southbridge to be able to implement SMBUS host
driver. We do not need full datasheet only small part of it.

When it is not possible to disclose the chip documentation to public we
would like to have a possibility to members of our project to have
shared access to the documentation.

Thank you,

Lm-sensors team.
