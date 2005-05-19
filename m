From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: sensord 2.8.2 on 2.6.0/ASUS chip - subclient problem
Message-Id: <20040113180720.GE2610@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200401111319.18817.arvidjaar@mail.ru>
In-Reply-To: <200401111319.18817.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jan 11, 2004 at 01:19:18PM +0300, Andrey Borzenkov wrote:
> 
> I do not know if it is a sensord (should not attempt to read subclient) or 
> kernel (does not provide sufficient information) problem. Subclient can be 
> determined by its name:
> 
> {pts/1}% for i in /sys/bus/i2c/devices/*
> do
> echo ${i:t}:$(<$i/name)
> done
> 0-002d:as99127f
> 0-0048:as99127f subclient
> 0-0049:as99127f subclient
> 
> Greg, this is supposed to be established convention now?

I think so, yes.  I'll let the userspace people answer your other
questions.

thanks,

greg k-h
