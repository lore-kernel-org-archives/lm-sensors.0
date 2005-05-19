From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: sensors strace
Message-Id: <20031123231727.GA7216@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031123183426.51043260.khali@linux-fr.org>
In-Reply-To: <20031123183426.51043260.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Nov 23, 2003 at 06:34:26PM +0100, Jean Delvare wrote:
> Hi all,
> 
> As I was investigating the long running "sensors: run as root?" issue, I
> found something strange. There is a mysterious sysctl call before and
> after reading the /etc/sensors.conf file. See:
> 
> open("/etc/sensors.conf", O_RDONLY)     = 3
> (...)
> ioctl(3, TCGETS, 0xbfffe6f8)            = -1 ENOTTY (Inappropriate ioctl
>                                           for device)
> (...)
> ioctl(3, TCGETS, 0xbfffe6c8)            = -1 ENOTTY (Inappropriate ioctl
>                                           for device)
> 
> I was unable to find where in the code we do that, but I suspect that
> this is in lex/yacc generated code (which is simply unreadable). Does
> anyone have an explanation? What's that "TCGETS" supposed to do, and why
> is it failing?

It gets the current termios settings for the device.  It should only
succeed if called on a serial port node.  I have no idea why it's being
called on a file handle that is not a serial port.  It's possibly a
thing that glibc does to determine what kind of file it has opened up.

greg k-h
