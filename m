From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: Porting chip drivers to 2.6
Message-Id: <20030923205018.GB5609@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030923213039.7ff27e46.khali@linux-fr.org>
In-Reply-To: <20030923213039.7ff27e46.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Sep 23, 2003 at 09:30:39PM +0200, Jean Delvare wrote:
> 
> Hi Greg,
> 
> I plan to port my lm83 and lm90 (and possibly adm1025, but later)
> drivers to linux 2.6. Is there a guide on how to do this yet? If there
> is one, please point me to it. If not, I'll take another driver as an
> example (lm75 seems to be a good choice), and write such a guide for
> later ports.

I did write such a guide for i2c adapter drivers, but not for chip
drivers, sorry.  I might have said something in the sensor mailing list
archives... Nope can't find anything...

Oh well, such a guide would be nice to have for others.  Let me know if
you have any questions about how to do this.

thanks,

greg k-h
