From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: [PATCH 2.6] Fix debug bug in lm83 driver
Message-Id: <20040114193952.GL6107@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040111175123.54cdeb9f.khali@linux-fr.org>
In-Reply-To: <20040111175123.54cdeb9f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jan 11, 2004 at 05:51:23PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> The following patch fixes lm83 failing to compile if DEBUG is set.

Applied.

> BTW, how does one enable DEBUG? I tried to add "-DDEBUG" in the main
> Makefile with no success, then I tried to add "#define DEBUG" in the
> driver itself but it didn't work either. I had to run the correct
> compilation command directly by myself with -DDEBUG to get it to work. I
> just can't understand why the two other ways (especially the second)
> fails to work. Does Voodoo magic surround us? Help! ;)

Add #define DEBUG at the start of the file, no vodo magic needed :)

thanks,

greg k-h
