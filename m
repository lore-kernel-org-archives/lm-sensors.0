From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 02 Sep 2007 15:34:51 +0000
Subject: Re: [lm-sensors] [PATCH] Allow writing of negative trigger
Message-Id: <20070902173451.1117652d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070816081353.GF10132@tweety>
In-Reply-To: <20070816081353.GF10132@tweety>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 2 Sep 2007 11:06:42 -0400, Mark M. Hoffman wrote:
> * Jean Delvare <khali@linux-fr.org> [2007-08-27 10:17:14 +0200]:
> > Unfortunately, I have neither lm77 nor lm93 dumps to load i2c-stub
> > with. If anyone has such dumps and could share them...
> 
> BTW: you don't need them in this case.  The following works just fine...
> 
> # modprobe i2c-stub chip-addr=0x2c
> 
> # modprobe lm93 force_lm93=1,0x2c	# replace '1' w/ ID of stub

Ah, good point, I didn't think about the force parameter.

That being said, I would still enjoy having dumps of these chips for
more general testing where forcing an empty chip isn't sufficient.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
