From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: [PATCH 2.6] I2C: Fix some i2c algorithm initialization
Message-Id: <20050324000355.GA7189@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050323204943.77cf3f01.khali@linux-fr.org>
In-Reply-To: <20050323204943.77cf3f01.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Mar 23, 2005 at 08:49:43PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> While searching for i2c_algorithm declarations missing their
> .functionality member, I found three of them which were not properly
> initialized. i2c-algo-ite and i2c_sibyte_algo do not use the C99
> initialization syntax, and i2c-ibm_iic.c explicitely initializes NULL
> members. Following patch puts some order in there.
> 
> Please apply, thanks.

Applied, thanks.

greg k-h
