From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: [PATCH 2.6] Voltage conversions in via686a (second try)
Message-Id: <20040502050812.GA31886@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040420192208.3c830b3c.khali@linux-fr.org>
In-Reply-To: <20040420192208.3c830b3c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Apr 25, 2004 at 10:43:10PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> My previous patch was actually not correct, reading from the chip's
> registers was fixed but writing limits to it wasn't. This new version of
> the patch should be better. Sorry for the trouble.

No trouble, applied, thanks.

greg k-h
