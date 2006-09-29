From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 29 Sep 2006 08:03:31 +0000
Subject: [lm-sensors] Answer Epox - EPoX EP1308 sensor-chip
Message-Id: <20060929100331.652b422e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <450B14DB.2090505@sh.cvut.cz>
In-Reply-To: <450B14DB.2090505@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

> Maybe I should make my relation to Hans Edgington clear. As you may know 
> I'm a university Computer Science teacher and Hans E. is a student of 
> mine. As part of his / her last year every student must work on a 
> project for 1 day / week during 5 months. Normally the project 
> assignments come from real companies, but when we don't have enough 
> assignments the teacher(s) create assignments for these projects. After 
> seeing the mail from Age Huisman on this I thought it would be a fun 
> project for a student to write a driver for this sensors chip.

Yes, I think this is a good idea, both interesting for the student and
useful for the user waiting for this chip to be supported.

> At first I thought this driver would be much like the uguru driver, but 
> I see now with the superio stuff that it will be somewhat different, 
> what would be a good driver to start with as a skeleton to base this 
> driver on?

There's nothing like the uGuru :p

I'd suggest working off the f71805f driver, as it supports a Fintek
chip so the Super-I/O code should be very similar.

> Also are there datasheets of similar (fintek) superio chips available 
> somewhere, those could be of great help.

The Fintek datasheets are unfortunately not publicly available as far
as I know. But Winbond has good datasheets and the Super-I/O mechanism
is pretty standard, so you can start from there (see
Documentation/hwmon/w83627hf for URLs). Or you can simply look at the
f71805f driver code, I would hope it is clear enough.

BTW the Super-I/O mechanism is essentially based on Intel's LPC
specification, which is publicly available here:
  http://www.intel.com/design/chipsets/industry/lpc.htm
But it's highly technical and you don't really need to know the details
to write a driver.

Hope that helps,
-- 
Jean Delvare

