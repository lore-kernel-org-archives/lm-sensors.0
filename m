From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: [PATCH 2.6] I2C: Fix a common race condition in hardware
Message-Id: <20050328221116.GB4495@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050328131326.4eb2973d.khali@linux-fr.org>
In-Reply-To: <20050328131326.4eb2973d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 28, 2005 at 01:13:26PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> Grant Coady noticed that most hardware monitoring drivers are exposed to
> a race condition when one writes to the sysfs files they create. While
> the read calls properly request a lock on the internal data, write calls
> manipulate the internal data without proper locking. This big patch
> fixes that by adding locking wherever needed.
> 
> Affected drivers: adm1021, adm1025, asb100, ds1621, fscher, fscpos,
> gl518sm, gl520sm, it87, lm63, lm75, lm77, lm78, lm80, lm83, lm87, lm90,
> lm92, max1619, pc87360, pcf8591, sis5595, smsc47m1, via686a, w83627hf
> and w83781d
> 
> The adm1026, adm1031 and lm85 were already locking on write calls, but
> held the lock for code that did not require it, so they have been
> modified too.
> 
> The smsc47b397 and w83l785ts drivers were not affected, because they are
> read-only.
> 
> The patch should apply just fine on top of your stack, provided that you
> applied all previous patches in order (in particular, there is one lm87
> indentation patch which is needed).

Applied, thanks.

greg k-h
