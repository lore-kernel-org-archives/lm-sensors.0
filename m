From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 20 Mar 2012 03:20:44 +0000
Subject: Re: [lm-sensors] Intel DH55HC Sensors
Message-Id: <20120320032044.GA2485@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120314143659.0c1cf55d@ritchie.cs.ubc.ca>
In-Reply-To: <20120314143659.0c1cf55d@ritchie.cs.ubc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 19, 2012 at 07:18:07PM -0400, Christopher Head wrote:
> On Mon, 19 Mar 2012 14:46:03 -0700
> Guenter Roeck <guenter.roeck@ericsson.com> wrote:
> 
> > Chris,
> > 
> > I briefly looked into this a while ago, after the HECI (MEI) driver
> > was put back into the kernel. Problem is that it is not well
> > documented, and it is built around the assumption that it would only
> > be used from user space applications. This means one would need to
> > understand it enough to 1) port the necessary user space libraries
> > into the kernel, 2) modify the MEI driver to support those in-kernel
> > libraries, and 3) use the libraries to write a hwmon driver.
> > 
> > Writing the hwmon driver would be straightforward, but the rest is
> > just too much for my spare time.
> > 
> > Guenter
> 
> Alright, thanks for the information. One of these days I might take a
> peek and perhaps try to hack up a patch, but it won't be any time soon.
> Or maybe someone else will first.
> 
I had another quick look.

Replace 1) and 2) with "re-write the kernel driver to support non-file accesses".
The libraries are not really needed, but the kernel mei driver has file accesses
written all over it, so it would require a major rewrite to enable in-kernel access.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
