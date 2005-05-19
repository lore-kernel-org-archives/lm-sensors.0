From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:24 +0000
Subject: sensors on asus p4p800
Message-Id: <3FB1A31D.2467DFD2@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1068583832.1658.8.camel@localhost>
In-Reply-To: <1068583832.1658.8.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

try modprobe w83627hf init=0

Pascal Ronecker wrote:
> 
> Hi,
> 
> I just apgraded my PC, and installed kernel 2.4.22, with i2c patch, and
> lm_sensors 2.8.1.
> 
> eveything works wonderfully ... except one strange thing.
> 
> The motherboard P4P800 has the ability to slow down the cpu fan when its
> temperature is  cold enough. (as many other cards do).
> At boot time, it starts at full speed and then quickly slow down during
> the POST stage.
> 
> Then ...
> the modules used by lm_sensors loads, and the fan speeds up.
> In fact at the very moment w83627hf.o loads, it speeds up.
> 
> I tried manually : no module at boot time, then modprobe w83627hf :
> jackpot, fan speeding up.
> 
> Have anyone ever noticed such a thing ?
> Is the module itself over-heating the CPU ?? (don't ask me how or why ..
> have never seem a flamethrower inside my PC ... )
> 
> It's too bad, cause there's no interest in monitoring something if the
> simple fact to monitorit makes it have a constant (and noisy) value ...
> 
> thanks for your help,
> 
> as I really need a silent room to get my sleep back :-)
