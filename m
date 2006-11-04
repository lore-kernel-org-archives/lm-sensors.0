From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 04 Nov 2006 14:23:13 +0000
Subject: [lm-sensors] Driver for Fintech F75375S?
Message-Id: <20061104152313.9692a7da.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060810174246.GB8333@deprecation.cyrius.com>
In-Reply-To: <20060810174246.GB8333@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Martin,

On Thu, 10 Aug 2006 19:42:46 +0200, Martin Michlmayr wrote:
> I was wondering if anyone is working on a driver for the Fintech
> F75375S?  According to http://www.lm-sensors.org/wiki/NewDrivers
> a datasheet is available, but there is "no request".  I have a

I've updated the page to mention your request.

> Thecus N2100, an ARM based NAS device, which has such a sensor
> and it would be great if it was supported.  While the vendor includes
> a driver, it is not done in a way that would be appropriate for
> mainline kernel inclusion.

That's still interesting that they provided a Linux driver. If it is
publicly available, can you please point me to it?

> Is anyone interested in implementing such a driver?  I'd be glad to
> test it.

Riku Voipio (Cc'd) has been writing a driver. Nobody reviewed nor
tested it yet as far as I know, but you might want to be the first
tester (at your own risk, of course.) Riku, can you please send the
latest version of your driver to Martin (in private, as the list
received it some times ago already)? Thanks.

-- 
Jean Delvare

