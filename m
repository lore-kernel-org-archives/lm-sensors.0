From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: [PATCH 2.6] Fix adm1021 alarms mask
Message-Id: <20050317064041.GI15075@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050306083758.2f97cf9d.khali@linux-fr.org>
In-Reply-To: <20050306083758.2f97cf9d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Mar 06, 2005 at 08:37:58AM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> This patch fixes an incorrect bitmasking on the status register in the
> adm1021 driver, which was causing high alarm on remote temperature to be
> hidden.
> This bug was found and reported by Jayakrishnan:
>   http://bugzilla.kernel.org/show_bug.cgi?idB85

Applied, thanks.

greg k-h
