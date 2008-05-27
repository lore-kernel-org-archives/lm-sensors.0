From: Ben Dooks <ben@fluff.org>
Date: Tue, 27 May 2008 18:12:07 +0000
Subject: Re: [lm-sensors] [spi-devel-general] Accelerometer,
Message-Id: <20080527181206.GB22585@trinity.fluff.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4832A211.4040206@gmail.com> <20080527164415.GA27584@polina.dev.rtsoft.ru> <20080527165021.GA22585@trinity.fluff.org> <483C4C58.5080301@gmail.com>
In-Reply-To: <483C4C58.5080301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <Jonathan.Cameron@gmail.com>
Cc: Ben Dooks <ben@fluff.org>, spi-devel-general@lists.sourceforge.net, linux-kernel@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>

On Tue, May 27, 2008 at 07:00:56PM +0100, Jonathan Cameron wrote:
> 
> >
> > The two drivers i've seen so far use the input subsystem to report
> > their data to the user. I'm working on an driver for the SMB380 which
> > can be both i2c and spi.
> Yes, the ST accel I'm using (LIS3L02DQ) is like that as well, so we 
> definitely need
> to implement the ability to do this cleanly! 

this would be so much easier to read if word-wrapped to 77 characters
per line.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
