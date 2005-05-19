From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: [PATCH 2.6] more i2c bus drivers (1/2)
Message-Id: <20031217234409.GA6258@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031205221443.482486b1.khali@linux-fr.org>
In-Reply-To: <20031205221443.482486b1.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Dec 05, 2003 at 10:14:43PM +0100, Jean Delvare wrote:
> This patch fixes i2c_smbus_write_byte() being broken for i2c-amd8111.
> This causes trouble when that module is used together with eeprom (which
> is also in 2.6). We have had no report so far, but the problem is
> similar to the one addressed by a recent patch to i2c-nforce2.
> 
> Credits go to Hans-Frieder Vogt for finding and fixing the problem. Mark
> D. Studebaker found and fixed the original problem in i2c-nforce2.
> 
> This is a serious bug fix, and I believe you shouldn't wait too long
> before applying it.

Applied, thanks.

greg k-h
