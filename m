From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: i2c-parport ancestors
Message-Id: <20040315205908.GA23503@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040313203134.1d043690.khali@linux-fr.org>
In-Reply-To: <20040313203134.1d043690.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Mar 13, 2004 at 08:31:34PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> Any plan to remove i2c-elv, i2c-velleman and i2c-philips-par from the
> 2.6 kernel tree? Now that i2c-parport and i2c-parport-light are supposed
> to replace them, it would be nice if we could avoid spending energy
> maintaining them.

If you think it's ok to delete them now, I will do so.  Just let me
know.

thanks,

greg k-h
