From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 20 Feb 2009 08:25:09 +0000
Subject: Re: [lm-sensors] More information on Gigabyte GA-EX58-UD4P
Message-Id: <20090220092509.76dd20b2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <49986A9C.6000606@gmail.com>
In-Reply-To: <49986A9C.6000606@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dean,

On Thu, 19 Feb 2009 22:10:51 -0800, Dean Loros wrote:
> Thank you for the information Jean---I assumed that the force_id
> option went into /etc/sensors.conf & /etc/sensors3.conf--I inserted
> it in a way I thought was correct & got "Error: Line 1225: Invalid
> keyword"....The line looks like:  options it87 force_id=0x8718

Huu, no, it doesn't go into /etc/sensors3.conf...

> I then tried to include it into /etc/modules & got no response at all...line looks like:
> 
> # Chip drivers
> it87
> i2c-dev options it87 force_id=0x8718
> coretemp

... and presumably not into /etc/modules either, although I am no
Debian specialist.

> So I am at a loss as to where the option should be inserted--there
> is not a modprobe file in Ubuntu--Running the current Jaunty testing
> 9.04 version for x86. Using the stock ubuntu Jaunty kernel--currently
> at 2.6.28.8--don't want to create a .29 kernel due to testing
> requirements. We have to wait until 9.10 testing in two months to
> move to .29.
> 
> Thank you for your time..

Add the following line to either /etc/modprobe.conf or any file under
directory /etc/modprobe.d:

options it87 force_id=0x8718

Then cycle the it87 driver (rmmod it87 && modprobe it87). This should
do the trick.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
