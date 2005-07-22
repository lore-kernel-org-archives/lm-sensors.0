From: jcromie@divsol.com (Jim Cromie)
Date: Fri, 22 Jul 2005 17:02:32 +0000
Subject: [lm-sensors] [patch]  KERNELVERSION=2.6.12-something make
Message-Id: <42E10A6D.1080404@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42E04664.3020001@divsol.com>
In-Reply-To: <42E04664.3020001@divsol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>Hi again Jim,
>
>On 2005-07-22, Jim Cromie wrote:
>  
>
>>attached patches allow making with setting in environment.
>>    
>>
>
>Note that this is only needed for Linux 2.4 kernels anyway, which
>doesn't seem to be your case.
>
>  
>
true.  when I do make user, no kernel headers are used,
so no FC-3 stuff fouls the nest.

FWIW:  I just tried to stuff this into Makefile, to automate the clue-stick
you poked me with:

ifneq (,$(findstring 2.6 , $(KERNELVERSION)))
    ifneq (,$(findstring 'user', $(MAKECMDGOALS)))
        $(error 'only user* targets needed/supported for 2.6 builds')
    endif
endif

obviously, it didnt work, or Id have sent a patch.
Can you fit it in the proper place, or advize where it belongs ?

>--
>Jean Delvare
>
>  
>

