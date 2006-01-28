From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 28 Jan 2006 14:05:01 +0000
Subject: [lm-sensors] wrong readings for w83627ehf on p5mt-m - solution
Message-Id: <43DB7A0D.6020901@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <43DA95AC.70504@sh.cvut.cz>
In-Reply-To: <43DA95AC.70504@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Rudolf, Alexander,
> 
> 
>>I think I know what happen. The chip is not used at all.
>>You should have there W83792AD on board. Can you check?
>>It should be square with like total 48legs. If yes I will
>>contact Asus and ask them how to unhide it.
> 
> 
> Indeed, the manual for the Asus P5MT-M mentions a Winbond W83792D chip
> for voltage and fan monitoring. They don't mention temperature, but
> they do mention the existence of a multiplexer in front of the SMBus.
> Without additional information regarding this multiplexer, there's
> nothing we can do.

Maybe it can be "fixed" by BIOS update?

Alexander if it is possible can you try that? (And if it is not too much work)
Thanks,

regards
Rudolf

