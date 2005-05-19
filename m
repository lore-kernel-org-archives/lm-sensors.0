From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: [PATCH 2.6] Rewrite temperature conversions in via686a driver
Message-Id: <20040505221744.GD29885@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040502164851.18195edf.khali@linux-fr.org>
In-Reply-To: <20040502164851.18195edf.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, May 02, 2004 at 04:48:51PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> The following patch rewrites the temperature conversion macros and
> functions found in the via686a chip driver. Contrary to the voltage
> conversions a few weeks ago, temperature conversions were numerically
> correct, but artificially complex. The new ones are cleaner. It also
> fixes a highly improbable array overflow (would take one of the measured
> temperatures to be over 145 degrees C).
> 
> Successfully tested by Mark D. Studebaker and I, and already applied to
> our CVS repository.
> 
> Please apply,

Applied, thanks.

greg k-h
