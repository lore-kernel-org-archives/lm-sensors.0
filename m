From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: [PATCH 2.6] it87 and via686a alarms
Message-Id: <20031204222419.GA2511@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031121220837.0084cb1d.khali@linux-fr.org>
In-Reply-To: <20031121220837.0084cb1d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Nov 21, 2003 at 10:08:37PM +0100, Jean Delvare wrote:
> > it87 and via686a violate the sysfs standard by having "alarm" instead
> > of "alarms", would you please fix in your next patch?
> 
> I'm not the only one allowed to send patches to Greg, you know ;)
> Anyway, here we go. Greg, here is a patch that corrects the standard
> violation reported by Mark. Tested to compile.
> 
> (It also removes a useless comment in it87.c.)

applied, thanks.

greg k-h
