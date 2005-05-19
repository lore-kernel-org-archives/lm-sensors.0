From: david.goodenough@btconnect.com (David Goodenough)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: LM87 sensor on Routerboard
Message-Id: <200504272301.08930.david.goodenough@btconnect.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <019401c54b66$d4a13810$19680a0a@braintrust.net>
In-Reply-To: <019401c54b66$d4a13810$19680a0a@braintrust.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wednesday 27 April 2005 21:22, Anthony Rios wrote:
> Hey all,
>     I read through the archives and found information on the porting
> of the LM87 chip driver to 2.6 kernels. I believe David Goodenough
> was working on the port specifically to work on the Routerboard
> 230.  Maybe he can help me out here.
>
>     I am a bit confused as to what I need to get my sensors going. In
> the 2.4 kernel I needed patches for i2c-nscacb as well as lm87.  Is
> this still necessary? Should I be using the same patches?
>
> TIA.
>
> Tony
There is nothing to be ported, there is already a driver.  Rather than
using the i2c-nscacb driver you need to use the scx200_acb driver.

David
