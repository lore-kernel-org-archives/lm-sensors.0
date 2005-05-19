From: dhoffman_98@yahoo.com (David Hoffman)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: I have information on Winbond W83627EHF Chip
Message-Id: <20050209211241.60503.qmail@web50702.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
In-Reply-To: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Well, again, I'd be happy to do any testing you want me to do, but
unfortunately, I don't know enough to be able to help with writing the
drivers.

--- Jean Delvare <khali@linux-fr.org> wrote:

> > OK here's the latest. It looks like we are making progress.
> > 
> > Now when I scan the ISA bus, I get this:
> > Probing for `Winbond W83627EHF'
> >   Trying address 0x0290... Success!
> >     (confidence 8, driver `to-be-written')
> > 
> > Then under Super I/O sensors:
> > Probing for `Winbond W83627EHF Super IO Sensors'
> >   Success... found at address 0x0290
> > 
> > But under Secondary Super I/O:
> > Probing for `Winbond W83627EHF Super IO Sensors'
> >   Failed! (skipping family)
> 
> Alright, finally what I expected :)
> 
> Tests are finished for now, sensors-detect is W83627EHF aware. Next
> step
> would be to write the driver itself, but this is much more work, of
> course.
> 
> -- 
> Jean Delvare
> 



		
__________________________________ 
Do you Yahoo!? 
Meet the all-new My Yahoo! - Try it today! 
http://my.yahoo.com 
 
