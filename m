From: xuan--sensors--2003.12.20@baldauf.org (Xuan Baldauf)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: Hidden and disabled SMBus SiS0016, please enable
Message-Id: <3FF200F5.60807@baldauf.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FE4DB3C.8050504@baldauf.org>
In-Reply-To: <3FE4DB3C.8050504@baldauf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark M. Hoffman wrote:

>But, what about this kernel oops under 2.4?  Whatever the state of the
>hardware, this shouldn't happen.  Could you give more details about that?
>I2C and lm_sensors versions, how you built them, anything else special...
>And of course a copy of the oops message itself.
>  
>
Sorry, it was my fault. I digged into this and found that lm-sensors 
modules had different assumptions about some "struct"s than i2c-core. 
The reason was that I did not use i2c-2.8.0 but i2c provided from kernel 
2.4. After using the correct i2c version, the oops disappeared.

Xu?n.
