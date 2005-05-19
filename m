From: sean@dague.net (Sean Dague)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: libsensors LGPL?
Message-Id: <20040901195453.GB20275@underhill.home.pvt>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

First, I did RTFM.  The current README I have is for lm_sensors 2.8 and
states:

--------------------------------------------------------------------------
This whole package is copyright (c) 1998 - 2002 by Frodo Looijaard and
Philip Edelbrock, except for a few drivers written by
other people. See the individual files for more exact copyright information.  
This package may be distributed according to the GNU General Public License 
(GPL), as included in the file COPYING.

Note that at this moment, libsensors falls under the GPL, not the LGPL.
In more human language, that means it is FORBIDDEN to link any application
to the library, even to the shared version, if the application itself
does not fall under the GPL. This will probably be changed in the future.
In the meantime, you will have to contact us first if you want to do this.
--------------------------------------------------------------------------

The reason that I ask is I work on an open source project, OpenHPI, which is
BSD licensed.  This provides an industry standard interface to hardware
(including sensor data) (more on the project at http://openhpi.sf.net). 
We'd like to be able to make an lm_sensors plugin, however the current
license conflict of BSD vs. GPL would prohibit us from that.

So, the question on hand is is there any near future thoughts on LGPL for
libsensors?  If so, please let me know.  If not, sorry for wasting
everyone's time.

	-Sean

-- 
__________________________________________________________________

Sean Dague                                       Mid-Hudson Valley
sean at dague dot net                            Linux Users Group
http://dague.net                                 http://mhvlug.org

There is no silver bullet.  Plus, werewolves make better neighbors
than zombies, and they tend to keep the vampire population down.
__________________________________________________________________
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040901/9de23a9a/attachment.bin
