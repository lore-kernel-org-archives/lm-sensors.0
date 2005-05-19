From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: Should sensors-detect be merged with Hotplug or Discover
Message-Id: <20040508205725.GA15611@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200405081001.31499.david.goodenough@btconnect.com>
In-Reply-To: <200405081001.31499.david.goodenough@btconnect.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, May 08, 2004 at 10:01:31AM +0100, David Goodenough wrote:
> I realise that some sensors are difficult to detect, but in the cases where 
> detection is very reliable should not sensors-detect be merged into 
> Hotplug or Discover (probably Discover as I am not aware of sensors
> which come and go, although with the hotpluging of memory modules
> which themselves might have sensors built in this may arrive) so that
> it all happens automatically without a separate sensors-detect stage?

The hotplug merge is on my todo list for the 2.7 kernel.  We need to
change the format of the drivers and some other kernel code for it to
even start to work.

And yes, it will not be as reliable as other systems, but it will be a
good start...

thanks,

greg k-h
