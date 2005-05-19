From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: [patch] fix for fscpos voltage values
Message-Id: <20050120182917.GA1228@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050120181851.GN26072@desire.ch>
In-Reply-To: <20050120181851.GN26072@desire.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jan 20, 2005 at 07:18:52PM +0100, Stefan Ott wrote:
> Multiplied the voltage multipliers by 10 in order to comply with the sysfs
> guidelines.
> 
> Signed-off-by: Stefan Ott <stefan@desire.ch>

That's nice, but:

> --- fscpos.c-orig	2005-01-20 03:49:05.000000000 +0100
> +++ fscpos.c	2005-01-20 18:44:53.000000000 +0100

That isn't :(

I need a patch I can apply with -p1 from the main root of the kernel
tree, as Documentation/SubmittingPatches specifies.

Third times the charm...

greg k-h
