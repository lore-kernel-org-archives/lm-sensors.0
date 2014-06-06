From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 06 Jun 2014 07:23:26 +0000
Subject: Re: [lm-sensors] Driver for PC87372
Message-Id: <20140606092326.103cce5c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADxL3QmF1q5wmSX=YCCTUc_BREXp2F4khHKdZPTPPuXFUtjLcg@mail.gmail.com>
In-Reply-To: <CADxL3QmF1q5wmSX=YCCTUc_BREXp2F4khHKdZPTPPuXFUtjLcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter, Michael,

On Thu, 5 Jun 2014 19:18:43 -0700, Guenter Roeck wrote:
> On Mon, Jun 02, 2014 at 02:17:43PM -0600, Michael P Dixon wrote:
> > I am interested in obtaining a driver for the PC87372 chip. sensors-detect
> > lists it as 'to be written'. I understand that since it is such an old chip
> > that it could be very low priority, if it has a priority at all. What kind
> > of an effort would it take to produce this driver? The devices page says: *A
> > driver has been requested, will be developed upon donation of a board. *What
> > are the specifics of this? What kind of board? Any feedback is appreciated.
>
> presumably that was supposed to mean a board with the chip on it.

Correct. Any donation is welcome, but giving a board with the right
chip additionally allows for driver testing.

> Even with a board, I for my part would not have time for writing a driver.
> Given the age of the chip, my expectations for finding someone to write
> a driver would be quite low. Any chance doing it yourself ?

Well, before anyone spends time writing a driver, Michael should ensure
that such a driver is really needed. All previous investigations of
PC87372 user cases came to the conclusion that this chip was not used
for monitoring, and instead a dedicated monitoring chip was connected
to the SMBus.

So, Michael, I suggest that you run sensors-detect again. When you reach
the SMBus probing question, the default answer will be "no", say "yes"
instead. Odds are that the script will find some LM85-compatible chip
on the SMBus and loading the lm85 driver will enable hardware
monitoring on your system.

If I am correct, I will update the sensors-detect script to change the
SMBus probing default to "yes" whenever a PC87372 is detected.

-- 
Jean Delvare
http://jdelvare.nerim.net/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
