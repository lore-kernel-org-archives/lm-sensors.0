From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 03 May 2008 07:18:31 +0000
Subject: Re: [lm-sensors] sensors-detect killed my CPU
Message-Id: <20080503091831.30cef838@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <481B851A.10800@ag-web.biz>
In-Reply-To: <481B851A.10800@ag-web.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Achim,

On Fri, 02 May 2008 23:18:18 +0200, Achim Gottinger wrote:
> I just ran sensors-detect on my phenom system (9850BE, Sapphire AM2RD790 
> Board, 2x1GB Crucial Ballistix DDR2-6400). It froze during SMbus scan 
> and now the cpu seems to be defect.
> The board stucks at C1 state during post, means it's a probem with the 
> memory substytem.
> I tried the cpu in another board (M3A) and no post here also. The system 
> works fine with an 9600BE so it's definately the cpu, whom died during 
> the sensors-detect run.

Hmm, that's bad. First report of this type as far as I remember. Which
version of sensors-detect did you run exactly?

Do you know if the Sapphire AM2RD790 has some special chip on the
SMBus? I see that this board is "the clear choice for overclocking
enthusiasts", maybe some overclocking chip on the SMBus was accessed
during SMBus probing of sensors-detect and it didn't like that... Do
you have a contact at Sapphire who could answer such technical
questions?

Was the CPU overclocked at the time you ran sensors-detect?

If you can provide the dmidecode output for the Sapphire AM2RD790,
maybe we can blacklist it in sensors-detect or even prevent the SMBus
driver from loading (we'll need the output of lspci -nnv for that). In
the meantime I'll put a note on our website so that other users don't
kill their CPUs too.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
