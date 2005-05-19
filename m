From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: [PATCH 2.6] Kill unused struct members in w83627hf driver
Message-Id: <20050317063933.GC15075@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050308203358.31e2aa92.khali@linux-fr.org>
In-Reply-To: <20050308203358.31e2aa92.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Mar 08, 2005 at 08:33:58PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> I just noticed that the pwmenable struct members in the w83627hf driver
> are not used anywhere (and quite rightly so, as PWM cannot be disabled
> in these chips as far as I know). Let's just get rid of them and save
> some bytes of memory.

Applied, thanks.

greg k-h
