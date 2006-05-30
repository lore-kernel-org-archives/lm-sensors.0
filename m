From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 30 May 2006 21:36:12 +0000
Subject: [lm-sensors] [PATCH] New VID codes for Intel Core and Conroe
Message-Id: <447CBACC.8090409@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <447815E5.5060601@sh.cvut.cz>
In-Reply-To: <447815E5.5060601@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

> I tried ;)
> vrm:110
> cpu0_vid:1513
> cpu1_vid:1225
> 

The second one looks good. The first one is in fact 001111 which is a bit 
suspicious value. Please can you check the driver/raw bits reading?

Thanks,

Regards
Rudolf

