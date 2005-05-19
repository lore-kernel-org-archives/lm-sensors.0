From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: [PATCH 2.6] I2C: New LM63 chip driver
Message-Id: <20041105214754.GG1750@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041026212545.13a8c9d5.khali@linux-fr.org>
In-Reply-To: <20041026212545.13a8c9d5.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 26, 2004 at 09:25:45PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> This is a new I2C chip driver named lm63, which supports National
> Semiconductor's LM63 hardware monitoring chip. The LM63 is similar to
> the LM86 (which we do support through our lm90 driver) with additional
> monitoring and control of a single fan. It is obviously aimed at the CPU
> and high-end graphics adapters markets. This new driver is very similar
> in nature to the lm83 and lm90 driver so I don't have much to add.
> 
> I developed the driver on a request from Hard Data Ltd. which are using
> Tyan S4882 boards where four LM63 chips are used (one for each CPU).
> Tyan provided remote access to a test system so that I could test my
> driver on real LM63 chips.
> 
> Please apply,
> thanks.

Applied, thanks.

greg k-h
