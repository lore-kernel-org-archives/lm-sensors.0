From: ben@fluff.org.uk (Ben Dooks)
Date: Thu, 19 May 2005 06:25:39 +0000
Subject: S3C2410 I2C - missing I2C_CLASS_HWMON
Message-Id: <20050221121050.GG28744@home.fluff.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050221110834.GA15730@home.fluff.org>
In-Reply-To: <20050221110834.GA15730@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Feb 21, 2005 at 12:17:46PM +0100, Jean Delvare wrote:
> 
> Hi Ben,
> 
> > None of the standard sensor drivers currently recognise the s3c2410
> > i2c controller as it does not have I2C_CLASS_HWMON set in it's
> > adapter class field.
> >
> > This patch initialised the adapter with I2C_CLASS_HWMON
> 
> Looks OK to me, but you seemingly forgot to CC: Greg KH. I'd also
> suggest that you somehow mention in the subject that there is a patch
> for him to catch in there.

thanks for noticing, will repost.
