From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: [2.5] Help with ICH5 SMBus and W83627THF
Message-Id: <20030616184117.GA25585@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1055775351.19204.11.camel@nosferatu.lan>
In-Reply-To: <1055775351.19204.11.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jun 16, 2003 at 04:55:51PM +0200, Martin Schlemmer wrote:
> Hi
> 
> I have been trying to get the W83627THF chip working on this
> board.  It is an Asus P4C800 with Intel 875p chipset and a
> W83627THF connected via the SMBus.
> 
> There are no data sheet for the W83627THF as far as I can see,
> but supposidly it is a W83627HF with advance Fan control, etc.
> 
> I have applied attached patches, and tried various other things
> to get it to work, but no avail.  The SMBus on the ICH5 seems to
> work, and it seems to detect the sensor chip just fine, but it
> do not seem to read any values from the W83627THF.

I've applied your patches, thanks.

greg k-h
