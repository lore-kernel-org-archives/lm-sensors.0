From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 22 Aug 2006 21:23:47 +0000
Subject: [lm-sensors] [PATCH] AMD K8 digital sensor - take2
Message-Id: <44EB75E3.3030906@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <44EB67BB.5010604@sh.cvut.cz>
In-Reply-To: <44EB67BB.5010604@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

> This line has me thinking...
> +    u32 temp[2][2];        /* core, place */
> 
> AMD and Intel are both coming out with quad-core processors soon. Some
> could be backward-compatible with existing dual-core sockets. In
> addition, some servers have four sockets (quad processor, or 8-core,
> etc.).
> 

Four sockets are ok. It will appear as 4 devices, so 4 instances of this driver ;)

> Maybe this array should be a little bigger? It will save you some
> trouble later. If not, it's okay to ignore this message...

Well I dont know how to switch between more than two cores anyway. The driver 
should handle 4temps/physical CPU.

regards
Rudolf

