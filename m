From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: CVS tests report
Message-Id: <20030611182218.GF25649@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030606183514.2e884183.khali@linux-fr.org>
In-Reply-To: <20030606183514.2e884183.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jun 07, 2003 at 02:30:21PM -0400, Mark D. Studebaker  wrote:
> I think i2c-proc is fixed. Please test.
> 
> I've added several updates to the home page and the download page
> in the last few days.
> On the download page we already have a warning in bold that CVS is under 
> "active development" which is intended as a warning.
> 
> On your issue with matroxfb_maven unresolved symbols,
> we unfortunately are no longer compatible with i2c modules in stock 2.4 
> kernels,
> due to struct changes adding owner and removing inc_use and dec_use.
> You definitely don't want i2c drivers from a 2.4 kernel compiled-in or
> loaded as modules
> 
> Let's discuss what to do about this - some possiblilities:
> We can back out the struct changes...
> We can add big warnings to the release and work on submitting a 2.4 
> patch....
> We can try and require a very recent 2.4 kernel...
> We can include a patch to a recent 2.4 kernel to convert all i2c drivers...
> We can include some compatibility code...
> 
> Would anybody like to work on a patch for 2.4 for submission to Marcelo?

If someone makes it up, I'd be glad to review it and send it off to him.

thanks,

greg k-h
