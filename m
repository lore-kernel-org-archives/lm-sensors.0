From: Rudolf Marek <r.marek@assembler.cz>
Date: Sun, 07 Oct 2007 11:51:45 +0000
Subject: Re: [lm-sensors] k8temp does produce sensible results
Message-Id: <4708C851.1090300@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <47014943.9080104@fouter.net>
In-Reply-To: <47014943.9080104@fouter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dick,

> Does anybody know what is happening here and whether there is any resolution to 
> this problem available?
> 

Hello,

Some CPUs have known Errata which says that thermal sensor is unreliable. I
think this is your case unfortunately. Did sensors detect found some other sensor?

I know that ATI690 has some internal sensor chip too but I dont have the
documentation.

Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
