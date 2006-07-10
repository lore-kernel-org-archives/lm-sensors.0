From: Hubert.Li@Resilience.com (Hubert Li)
Date: Mon, 10 Jul 2006 02:42:39 +0000
Subject: [lm-sensors] Unresolved symbols in i2c-ipmi
Message-Id: <1152499360.2446.41.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <1152258427.2658.21.camel@localhost.localdomain>
In-Reply-To: <1152258427.2658.21.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Thank you for the help. I added linux/modversions.h into i2c-impi.c, and
then test it again, but still got the same error.

Br,
Hubert

? 2006-07-09?? 21:22 +0200?Rudolf Marek???
> Hello Hubert,
> 
> Sorry for the delay.
> 
> > ipmi_destroy_user_Rsmp_74848fb7
> 
> It seems like modvesions problem to me. Does the i2c-impi directly include the
> modversions.h file?
> 
> Anyway, you have the RedHat E. Linux so I would suggest to ask RedHat for that
> (or impi people)
> 
> The kernel 2.4.21 is very old and unfortunately I cannot recall anything special
> about it. I would focus on the modversion problems -> most likely it is the case
> of troubles.
> 
> I hope it helps,
> 
> Regards
> Rudolf
> 


