From: Christopher Head <headch@gmail.com>
Date: Mon, 19 Mar 2012 23:18:07 +0000
Subject: Re: [lm-sensors] Intel DH55HC Sensors
Message-Id: <20120319161807.2a756c45@ritchie.cs.ubc.ca>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120314143659.0c1cf55d@ritchie.cs.ubc.ca>
In-Reply-To: <20120314143659.0c1cf55d@ritchie.cs.ubc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 19 Mar 2012 14:46:03 -0700
Guenter Roeck <guenter.roeck@ericsson.com> wrote:

> Chris,
> 
> I briefly looked into this a while ago, after the HECI (MEI) driver
> was put back into the kernel. Problem is that it is not well
> documented, and it is built around the assumption that it would only
> be used from user space applications. This means one would need to
> understand it enough to 1) port the necessary user space libraries
> into the kernel, 2) modify the MEI driver to support those in-kernel
> libraries, and 3) use the libraries to write a hwmon driver.
> 
> Writing the hwmon driver would be straightforward, but the rest is
> just too much for my spare time.
> 
> Guenter

Alright, thanks for the information. One of these days I might take a
peek and perhaps try to hack up a patch, but it won't be any time soon.
Or maybe someone else will first.

Chris

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
