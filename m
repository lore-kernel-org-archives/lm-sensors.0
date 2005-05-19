From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: probe order for 2.6 sensor chips
Message-Id: <20030811204839.GA18442@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Someone just filed an interesting 2.6 bug:
	http://bugme.osdl.org/show_bug.cgi?id66

It pertains to the order of the i2c sensor drivers being loaded.  Is
there some documentation somewhere that details which drivers need to be
placed before the others?  Right now I'm just using the alphabetical
order for link priority, but this is probably wrong as this report has
determined :)

Any thoughts as to the correct order?

thanks,

greg k-h
