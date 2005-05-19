From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: libsensors LGPL?
Message-Id: <20040903100853.M86746@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040901195453.GB20275@underhill.home.pvt>
In-Reply-To: <20040901195453.GB20275@underhill.home.pvt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> First, I did RTFM.  The current README I have is for lm_sensors 2.8 and
> states:
> 
> --------------------------------------------------------------------------
> This whole package is copyright (c) 1998 - 2002 by Frodo Looijaard 
> and Philip Edelbrock, except for a few drivers written by other 
> people. See the individual files for more exact copyright 
> information.  This package may be distributed according to the GNU 
> General Public License 
> (GPL), as included in the file COPYING.
> 
> Note that at this moment, libsensors falls under the GPL, not the LGPL.
> In more human language, that means it is FORBIDDEN to link any application
> to the library, even to the shared version, if the application itself
> does not fall under the GPL. This will probably be changed in the future.
> In the meantime, you will have to contact us first if you want to do 
> this.
> --------------------------------------------------------------------------
> 
> The reason that I ask is I work on an open source project, OpenHPI,
>  which is BSD licensed.  This provides an industry standard 
> interface to hardware
> (including sensor data) (more on the project at 
> http://openhpi.sf.net). We'd like to be able to make an lm_sensors 
> plugin, however the current license conflict of BSD vs. GPL would 
> prohibit us from that.
> 
> So, the question on hand is is there any near future thoughts on 
> LGPL for libsensors?  If so, please let me know.  If not, sorry for wasting
> everyone's time.

The problem was already discussed:
http://archives.andrew.net.au/lm-sensors/msg04415.html
http://archives.andrew.net.au/lm-sensors/msg06413.html
http://archives.andrew.net.au/lm-sensors/msg07873.html

And as a result the part you quoted from the README file has been updated, and
now reads:

-----------------------
Note that libsensors falls under the GPL, not the LGPL.  In more human
language, that means it is FORBIDDEN to link any application to the
library, even to the shared version, if the application itself does not
fall under the GPL.
-----------------------

This is not going to change because it would require all former contributers
to agree on the change, and it's a bit late for that.

At any rate, libsensors needs complete rewriting to be freed from
chip-specific code for the Linux 2.6 driver. I don't have much time at the
moment to do it (and lack some knowledge about config file parsing as well)
but anyone doing it may release it under the LGPL, which would let anyone link
against it.

-- 
Jean Delvare
http://khali.linux-fr.org/
