From: greg@kroah.com (Greg KH)
Date: Fri, 10 Jun 2005 07:44:13 +0000
Subject: [lm-sensors] Re: [1/6] w1: Cleans up usage of
Message-Id: <20050610052538.GA15505@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050604012146.2a89ec0a@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050604012146.2a89ec0a@zanzibar.2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

After this series is applied, I get the following compiler warning:

drivers/w1/w1_family.c: In function `w1_register_family':
drivers/w1/w1_family.c:65: warning: implicit declaration of function `w1_reconnect_slaves'

Care to send a follow-on patch to fix this up?

thanks,

greg k-h
