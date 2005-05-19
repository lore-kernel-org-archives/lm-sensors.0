From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: Python bindings to i2c-dev
Message-Id: <20050102222545.GE17759@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041229050526.GA5431@jupiter.solarsys.private>
In-Reply-To: <20041229050526.GA5431@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi MDS:

> Mark M. Hoffman wrote:
> >After a couple false starts and some hair-pulling, here is a Python module
> >which allows SMBus access through the I2C /dev interface.  I would like to
> >eventually add this to the lm_sensors project.
(...)

* Mark D. Studebaker <mds4@verizon.net> [2004-12-31 18:25:54 -0500]:
> what was the motivation for this?

(1) to learn some of the internals of Python.  (2) to have a quicker
and more nimble way than C code to control (and therefore test) a bus
adapter.  It's very convenient to fire up the Python shell and be able
to slam out bus transactions as one-liners.  As I suggested in another
thread, it would make a good tool for prototyping chip drivers.

> do you have any interesing i2c Python programs to share with us?

Heh, not yet.  As you know, I've been playing with SMBus/ARP in Python...
but not because I think it should be implemented that way.  It's just
the only thing I have in this system that responds to block reads/writes;
and thus the only thing I can use to test those xfers in the new i2c-i801
driver (when I get that far).

Why not port smbus-arp.c to kernel 2.6?  I don't see much point in doing
that, at least not in its present form.  IMHO proper SMBus 2.0 support
would require some slave support in the bus adapter (required by spec),
as well as some coordination and extension of i2c-core to handle the
details.  I'd like to work on that, but I don't have the time right now.

And to answer what has become a FAQ: even though I'm not the biggest fan
of Perl, I do *not* plan on re-writing sensors-detect in Python.  Even
if someone jumped up and volunteered, I would argue against doing it.

However, it might be useful to make a Perl module with similar intent to
these Python bindings, separate from sensors-detect (cut-n-pasted from it
even).

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
