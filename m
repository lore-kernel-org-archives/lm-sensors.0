From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC on
Message-Id: <20050426075415.GB6795@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705042422366584aff4@mail.gmail.com>
In-Reply-To: <2538186705042422366584aff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Apr 26, 2005 at 09:42:11AM +0200, Jean Delvare wrote:
> > And the void * shouldn't be called ptr, use what other structures call
> > their void pointers, "data", "private", etc.
> 
> What are these other structures, BTW? I'd like to take a look at them,
> maybe it would enlighten my views.

struct device
struct file
struct inode

And others.  No one needs to define a pointer as "ptr", that's just
redundant :)

But yes, it should be a "void *" that part is correct.  No matter what
we want to store in there, that will be sufficient.

thanks,

greg k-h
