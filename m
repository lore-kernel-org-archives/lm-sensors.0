From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: [PATCH] fix it8712 detection
Message-Id: <20041019222752.GD9521@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0410121927500.9204@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0410121927500.9204@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 12, 2004 at 07:42:30PM +0200, Rudolf Marek wrote:
> 
> Hello,
> 
> Following patch fixes the bug introduced by me in VID VRM patch.
> Spotted (and later reviewed) by Jean Delvare. This bug is non-fatal,
> it8712 will be just treated as it was before my VID VRM patch.
> 
> Tested on it8705 and it8712  hardware.
> 
> Signed-off-by: Rudolf Marek <r.marek@sh.cvut.cz>

Applied, thanks.

greg k-h
