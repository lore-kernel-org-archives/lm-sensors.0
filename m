From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: sensors.conf: explain how to enable/disable beeps
Message-Id: <20040512190311.GC14697@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040509222513.GA20557@pc.aurel32.lan>
In-Reply-To: <20040509222513.GA20557@pc.aurel32.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, May 12, 2004 at 02:46:44PM +0200, Jean Delvare wrote:
> Method #1: Pros: Fewer files, scripts can easily know if there is any
> alarm set for a channel (non-zero value). Cons: The user-space needs to
> know the meaning of the bits. The bits have to be wisely chosen once and
> for all, covering all possibilities (at lest of all chips we know of as
> of today).
> 
> Method #2: Pros: No preliminary knowledge necessary, the interface is
> self explaining. Can be easily implemented and extended. Cons: almost
> doubles the number of files in the sysfs interface.
> 
> I have no string preference (yet). Insight welcome.

I prefer method 2.  It also allows languages that can't handle bit
operations easily to access the values (like bash...)

thanks,

greg k-h
