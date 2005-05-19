From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: i2c adapters class
Message-Id: <20040309232723.GB15143@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040224223843.2fb3394a.khali@linux-fr.org>
In-Reply-To: <20040224223843.2fb3394a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Mar 06, 2004 at 07:00:34PM +0100, Jean Delvare wrote:
> Greg,
> 
> Please accept this temporary fix for the class issue. I'd like users of
> the i2c-ali1535, i2c-sis5595 and i2c-via driver to be able to use
> sensors as soon as possible, even if we have not yet determined what our
> policy WRT classes should be.

Ok, applied.

> BTW, don't you think I2C_ADAP_CLASS_SMBUS is a misnomer? It's about
> hardware monitoring, not the SMBus protocol. I'd say
> I2C_ADAP_CLASS_HWMON or I2C_ADAP_CLASS_SENSORS would have been more
> appropriate (although it may be a bit late for a change...)

Yeah, it doesn't make the most sense.  Care to propose something that
does make sense?  Or something to just fix this class stuff up all
together?

thanks,

greg k-h
