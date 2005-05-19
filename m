From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: [PATCH 2.6] I2C: Improve it87 super-i/o detection
Message-Id: <20050113232837.GA2458@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050113205332.75db90cd.khali@linux-fr.org>
In-Reply-To: <20050113205332.75db90cd.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jan 13, 2005 at 08:53:32PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> This patch improves the detection of Super-I/O it87 chips (IT8712F,
> IT8705F).
> 
> * Find the IT8712F and IT8705F address through Super-I/O (as opposed to
>   IT8712F only so far).
> 
> * Verify that the device is activated. Print info lines if a
>   disactivated or unconfigured chip is found.
> 
> * Print an info line when finding either chip, with device name,
>   address and revision.
> 
> * Rearrange code in it87_find() (error path).
> 
> * (bonus) Get rid of the useless i2c_client id.
> 
> Successfully tested on two IT8712F and one IT8705F, thanks to Jonas
> Munsin, Rudolf Marek and Karine Proot.
> 
> Please apply,

Applied, thanks.

greg k-h
