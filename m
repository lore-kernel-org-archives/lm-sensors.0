From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: decode-edid perl problems
Message-Id: <20030720235806.775f944a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F19DBE5.7070508@paradyne.com>
In-Reply-To: <3F19DBE5.7070508@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Really strange. This is supposed to work with perl 5.005_03. Please
> try adding a third parameter to the syswrite calls:
>   syswrite PIPE, "\n";
> becomes:
>   syswrite (PIPE, "\n", length ("\n"));
> and so on.
> 
> In sensors-detect we use that form and it seem to work for you. If it
> works I'll commit the changes.

I just realized I should be using print, not syswrite, so you may check
just to increase our knowledge, but the fix I'll commit will be
different anyway.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
