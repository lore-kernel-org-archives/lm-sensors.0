From: Harry G McGavran Jr <w5pny@arrl.net>
Date: Fri, 15 Apr 2011 15:25:27 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110415152527.B35411A9866@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 14 Apr 2011 09:57:23 +0200 Jean Delvare wrote:
> Hi Harry,
   .
   .
   .
> 
> While the EMC6W201 is a pretty complex chip with many advanced
> features, basic monitoring of voltages, fans and temperatures shouldn't
> be that hard to implement.
> 

FWIW: I installed the i8kutils and driver and forceloaded the driver.
They seem to be able to read the fan speeds, but not the CPU 
temperature.  So, there is some code around that works with
this machine, but not entirely.  That may be a place to look too.

	Harry McGavran



-- 

Harry G. McGavran, Jr.

E-mail: w5pny@arrl.net




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
