From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC on
Message-Id: <20050428162650.GC17658@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705042422366584aff4@mail.gmail.com>
In-Reply-To: <2538186705042422366584aff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Apr 28, 2005 at 05:53:51PM +1000, Grant Coady wrote:
> Hi Greg,
> On Wed, 27 Apr 2005 23:57:41 -0700, Greg KH <greg@kroah.com> wrote:
> 
> >
> >And how would it work with the 99% of the kernel that doesn't create
> >attributes dynamically on the fly?
> 
> Create an index attribute: write index value, read/write attribute 
> data?  Nothing else need know, just the driver needing unbounded 
> indexed attributes.

Sorry, I don't see the patch you must have forgotten to apply to the
email, showing how you would do this...

:)

thanks,

greg k-h
