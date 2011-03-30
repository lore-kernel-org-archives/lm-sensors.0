From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 30 Mar 2011 23:51:47 +0000
Subject: Re: [lm-sensors] testing "w83627ehf" on Asrock ION 330 HT
Message-Id: <20110330235147.GA18806@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <201103310124.08484.tomasdeltell@gmx.es>
In-Reply-To: <201103310124.08484.tomasdeltell@gmx.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Wed, Mar 30, 2011 at 07:24:08PM -0400, Tomàs Deltell Bonell wrote:
> I'm trying to install w83627ehf driver on my Asrock ION 330 HT with Mandriva 
> 2010.2, kernel 2.6.33.7 and lm-sensors 3.1.2. When i try to compile i get this 
> error:
> 
> $ make
>   CC [M]  /home/user/w83627ehf/w83627ehf.o
> /home/user/w83627ehf/w83627ehf.c: on function ‘w83627ehf_find’:
> /home/user/w83627ehf/w83627ehf.c:2385: error: implicit declaration of 
> ‘pr_warn’ function
> make[2]: *** [/home/user/w83627ehf/w83627ehf.o] Error 1
> make[1]: *** [_module_/home/user/w83627ehf] Error 2
> make: *** [modules] Error 2
> 
> and i don't know how to continue
> 
Just replace pr_warn with pr_warning. Looks like pr_warn was only introduced
in a later kernel version. It maps to pr_warning, so it is ok to replace it.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
