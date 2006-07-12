From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 12 Jul 2006 06:08:30 +0000
Subject: [lm-sensors] AMD K8 digital temperature sensor
Message-Id: <44B491DE.1040109@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <44A9941C.4020106@sh.cvut.cz>
In-Reply-To: <44A9941C.4020106@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

David Hubbard wrote:
> Hi Rudolf,
> 
> Attached is a zip file containing the results of the k8temp driver on
> my machine. It compiles and installs with no problems. The temperature
> readings do not compare to what the w83627ehf reports. In the zip file
> is comp_temp.gif which plots the results. It seems the digital
> temperature sensors are located nearer the surface of the chip, or
> perhaps are isolated thermally somehow, since they respond much faster
> to a change in the load average. 

Yes they should be somewhere in the core imho.

> I did not test whether the
> temperatures respond differently to a load applied to just one CPU.
> Also, I do not know why the w83627ehf reports two temperatures from
> the athlon 64 x2. It may be the processor has two analog temperature
> pins. 

Yes it has two analog pins.

> However, the temperatures are always within 1 degree C of each
> other.

I think thats because of the load balancing.

Many thanks for the test. Now we know:

1) it works on single core
2) it works on dualcore
3) it works on 2x CPU
4) it shoud work on 2x dualcore ;)

Just a curios did you test with latest version :) ? (it has dword reads for temps)

Regards
Rudolf

