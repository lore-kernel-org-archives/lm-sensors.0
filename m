From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: [PATCH 2.6] amd756 byte writes
Message-Id: <20031218000916.GF6258@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FDBA474.AC098F99@paradyne.com>
In-Reply-To: <3FDBA474.AC098F99@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Dec 13, 2003 at 06:44:52PM -0500, Mark Studebaker wrote:
> This fixes byte writes (used by the eeprom driver) in the i2c-amd756
> driver.
> It is similar to recent fixes for the i2c-amd8111 and i2c-nforce2
> drivers.
> Tested by me.
> please apply.

Applied, thanks.

greg k-h
