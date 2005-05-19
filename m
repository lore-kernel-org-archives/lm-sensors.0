From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: [PATCH 2.6] Fix lm90.c with DEBUG
Message-Id: <20040119210334.GA4407@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040118123521.28bb2f2a.khali@linux-fr.org>
In-Reply-To: <20040118123521.28bb2f2a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jan 18, 2004 at 12:35:21PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> The recent patch that fixes lm83.c with DEBUG also applies to lm90.c. No
> wonder since I used the first as a template when porting the second.
> Patch follows.

Applied, thanks.

greg k-h
