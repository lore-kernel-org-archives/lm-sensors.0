From: tnuro@yahoo.com.au (TN)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: ticket 1415 - some ambiguities solved
Message-Id: <3FA59819.7050605@yahoo.com.au>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

I've had a bit of a play with the chip, and here's the results:



1) the offset temperatures register values ARE indeed added to the 
actual temperature readings by the chip itself, so the winbond docs are 
correct in the way you were reading them.
2) the offset temperature register values are in celsius increments as I 
guessed.
3) the offset temperature registers are 2's complement, so the 0xfe was 
indeed indicating an adjustment of -2C as discussed in the last email.

I verified this by writing values into the offset registers, and 
observed what the effect was on the temperature readings.

So we've cleared those abiguities up. Now we need to do some research in 
what values are supposed to be going into the offsets.

cheers
-Trevor.


