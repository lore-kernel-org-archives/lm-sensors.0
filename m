From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:33 +0000
Subject: Adapter driver
Message-Id: <3CEE9B9B.1080404@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020520172349.A7186@crystal.2d3d.co.za>
In-Reply-To: <20020520172349.A7186@crystal.2d3d.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

phil@netroedge.com wrote:

> 
>>2) There is 3 fields in the i2c_algo_bit_data structure for timing: udelay,
>>mdelay, timeout. What should I make this? I've made them 80, 80, 100
>>respectively (stolen from Russell King's acorn RTC driver), but I'm not sure
>>if this is the best selection...
> 
> 
> Humm... I'll have to punt this to either Mark or Frodo.
> 
>

the numbers are half-clock-cycle times in microseconds.
So 80 means a clock of approx. 6 kHz which is really slow.
Don't know what the difference between udelay and mdelay is,
have always seen them the same.



