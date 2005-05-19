From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:26 +0000
Subject: i2c-keywest & multiple channels
Message-Id: <20011130122643.P5595@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hey Ben, I've done a little bit of work on the i2c-keywest adapter
since a few people got it working under Linux (didn't think the 'fix'
would be to slow it down with delays!  I wonder why the delays aren't
needed in Darwin... hummm ;').

Anyways the current version in CVS does label the bus according to
uninorth or the other.  You can see that in /proc/bus/i2c.  I'd also
like to get other operations going, like 'quick' so probing and other
drivers will work better.  I think the last update I made claimed to
have quick transactions working, but I actually did smbus_byte.. and
not quite correctly.  It shouldn't hurt, though.

The adapter should attach to every compatible bus type reported by OF.
I'm not sure if race conditions are possible or not.  I have yet to
notice possible side effect of such a case if it has happened, but
then again, there isn't much happening on the busses yet.

Anyways, check out the CVS version and let me know if it's closer to
where you wanted to go.  (www.lm-sensors.nu and then go to the bottom
of the download page)


Phil


On Fri, Nov 30, 2001 at 08:57:44PM +0100, Benjamin Herrenschmidt wrote:
> Hi !
> 
> I need to improve the i2c-keywest driver to handle the fact that,
> at least the uninorth implementation of the chip, has more than one
> channel. (That is you can select on which channel a given transaction
> will occur). I need that to drive the thermostats of some laptops
> which are on different channels.
> 
> What do you suggest ? I don't find anything in the I2C API that
> could be used to do that. I could eventually register one interface
> per channel and use a mutex to avoid trying to blast on more than
> one channel at a time; but that would be bloat I beleive.
> 
> Also, what would be the convenient way to find the proper instance
> from the client driver ? A given client driver will actually know
> on which chip (uninorth or keylargo) and on which channel is the
> chip it's looking for. Maybe by building the adapter name in a
> known way ? (chip-name:channel).
> 
> Ben.
> 

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
