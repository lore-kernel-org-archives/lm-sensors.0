From: "Jan Beulich" <JBeulich@novell.com>
Date: Mon, 11 Oct 2010 06:51:00 +0000
Subject: Re: [lm-sensors] [PATCH] coretemp: fix reading of microcode
Message-Id: <4CB2CFF4020000780001C259@vpn.id2.novell.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4CADB0A1020000780001B335@vpn.id2.novell.com>
In-Reply-To: <4CADB0A1020000780001B335@vpn.id2.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>>> On 09.10.10 at 20:44, Guenter Roeck <guenter.roeck@ericsson.com> wrote:
> Turns out the ucode revision is already available via 
> ucode_cpu_info[cpu].cpu_sig.rev
> unless I am missing something.

But you're not suggesting to make coretemp.ko depend on
microcode.ko, are you?

Jan


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
