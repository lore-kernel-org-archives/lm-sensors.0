From: danny.backx@skynet.be (Danny Backx)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: my user-space work ? (3d attempt)
Message-Id: <1065811444.1299.21.camel@dell.roesel.skynet.be>
List-Id: <lm-sensors.vger.kernel.org>
References: <200310092001.07946.danny.backx@skynet.be>
In-Reply-To: <200310092001.07946.danny.backx@skynet.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2003-10-09 at 23:11, Greg KH wrote:
> On Thu, Oct 09, 2003 at 08:01:07PM +0200, Danny Backx wrote:
> > I think I've submitted some patches twice. I've been
> > trying to get libsensors and prog/sensors to work
> > based on linux 2.6-test4 and test6. But I don't
> > see my submissions in the support db, nor did
> > I get a reply.
> > 
> > Is anyone interested in this?
> 
> Yes, have you emailed them to us?

No, I didn't discover this link until yesterday. It's somewhat hidden.
I tried copy/pasting this into the support website but apparently
that failed twice.

Anyway. Stuff attached. This is no miracle yet, I've hacked both
libsensors and prog/sensors a bit to get them to talk to sysfs.

I probably need to look into all the stuff tracking bus numbers
and such, I've basically added some #if 0 lines here and there
to get sensors to produce output (even if that output is
currently nonsense for obvious reasons).

I've done this on linux-2.6test4. On test6 the output is rather
empty :
	dell: {32} setenv LD_LIBRARY_PATH `pwd`/lib
	dell: {33} prog/sensors/sensors
	w83627hf
	-i2c--2-ffffffff
	Adapter: Dummy adapter
	Algorithm: Dummy algorithm

Need to look into the reason, but it's probably one of the
hacks that fails now.

I could use help with sorting out the issues with bus numbers
and such, because I am completely new to the lm_sensors source
and this looks rather confusing.

	Danny

P.S. If I'm not helping but delaying you with all this, just
  tell me and I'll wait until you come up with a version that
  works :-)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: diff-from-cvs.gz
Type: application/x-gzip
Size: 5236 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031010/bde06f68/diff-from-cvs.gz
