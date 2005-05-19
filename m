From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: [PATCH 2.6] Fix Vaio EEPROM detection
Message-Id: <20050324000421.GB7189@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050318191927.650a5ed3.khali@linux-fr.org>
In-Reply-To: <20050318191927.650a5ed3.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Mar 18, 2005 at 07:19:27PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> This fixes a bug in the eeprom driver, which made all EEPROMs at
> location 0x57 be erroneously treated as Vaio EEPROMs. I have to say I'm
> quite ashamed that I introduced the bug in the first place, as this was
> a really stupid one.
> 
> Please apply,

Applied, thanks.

greg k-h
