From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: Binary compatibility issues with libsensors
Message-Id: <3ED8CE7B.5000000@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <87r87igjs6.fsf@watertown.mit.edu>
In-Reply-To: <87r87igjs6.fsf@watertown.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks for the analysis.
Your point is well taken.
I guess it isn't reasonable to ask that other packages be recompiled against our new library?
What is necessary to have two libsensors versions coexist?
Numbering the new version 2.0.0 or is 1.4.0 sufficient?

David Z Maze wrote:
> Hi.  I have a bug report on the Debian lm-sensors package
> (http://bugs.debian.org/191572) complaining that programs compiled
> against the libsensors from lm-sensors 2.6.5 don't necessarily work
> with the libsensors from lm-sensors 2.7.0; the 'sensors' program from
> the lm-sensors distribution is used as an example.  This looks like
> the same problem as the 28 December "'sensors' segfaults" problem on
> the lm-sensors Web page.
> 
> The actual problem is a result of adding the busname field to the
> sensors_chip_name structure in lib/sensors.h.  If programs using the
> library either declare an array of sensors_chip_name, as 'sensors'
> does, or embed sensors_chip_name in a structure, the added field means
> that newer libsensors code will try to read the first word of the next
> data structure as the busname.  The particularly troublesome call here
> is sensors_match_chip(sensors_chip_name, sensors_chip_name); the
> called code expects to find the two structures passed on the stack,
> but with the extra word new code and old code put the two structures
> in different places.
> 
> In turn, this breaks programs that link against the lm-sensors
> libraries.  In Debian, this isn't just the 'sensors' program; there
> are several front-ends that use the library to present hardware status
> information.  The best solution would be to change the library name
> (to, for example, libsensors.so.2) so that both old and new libraries
> could coexist on the system; would you consider this for an lm-sensors
> release?
> 
> Thanks,
> 
