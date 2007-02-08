From: forest@alittletooquiet.net (Forest Bond)
Date: Thu, 08 Feb 2007 19:49:10 +0000
Subject: [lm-sensors] VT1211 sensors.conf: other CPUs?
Message-Id: <20070208194910.GE18906@storm.local.network>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

There appears to be some fresh new material with regard to the VT1211 in
sensors.conf now that this chip is officially supported.  I'll quote from
sensors.conf:

--------------------------------------------------------------------------------
# The temperature calculations are of the form
#    compute tempX  (@ - Offset) / Gain, (@ * Gain) + Offset
#
# The following are the gain and offset values as recommended by VIA
#   Diode Type      Gain    Offset
#   ----------      ----    ------
#   Intel CPU       0.9528  88.638
#                   0.9686  65.000  *)
#   VIA C3 Ezra     0.9528  83.869
#   VIA C3 Ezra-T   0.9528  73.869
#
# *) These are the values from the previous sensors.conf. I don't know
# where they came from or how they got derived.
#
# The VT1211 internal temperature (temp2) is scaled by the driver
# and doesn't need to be adjusted here.

    compute temp1  (@ - 73.869) / 0.9528,  (@ * 0.9528) + 73.869
--------------------------------------------------------------------------------

So, it appears that the gain factor is a property of the VT1211, and that the
offset is a property of the CPU.  On to my question...

What is the preferred method for adding support for other CPUs?  The Ezra cores
aren't shipping anymore, so most EPIA boards (i.e., most boards using this Super
I/O chip) have Nehemiah cores of one kind or another.  It would seem there are
two options:

1. Get the appropriate CPU documentation from VIA, if available.
2. Try to measure the die temperature by approximation from some surface
   temperature.  Take some data points, and estimate the offset.
3. Really wing it, and take a trial-and-error approach, nudging the offset
   iteratively until the resulting temperature results look reasonable.

I am not inclined to belive that the documentation mentioned in (1) is widely
available, or that it exists at all.  Is (2) feasible?  (3) is obviously not a
great way to go, but if anyone has suggestions for increasing accuracy I'm all
ears.

Any assistance would be appreciated; I have access to a variety of boards
utilizing this chip.  I would be more than happy to contribute information I am
able to pick up.

thanks,
Forest
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Digital signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070208/3887f90f/attachment.bin 
