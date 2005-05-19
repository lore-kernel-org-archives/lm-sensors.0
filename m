From: miles.lane@gmail.com (Miles Lane)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: Who should I write to about this OOPS in 2,6,11-mm3?
Message-Id: <a44ae5cd050321185947448028@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <a44ae5cd05031416392e3addd5@mail.gmail.com>
	 <200503180702.42247.adaplas@hotpop.com>
	 <20050317154226.24c1f8f8.akpm@osdl.org>
	 <200503180754.21258.adaplas@hotpop.com>
	 <20050321184011.78808b8d.akpm@osdl.org>
In-Reply-To: <20050321184011.78808b8d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, LM Sensors <sensors@stimpy.netroedge.com>

Yes, I just did.  I used the .config options I mentioned earlier.  I
am currently testing the suggested patches and options offered by the
sensors developers.

BTW, I am cross posting because I am not sure how often the LM Sensors
folks read the linux-kernel list.  Please don't reply to both lists.

    Miles


On Mon, 21 Mar 2005 18:40:11 -0800, Andrew Morton <akpm@osdl.org> wrote:
> "Antonino A. Daplas" <adaplas@hotpop.com> wrote:
> >
> > FYI, the original topic of this thread, though, was an oops in
> >  i2c_add_driver() as mentioned in this thread:
> >
> >  http://marc.theaimsgroup.com/?l=linux-kernel&m1076667232062&w=2
> >
> >  Unfortunately, nobody can reproduce this oops.
> 
> Miles, are you still able to reproduce the i2c_add_driver() oops in
> 2.6.12-rc1 or 2.6.12-rc1-mm1?
> 
> Thanks.
>
