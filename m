From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: [PATCH 2.6] Make i2c list terminators explicitely unsigned
Message-Id: <20050225200737.GB25915@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050224222935.5524648c.khali@linux-fr.org>
In-Reply-To: <20050224222935.5524648c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Feb 24, 2005 at 10:29:35PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> Shouldn't the i2c list terminators be explicitely declared as unsigned?
> I'd hope it to help code analysis tools and possibly avoid false
> positives. Coverity's SWAT pointed my attention to these constants.
> 
> Thanks.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Applied, thanks.

greg k-h
