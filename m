From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: [RFC][2.6] Additional i2c adapter flags for i2c client isolation
Message-Id: <20040317174255.GE19060@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4056C805.8090004@convergence.de> <20040316154454.GA13854@kroah.com> <20040316201426.1d01f1d3.khali@linux-fr.org> <20040316195325.GA22473@kroah.com> <1079515049.405817a9a3da0@imp.gcu.info>
In-Reply-To: <1079515049.405817a9a3da0@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com, Michael Hunold <hunold@convergence.de>

On Wed, Mar 17, 2004 at 10:17:29AM +0100, Jean Delvare wrote:
> How would we export the value though? Numerical, with user-space headers
> to be included by user-space applications? Or converted to some
> explicit text strings so that no headers are needed?

A text string would be simple enough to use.

thanks,

greg k-h
