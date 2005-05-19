From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: [PATCH 2.6] i2c bus drivers (2/4)
Message-Id: <20031204215346.GE2239@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031129211021.3626bd06.khali@linux-fr.org>
In-Reply-To: <20031129211021.3626bd06.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Nov 29, 2003 at 09:10:21PM +0100, Jean Delvare wrote:
> This patch fixes i2c_smbus_write_byte() being broken for i2c-nforce2.
> This causes trouble when that module is used together with eeprom (which
> is also in 2.6). We have had three user reports about the problem.
> 
> Credits go to Mark D. Studebaker for finding and fixing the problem. We
> have also been contacting the module author (Hans-Frieder Vogt) but had
> no answer so far.
> 
> This is a serious bug fix, and I believe you shouldn't wait too long
> before applying it.

Applied.  And yes, I agree, I'll send it to Linus soon.

thanks,

greg k-h
