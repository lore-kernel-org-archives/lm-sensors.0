From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: [PATCH 2.6] Documentation for i2c-parport
Message-Id: <20040709215236.GB5907@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040707081936.5f48db6a.khali@linux-fr.org>
In-Reply-To: <20040707081936.5f48db6a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jul 09, 2004 at 07:54:38PM +0200, Jean Delvare wrote:
> > > This also raises a question about Documentation/i2c/i2c-pport.
> > > Should we keep a document about a driver which is not in the kernel
> > > tree (and hasn't even been ported to 2.6 yet)?
> > 
> > No we should not.  Care to send a patch to delete it?
> 
> I'm not sure, I think this job is beyond me ;)
> 
> Signed-off-by: Jean Delvare <khali at linux-fr dot org>
> 
> Erm, do I really have so sign-off a patch which does not add any line?
> :)

Yes, we want to know who to blame for taking stuff away :)

Applied, thanks.

greg k-h
