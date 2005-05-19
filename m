From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: [PATCH 2.6] initialize fan_mins in w83781d, asb100 and lm78
Message-Id: <20040325184917.GB30899@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040323213245.2b5f5588.khali@linux-fr.org>
In-Reply-To: <20040323213245.2b5f5588.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Mar 23, 2004 at 09:32:45PM +0100, Jean Delvare wrote:
> Quoting myself:
> 
> > While testing, I found a corner case that isn't handled properly. It
> > doesn't seem to be handled by the lm78 and the asb100 either. Setting
> > fanN_div before ever reading from the chip or setting fanN_min will
> > make use of fanN_min while it was never initialized.
> 
> The following patch addesses the issue. Tested to work on my AS99127F
> rev.1 (which means that only the changes to the w83781d driver were
> actually tested). Testers welcome.

Looks sane to me, applied, thanks.

greg k-h
