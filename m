From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: Call for 2.9.0
Message-Id: <20041209173235.GD3775@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041208224836.7794b56c.khali@linux-fr.org>
In-Reply-To: <20041208224836.7794b56c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark:

(cc'ed Brian also)

* Mark D. Studebaker <mds4@verizon.net> [2004-12-09 11:01:36 -0500]:
> What Brian discovered is that an i2c bus mux implementation requires a 
> nolock version
> of some functions. Think about how the bootstrap works:
> 	Bus gets added
> 	Mux chip found
> 	Sub busses get added (but can't because lock still held - hang)
> So that's what the (first half of) i2c-core patch does. Get rid of the 
> leading '__', rename to xxx_nolock,
> and export them so that the virtual driver can implement the bootstrap.
> 
> It's not a big change. Maybe there's a way to avoid it, though... I don't 
> know.

Well... why can't you do the sub-bus creation in pca954x_attach_adapter()
(after the call to i2c_detect) ?  This gets rid of all the locking problems,
and IMHO makes more sense w.r.t. the respective function names anyway.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
