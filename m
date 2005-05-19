From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: PATCH: 2.4.22-pre7 drivers/i2c/i2c-dev.c user/kernel bug and mem
Message-Id: <20030805210704.GA5452@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030803192312.68762d3c.khali@linux-fr.org> <20030804193212.11786d06.vsu@altlinux.ru> <20030805103240.02221bed.khali@linux-fr.org>
In-Reply-To: <20030805103240.02221bed.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Cc: Sergey Vlasov <vsu@altlinux.ru>, "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>

On Tue, Aug 05, 2003 at 10:32:40AM +0200, Jean Delvare wrote:
> 
> Changes:
> 1* Amount of white space, twice. Ignore.
> 2* Use ++i instead of kfree as discussed above.
> 3* Remove conditional test around i2c_transfer, since it isn't necessary
> (if I'm not missing something).

Patch looks good, want to send it to Marcelo, or do you want me to?

thanks,

greg k-h
