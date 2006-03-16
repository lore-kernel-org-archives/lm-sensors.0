From: gregkh@suse.de (Greg KH)
Date: Thu, 16 Mar 2006 23:47:22 +0000
Subject: [lm-sensors] i2c-virtual in 2.6?
Message-Id: <20060316234722.GB24527@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1D5ED714-FC68-4E82-9619-15C62CBED628@kgala.com>
In-Reply-To: <1D5ED714-FC68-4E82-9619-15C62CBED628@kgala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Mar 16, 2006 at 05:39:06PM -0600, Kumar Gala wrote:
> 
> On Mar 16, 2006, at 5:29 PM, Greg KH wrote:
> 
> >On Thu, Mar 16, 2006 at 01:15:47PM -0600, Kumar Gala wrote:
> >>Has anyone ported the i2c-virtual code over 2.6?
> >
> >Not that I know of.
> 
> thanks.  I'll look at porting it 2.6.  It seems that the adapter- 
> >bus_lock is going to be the biggest issue.  How evil is it to call  
> adapter->algo->master_xfer directly instead of i2c_transfer?

I don't know, Jean?

