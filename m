From: xyzzy@speakeasy.org (Trent Piepho)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: VID specifications
Message-Id: <Pine.LNX.4.04.10204221709250.16907-100000@xyzzy.dsl.speakeasy.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <3CBEB764.C4261708@paradyne.com>
In-Reply-To: <3CBEB764.C4261708@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 19 Apr 2002, Mark D. Studebaker wrote:

> Trent,
> I put programmable VRM support in w83781d in CVS.
> I changed VID from 2 decimal points to 3.
> Please look in doc/vid and kernel/include/sensors_vid.h
> and give it a try.
> 'set vrm 9.0' should work too.
> mds

It looks like everything didn't get commited.  The sensors_vid.h file is
there, but the w83781d.c file is still at rev 1.90 and doesn't use the new
function.


I have a patch for w83781d that will allow for proper initialization and
detection on the tyan dual athlon motherboards without entering the BIOS
first.

It still requires init=0 to be specified, or the machine locks when the driver
is loaded.  I looked at every reference to "init" in the w83781d.c and the
code it triggers, and I can't see any reason for the lockup.  Do you know if
there is any code init triggers that I wouldn't find this way?  There
shouldn't be any reason the temperature/voltage limits can't be initialized
with this board.
