From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: [PATCH 2.6] Handle read errors in w83l785ts
Message-Id: <20040202230441.GA1397@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040202225211.40740d70.khali@linux-fr.org>
In-Reply-To: <20040202225211.40740d70.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Feb 02, 2004 at 10:52:11PM +0100, Jean Delvare wrote:
> 
> Please comment and apply if/when you feel like it,

Looks good, I've applied this (with one fix for your misplacement of the
'{' character in the if() statement you added...)

thanks,

greg k-h
