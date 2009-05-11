From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 11 May 2009 08:55:07 +0000
Subject: Re: [lm-sensors] 5VSB computing on it87
Message-Id: <20090511105507.0bbdc850@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU120-W7191DFD982F4E48F88CBAD8630@phx.gbl>
In-Reply-To: <BLU120-W7191DFD982F4E48F88CBAD8630@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 11 May 2009 10:07:30 +0200, Mr. Tux wrote:
> My Foxconn A7GM-S keep showing the wrong Voltage of 5VSB sensor.
> 
> This one shows up in BIOS as well, so it is connected and should indicate about 5.02V
> 
> But 'sensors' with it87 module loaded keeps showing 6.85V - how to change the compute
> line in order to get the 5.02V?
> 
> At the moment the compute line is the default:
> 
> compute in7  ((6.8/10)+1)*@ , @/((6.8/10)+1)

I can't help but notice that 6.85 = ((6.8/10)+1)*4.08. The IT87xxF
chips have a 4.08V DAC, meaning that this input channel is saturated.
Thus I pretty much doubt it corresponds to your 5VSB line.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
