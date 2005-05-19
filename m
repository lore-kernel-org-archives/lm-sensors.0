From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: Clean up of i2c-elektor.c build for 2.6.11
Message-Id: <20050317065711.GM15075@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <422E2417.7020707@aeroflex.com>
In-Reply-To: <422E2417.7020707@aeroflex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Mar 11, 2005 at 02:11:21PM -0600, Frank Beesley wrote:
> I will try this again. I did a "diff -v" and see that our workstations 
> have colordiff 1.0.4 on top of diff (GNU diffutils) 2.8.7. This would 
> explain the wonderful colors. I went back to our target machines that 
> have just he diffutils, not colordiff.
> 
> 
> This patch changes the flags variable type from long to unsigned long in  
> one function. This removes a couple of warnings from the compile messages 
> for elektor i2c bus driver.

Applied, thanks.

greg k-h
