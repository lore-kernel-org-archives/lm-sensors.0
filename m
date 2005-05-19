From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: [PATCH] I2C: port smsc47m1 to 2.6
Message-Id: <20040809174138.GD2344@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040808174558.14ad912d.khali@linux-fr.org>
In-Reply-To: <20040808174558.14ad912d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Aug 08, 2004 at 05:45:58PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> Here is my port of the smsc47m1 i2c hardware monitoring driver to Linux
> 2.6. The original driver was written by Mark D. Studebaker, and my work
> is based on a preliminary port by Gabriele Gorla, who came in with an
> almost finished driver, but vanished before cleaning it up. I finished
> the job and improved things a bit. Credits go to Ivars Strazdins and
> Cassio Freitas for testing the driver (having no hardware, I couldn't
> test the code myself).
> 
> Please consider for inclusion into your kernel tree.

Applied, thanks.

greg k-h
