From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: [PATCH 2.6] Cleanups to the recent smbus functions removal
Message-Id: <20041119171213.GB19845@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041116223833.4fdeb1aa.khali@linux-fr.org>
In-Reply-To: <20041116223833.4fdeb1aa.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Nov 16, 2004 at 10:38:33PM +0100, Jean Delvare wrote:
> Hi Greg, all,
> 
> This patch cleans up the recent removal of smbus functions proposed by
> Arjan and then fixed by Gabriel. Changes are as follow:
> 
> 1* Discard i2c_smbus_block_process_call, as it isn't used anywhere
>    either. I guess that Arjan missed it because it wasn't exported.
> 
> 2* Document the functions removal, so that people have at least an idea
>    that the functions can be restored later if needed.
> 
> Maybe it would make sense to apply this before 2.6.10-rc2? Not critical
> however, I agree. But obviously safe too, huh? ;)
> 
> Thanks.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Applied, thanks.

greg k-h
