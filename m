From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: [patch] i2c-piix: Don't treat ServerWorks servers as Laptops
Message-Id: <20040604214332.GA13825@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040529142325.GA14964@ucw.cz>
In-Reply-To: <20040529142325.GA14964@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, May 29, 2004 at 04:23:25PM +0200, Vojtech Pavlik wrote:
> Hi!
> 
> I'm sending you this little obvious patch which should enable i2c-piix
> to work on IBM servers with ServerWorks chipsets. It still will treat
> any IBM/Intel machine as a laptop and refuse to work, but it's better
> than before.
> 
> 
> ChangeSet@1.1815, 2004-03-19 16:01:20+01:00, vojtech@suse.cz
>   i2c: Treat only IBM machines with Intel chipsets as IBM laptops.

Applied, thanks.

greg k-h
