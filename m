From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: adm1021 (probably) does something VERY,VERY BAD
Message-Id: <20040326215334.GA29797@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4062C734.5000104@gmx.net>
In-Reply-To: <4062C734.5000104@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Mar 25, 2004 at 08:02:19PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> Quoting myself:
> 
> > 3* Drop adm1021's limit init. This was already done in the 2.4 driver
> > and should have been done in 2.6 as well.
> 
> Here is a patch that does that. It also prevents bit 7 (and unused bits)
> of configuration register from being reset, as was discussed before:
>   http://archives.andrew.net.au/lm-sensors/msg04593.html
> That second part needs to be backported to the 2.4 driver, and I will do
> so.
> 
> Additionally, we get rid of a useless label.
> 
> The patch is untested (I don't own any supported chip) but quite
> straightforward IMHO.
> 
> Please apply,

Applied, thanks.

greg k-h
