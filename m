From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <20040127230516.48410bf9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[Don't forget to CC: the mailing list on replies please]

> >>Basically this means the following conversion table, if I'm not
> >>mistaking:
> >>0..2 -> 1 (div=2)
> >>3..4 -> 2 (div=4)
> >>5+   -> 3 (div=8)
> 
> I don't think, that this a good idea. If you recall an email from me
> about VERAX fans, which supply 9 times as many pulses per rotation as
> normal fans do, those fans would require a div of 18. This value would
> then silently be converted to div = 8 and results in less then one
> halve of the actual fan rpm.
> 
> In my opinion, the driver should complain about any div values it
> doesn't support, and simply do nothing as it wouldn't be what the user
> expected, anyway. Therefore, once again the question: How should the
> driver inform about/react on unsupported div values?

Well, this makes sense, you're right. You get the point.

In my mind, there was no possibility to return an error code, so you had
to accomodate the best you could with the input, and keep quiet. By the
way, what does conretely happen if you try to write a wrong value to the
sysfs file?

> >>Should be fast and efficient enough, and keeps the code clear (IMHO
> >>at least).
> 
> I don't see there the need for more efficient coding at that location,
> as it typically gets executed once per system start. Furthermore, I
> think that the switch statement is more readable in my simple case.

Agreed, because you treat only three (valid) values. Since my idea was
to accept them all, I couldn't handle them with a switch, it just
wouldn't have made sense. But a switch is fine for your method.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
