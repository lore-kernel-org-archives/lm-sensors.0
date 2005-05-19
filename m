From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: [PATCH 2.6] I2C: Cleanups to the eeprom driver
Message-Id: <20050113232916.GD2458@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050112215449.2c699efc.khali@linux-fr.org>
In-Reply-To: <20050112215449.2c699efc.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jan 12, 2005 at 09:54:49PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> Here comes a cleanup patch to the i2c eeprom client driver:
> 
> * Get rid of the unused i2c_client client_id.
> * Get rid of the redundant non-ISA bus check.
> * Fix the adapter capability check. We were previously using
>   capabilities without checking if they were supported. Document
>   which capabilities are required and which are optional.
> * Reorder things a bit. In particular, wait to have a valid client
>   before we bother checking if this is a Vaio EEPROM.
> * Use strlcpy instead of strncpy, because I Heard It Was Better (TM) and
>   all other chip drivers use it.
> * Take benefit of the auto-increment feature of EEPROMs to speed up the
>   Vaio check.
> * Display an information message when a Vaio EEPROM is detected.
> 
> Tested successfully on my laptop, which happens to be a Vaio.
> 
> Please apply,

Applied, thanks.

greg k-h
